" VimTeX - LaTeX plugin for Vim
"
" Maintainer: Karl Yngve Lervåg
" Email:      karl.yngve@gmail.com
"

function! vimtex#compiler#latexrun#init(options) abort " {{{1
  let l:compiler = deepcopy(s:compiler)

  call l:compiler.init(extend(a:options,
        \ get(g:, 'vimtex_compiler_latexrun', {}), 'keep'))

  return l:compiler
endfunction

" }}}1

let s:compiler = {
      \ 'name' : 'latexrun',
      \ 'root' : '',
      \ 'target' : '',
      \ 'target_path' : '',
      \ 'build_dir' : '',
      \ 'output' : tempname(),
      \ 'options' : [
      \   '--verbose-cmds',
      \   '--latex-args="-synctex=1"',
      \ ],
      \}

function! s:compiler.init(options) abort dict " {{{1
  call extend(self, a:options)

  if !executable('latexrun')
    call vimtex#log#warning('latexrun is not executable!')
    throw 'VimTeX: Requirements not met'
  endif

  " Check if environment variable exists; it has the highest priority
  if !empty($VIMTEX_OUTPUT_DIRECTORY)
    if !empty(self.build_dir)
          \ && (self.build_dir !=# $VIMTEX_OUTPUT_DIRECTORY)
      call vimtex#log#warning(
            \ 'Setting VIMTEX_OUTPUT_DIRECTORY overrides build_dir!',
            \ 'Changed build_dir from: ' . self.build_dir,
            \ 'Changed build_dir to: ' . $VIMTEX_OUTPUT_DIRECTORY)
    endif
    let self.build_dir = $VIMTEX_OUTPUT_DIRECTORY
  endif

  let l:backend = has('nvim') ? 'nvim' : 'jobs'
  call extend(self, deepcopy(s:compiler_{l:backend}))
endfunction

" }}}1

function! s:compiler.build_cmd() abort dict " {{{1
  let l:cmd = 'latexrun'

  for l:opt in self.options
    let l:cmd .= ' ' . l:opt
  endfor

  let l:cmd .= ' --latex-cmd ' . self.get_engine()

  let l:cmd .= ' -O '
        \ . (empty(self.build_dir) ? '.' : fnameescape(self.build_dir))

  return l:cmd . ' ' . vimtex#util#shellescape(self.target)
endfunction

" }}}1
function! s:compiler.get_engine() abort dict " {{{1
  return get(extend(g:vimtex_compiler_latexrun_engines,
        \ {
        \  '_'                : 'pdflatex',
        \  'pdflatex'         : 'pdflatex',
        \  'lualatex'         : 'lualatex',
        \  'xelatex'          : 'xelatex',
        \ }, 'keep'), self.tex_program, '_')
endfunction

" }}}1
function! s:compiler.cleanup() abort dict " {{{1
  " Pass
endfunction

" }}}1
function! s:compiler.pprint_items() abort dict " {{{1
  let l:configuration = []

  if !empty(self.build_dir)
    call add(l:configuration, ['build_dir', self.build_dir])
  endif
  call add(l:configuration, ['latexrun options', self.options])
  call add(l:configuration, ['latexrun engine', self.get_engine()])

  let l:list = []
  call add(l:list, ['output', self.output])

  if self.target_path !=# b:vimtex.tex
    call add(l:list, ['root', self.root])
    call add(l:list, ['target', self.target_path])
  endif

  call add(l:list, ['configuration', l:configuration])

  if has_key(self, 'process')
    call add(l:list, ['process', self.process])
  endif

  if has_key(self, 'job')
    call add(l:list, ['cmd', self.cmd])
  endif

  return l:list
endfunction

" }}}1

function! s:compiler.clean(...) abort dict " {{{1
  let l:cmd = (has('win32')
        \   ? 'cd /D "' . self.root . '" & '
        \   : 'cd ' . vimtex#util#shellescape(self.root) . '; ')
        \ . 'latexrun --clean-all'
        \ . ' -O '
        \   . (empty(self.build_dir) ? '.' : fnameescape(self.build_dir))
  call vimtex#process#run(l:cmd)

  call vimtex#log#info('Compiler clean finished')
endfunction

" }}}1
function! s:compiler.start(...) abort dict " {{{1
  call self.exec()

  call vimtex#log#info('Compiler started in background')
endfunction

" }}}1
function! s:compiler.start_single() abort dict " {{{1
  call self.start()
endfunction

" }}}1
function! s:compiler.stop() abort dict " {{{1
  if self.is_running()
    call self.kill()
  endif
endfunction

" }}}1
function! s:compiler.wait() abort dict " {{{1
  for l:dummy in range(50)
    sleep 100m
    if !self.is_running()
      return
    endif
  endfor

  call self.stop()
endfunction

" }}}1

let s:compiler_jobs = {}
function! s:compiler_jobs.exec() abort dict " {{{1
  let self.cmd = self.build_cmd()
  let l:cmd = has('win32')
        \ ? 'cmd /s /c "' . self.cmd . '"'
        \ : ['sh', '-c', self.cmd]
  let l:options = {
        \ 'out_io' : 'file',
        \ 'err_io' : 'file',
        \ 'out_name' : self.output,
        \ 'err_name' : self.output,
        \}

  let s:cb_target = self.target_path !=# b:vimtex.tex ? self.target_path : ''
  let l:options.exit_cb = function('s:callback')

  call vimtex#paths#pushd(self.root)
  let self.job = job_start(l:cmd, l:options)
  call vimtex#paths#popd()
endfunction

" }}}1
function! s:compiler_jobs.kill() abort dict " {{{1
  call job_stop(self.job)
endfunction

" }}}1
function! s:compiler_jobs.is_running() abort dict " {{{1
  return has_key(self, 'job') && job_status(self.job) ==# 'run'
endfunction

" }}}1
function! s:compiler_jobs.get_pid() abort dict " {{{1
  return has_key(self, 'job')
        \ ? get(job_info(self.job), 'process') : 0
endfunction

" }}}1
function! s:callback(ch, msg) abort " {{{1
  call vimtex#compiler#callback(!vimtex#qf#inquire(s:cb_target))
endfunction

" }}}1

let s:compiler_nvim = {}
function! s:compiler_nvim.exec() abort dict " {{{1
  let self.cmd = self.build_cmd()
  let l:cmd = has('win32')
        \ ? 'cmd /s /c "' . self.cmd . '"'
        \ : ['sh', '-c', self.cmd]

  let l:shell = {
        \ 'on_stdout' : function('s:callback_nvim_output'),
        \ 'on_stderr' : function('s:callback_nvim_output'),
        \ 'on_exit' : function('s:callback_nvim_exit'),
        \ 'cwd' : self.root,
        \ 'target' : self.target_path,
        \ 'output' : self.output,
        \}

  let self.job = jobstart(l:cmd, l:shell)
endfunction

" }}}1
function! s:compiler_nvim.kill() abort dict " {{{1
  call jobstop(self.job)
endfunction

" }}}1
function! s:compiler_nvim.is_running() abort dict " {{{1
  try
    let pid = jobpid(self.job)
    return 1
  catch
    return 0
  endtry
endfunction

" }}}1
function! s:compiler_nvim.get_pid() abort dict " {{{1
  try
    return jobpid(self.job)
  catch
    return 0
  endtry
endfunction

" }}}1
function! s:callback_nvim_output(id, data, event) abort dict " {{{1
  if !empty(a:data)
    call writefile(filter(a:data, '!empty(v:val)'), self.output, 'a')
  endif
endfunction

" }}}1
function! s:callback_nvim_exit(id, data, event) abort dict " {{{1
  if !exists('b:vimtex.tex') | return | endif

  let l:target = self.target !=# b:vimtex.tex ? self.target : ''
  call vimtex#compiler#callback(!vimtex#qf#inquire(l:target))
endfunction

" }}}1

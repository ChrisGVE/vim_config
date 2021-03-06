" vim-airline template by chartoin (http://github.com/chartoin)
" Base 16 Adwaita Scheme by Rory Bradford (https://github.com/roryrjb)
let g:airline#themes#base16_adwaita#palette = {}
let s:gui00 = "#2D3234"
let s:gui01 = "#33393B"
let s:gui02 = "#4B5356"
let s:gui03 = "#566164"
let s:gui04 = "#919494"
let s:gui05 = "#C5C6C5"
let s:gui06 = "#D3D4D5"
let s:gui07 = "#EEEEEC"
let s:gui08 = "#FFA500"
let s:gui09 = "#FFFF60"
let s:gui0A = "#91EE6F"
let s:gui0B = "#6FEE91"
let s:gui0C = "#6F91B4"
let s:gui0D = "#916FB4"
let s:gui0E = "#EE6F91"
let s:gui0F = "#EE6F6F"

let s:cterm00 = 0
let s:cterm01 = 59
let s:cterm02 = 59
let s:cterm03 = 102
let s:cterm04 = 145
let s:cterm05 = 188
let s:cterm06 = 188
let s:cterm07 = 15
let s:cterm08 = 180
let s:cterm09 = 186
let s:cterm0A = 150
let s:cterm0B = 115
let s:cterm0C = 110
let s:cterm0D = 140
let s:cterm0E = 175
let s:cterm0F = 174

let s:N1   = [ s:gui01, s:gui0B, s:cterm01, s:cterm0B ]
let s:N2   = [ s:gui06, s:gui02, s:cterm06, s:cterm02 ]
let s:N3   = [ s:gui09, s:gui01, s:cterm09, s:cterm01 ]
let g:airline#themes#base16_adwaita#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)

let s:I1   = [ s:gui01, s:gui0D, s:cterm01, s:cterm0D ]
let s:I2   = [ s:gui06, s:gui02, s:cterm06, s:cterm02 ]
let s:I3   = [ s:gui09, s:gui01, s:cterm09, s:cterm01 ]
let g:airline#themes#base16_adwaita#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)

let s:R1   = [ s:gui01, s:gui08, s:cterm01, s:cterm08 ]
let s:R2   = [ s:gui06, s:gui02, s:cterm06, s:cterm02 ]
let s:R3   = [ s:gui09, s:gui01, s:cterm09, s:cterm01 ]
let g:airline#themes#base16_adwaita#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)

let s:V1   = [ s:gui01, s:gui0E, s:cterm01, s:cterm0E ]
let s:V2   = [ s:gui06, s:gui02, s:cterm06, s:cterm02 ]
let s:V3   = [ s:gui09, s:gui01, s:cterm09, s:cterm01 ]
let g:airline#themes#base16_adwaita#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)

let s:IA1   = [ s:gui05, s:gui01, s:cterm05, s:cterm01 ]
let s:IA2   = [ s:gui05, s:gui01, s:cterm05, s:cterm01 ]
let s:IA3   = [ s:gui05, s:gui01, s:cterm05, s:cterm01 ]
let g:airline#themes#base16_adwaita#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)

" Here we define the color map for ctrlp.  We check for the g:loaded_ctrlp
" variable so that related functionality is loaded iff the user is using
" ctrlp. Note that this is optional, and if you do not define ctrlp colors
" they will be chosen automatically from the existing palette.
if !get(g:, 'loaded_ctrlp', 0)
  finish
endif
let g:airline#themes#base16_adwaita#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
      \ [ s:gui07, s:gui02, s:cterm07, s:cterm02, '' ],
      \ [ s:gui07, s:gui04, s:cterm07, s:cterm04, '' ],
      \ [ s:gui05, s:gui01, s:cterm05, s:cterm01, 'bold' ])

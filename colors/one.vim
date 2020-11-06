" Name:    one vim colorscheme
" Author:  Ramzi Akremi
" License: MIT
" Version: 1.1.1-pre

" Global setup =============================================================={{{

if exists("*<SID>X")
  delf <SID>X
  delf <SID>XAPI
  delf <SID>rgb
  delf <SID>color
  delf <SID>rgb_color
  delf <SID>rgb_level
  delf <SID>rgb_number
  delf <SID>grey_color
  delf <SID>grey_level
  delf <SID>grey_number
endif

hi clear
syntax reset
if exists('g:colors_name')
  unlet g:colors_name
endif
let g:colors_name = 'one'

if !exists('g:one_allow_italics')
  let g:one_allow_italics = 0
endif

let s:italic = ''
if g:one_allow_italics == 1
  let s:italic = 'italic'
endif

if has('gui_running') || has('termguicolors') || &t_Co == 88 || &t_Co == 256
  " functions
  " returns an approximate grey index for the given grey level

  " Utility functions -------------------------------------------------------{{{
  fun <SID>grey_number(x)
    if &t_Co == 88
      if a:x < 23
        return 0
      elseif a:x < 69
        return 1
      elseif a:x < 103
        return 2
      elseif a:x < 127
        return 3
      elseif a:x < 150
        return 4
      elseif a:x < 173
        return 5
      elseif a:x < 196
        return 6
      elseif a:x < 219
        return 7
      elseif a:x < 243
        return 8
      else
        return 9
      endif
    else
      if a:x < 14
        return 0
      else
        let l:n = (a:x - 8) / 10
        let l:m = (a:x - 8) % 10
        if l:m < 5
          return l:n
        else
          return l:n + 1
        endif
      endif
    endif
  endfun

  " returns the actual grey level represented by the grey index
  fun <SID>grey_level(n)
    if &t_Co == 88
      if a:n == 0
        return 0
      elseif a:n == 1
        return 46
      elseif a:n == 2
        return 92
      elseif a:n == 3
        return 115
      elseif a:n == 4
        return 139
      elseif a:n == 5
        return 162
      elseif a:n == 6
        return 185
      elseif a:n == 7
        return 208
      elseif a:n == 8
        return 231
      else
        return 255
      endif
    else
      if a:n == 0
        return 0
      else
        return 8 + (a:n * 10)
      endif
    endif
  endfun

  " returns the palette index for the given grey index
  fun <SID>grey_color(n)
    if &t_Co == 88
      if a:n == 0
        return 16
      elseif a:n == 9
        return 79
      else
        return 79 + a:n
      endif
    else
      if a:n == 0
        return 16
      elseif a:n == 25
        return 231
      else
        return 231 + a:n
      endif
    endif
  endfun

  " returns an approximate color index for the given color level
  fun <SID>rgb_number(x)
    if &t_Co == 88
      if a:x < 69
        return 0
      elseif a:x < 172
        return 1
      elseif a:x < 230
        return 2
      else
        return 3
      endif
    else
      if a:x < 75
        return 0
      else
        let l:n = (a:x - 55) / 40
        let l:m = (a:x - 55) % 40
        if l:m < 20
          return l:n
        else
          return l:n + 1
        endif
      endif
    endif
  endfun

  " returns the actual color level for the given color index
  fun <SID>rgb_level(n)
    if &t_Co == 88
      if a:n == 0
        return 0
      elseif a:n == 1
        return 139
      elseif a:n == 2
        return 205
      else
        return 255
      endif
    else
      if a:n == 0
        return 0
      else
        return 55 + (a:n * 40)
      endif
    endif
  endfun

  " returns the palette index for the given R/G/B color indices
  fun <SID>rgb_color(x, y, z)
    if &t_Co == 88
      return 16 + (a:x * 16) + (a:y * 4) + a:z
    else
      return 16 + (a:x * 36) + (a:y * 6) + a:z
    endif
  endfun

  " returns the palette index to approximate the given R/G/B color levels
  fun <SID>color(r, g, b)
    " get the closest grey
    let l:gx = <SID>grey_number(a:r)
    let l:gy = <SID>grey_number(a:g)
    let l:gz = <SID>grey_number(a:b)

    " get the closest color
    let l:x = <SID>rgb_number(a:r)
    let l:y = <SID>rgb_number(a:g)
    let l:z = <SID>rgb_number(a:b)

    if l:gx == l:gy && l:gy == l:gz
      " there are two possibilities
      let l:dgr = <SID>grey_level(l:gx) - a:r
      let l:dgg = <SID>grey_level(l:gy) - a:g
      let l:dgb = <SID>grey_level(l:gz) - a:b
      let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
      let l:dr = <SID>rgb_level(l:gx) - a:r
      let l:dg = <SID>rgb_level(l:gy) - a:g
      let l:db = <SID>rgb_level(l:gz) - a:b
      let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
      if l:dgrey < l:drgb
        " use the grey
        return <SID>grey_color(l:gx)
      else
        " use the color
        return <SID>rgb_color(l:x, l:y, l:z)
      endif
    else
      " only one possibility
      return <SID>rgb_color(l:x, l:y, l:z)
    endif
  endfun

  " returns the palette index to approximate the 'rrggbb' hex string
  fun <SID>rgb(rgb)
    let l:r = ('0x' . strpart(a:rgb, 0, 2)) + 0
    let l:g = ('0x' . strpart(a:rgb, 2, 2)) + 0
    let l:b = ('0x' . strpart(a:rgb, 4, 2)) + 0

    return <SID>color(l:r, l:g, l:b)
  endfun

  " sets the highlighting for the given group
  fun <SID>XAPI(group, fg, bg, attr)
    let l:attr = a:attr
    if g:one_allow_italics == 0 && l:attr ==? 'italic'
      let l:attr= 'none'
    endif

    let l:bg = ""
    let l:fg = ""
    let l:decoration = ""

    if a:bg != ''
      let l:bg = " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg)
    endif

    if a:fg != ''
      let l:fg = " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg)
    endif

    if a:attr != ''
      let l:decoration = " gui=" . l:attr . " cterm=" . l:attr
    endif

    let l:exec = l:fg . l:bg . l:decoration

    if l:exec != ''
      exec "hi " . a:group . l:exec
    endif

  endfun

  " Highlight function
  " the original one is borrowed from mhartington/oceanic-next
  function! <SID>X(group, fg, bg, attr, ...)
    let l:attrsp = get(a:, 1, "")
    " fg, bg, attr, attrsp
    if !empty(a:fg)
      exec "hi " . a:group . " guifg=" .  a:fg[0]
      exec "hi " . a:group . " ctermfg=" . a:fg[1]
    endif
    if !empty(a:bg)
      exec "hi " . a:group . " guibg=" .  a:bg[0]
      exec "hi " . a:group . " ctermbg=" . a:bg[1]
    endif
    if a:attr != ""
      exec "hi " . a:group . " gui=" .   a:attr
      exec "hi " . a:group . " cterm=" . a:attr
    endif
    if !empty(l:attrsp)
      exec "hi " . a:group . " guisp=" . l:attrsp[0]
    endif
  endfunction

  " }}}

  " Color definition --------------------------------------------------------{{{
  let s:gray_1  = ['#494b53', '23']
  let s:gray_2  = ['#696c77', '60']
  let s:gray_3  = ['#9e9e9e', '247']
  let s:gray_4  = ['#a0a1a7', '145']
  let s:gray_5  = ['#c2c2c3', '250']
  let s:gray_6  = ['#d0d0d0', '251']
  let s:gray_7  = ['#e7e9e1', '188']
  let s:gray_8  = ['#f0f0f0', '254']

  let s:cyan_1  = ['#0184bc', '31']
  let s:cyan_2  = ['#0083be', '31']

  let s:blue_1  = ['#4078f2', '33']
  let s:blue_2  = ['#526fff', '63']

  let s:purple  = ['#a626a4', '127']
  let s:green   = ['#50a14f', '71']

  let s:red_1   = ['#ca1243', '160']
  let s:red_2   = ['#e45649', '166']

  let s:brown_1 = ['#986801', '94']
  let s:brown_2 = ['#c18401', '136']

  let s:syntax_fg = s:gray_1
  " }}}

  " Vim editor color --------------------------------------------------------{{{
  call <sid>X('Normal',       s:syntax_fg, s:gray_8,  '')
  call <sid>X('bold',         '',          '',        'bold')
  call <sid>X('ColorColumn',  '',          s:gray_8,  '')
  call <sid>X('Conceal',      s:gray_2,    s:gray_8,  'bold')
  call <sid>X('Cursor',       '',          s:blue_2,  '')
  call <sid>X('CursorIM',     '',          '',        '')
  call <sid>X('CursorColumn', '',          s:gray_8,  '')
  call <sid>X('CursorLine',   '',          s:gray_8,  'none')
  call <sid>X('Directory',    s:blue_1,    '',        '')
  call <sid>X('ErrorMsg',     s:red_2,     s:gray_8,  'none')
  call <sid>X('VertSplit',    s:gray_7,    '',        'none')
  call <sid>X('Folded',       s:syntax_fg, s:gray_6,  'none')
  call <sid>X('FoldColumn',   s:gray_3,    s:gray_8,  '')
  call <sid>X('IncSearch',    s:gray_8,   s:green,        '')
  call <sid>X('Substitute',   s:gray_8,   s:green,        '')
  call <sid>X('LineNr',       s:gray_5,    '',        '')
  call <sid>X('CursorLineNr', s:syntax_fg, s:gray_8,  'none')
  call <sid>X('MatchParen',   s:red_2,     s:gray_8,  'underline,bold')
  call <sid>X('Italic',       '',          '',        s:italic)
  call <sid>X('ModeMsg',      s:syntax_fg, '',        '')
  call <sid>X('MoreMsg',      s:syntax_fg, '',        '')
  call <sid>X('NonText',      s:gray_4,    '',        'none')
  call <sid>X('PMenu',        '',          s:gray_6,  '')
  call <sid>X('PMenuSel',     '',          s:gray_5,  '')
  call <sid>X('PMenuSbar',    '',          s:gray_8,  '')
  call <sid>X('PMenuThumb',   '',          s:gray_1,  '')
  call <sid>X('Question',     s:blue_1,    '',        '')
  call <sid>X('Search',       s:gray_8,    s:brown_2, '')
  call <sid>X('SpecialKey',   s:gray_6,    '',        'none')
  call <sid>X('Whitespace',   s:gray_6,    '',        'none')
  call <sid>X('StatusLine',   s:syntax_fg, s:gray_6,  'none')
  call <sid>X('StatusLineNC', s:syntax_fg, s:gray_5,  '')
  call <sid>X('TabLine',      s:gray_2,    s:gray_6,  'none')
  call <sid>X('TabLineFill',  s:gray_4,    s:gray_6,  'none')
  call <sid>X('TabLineSel',   s:gray_8,    s:blue_1,  '')
  call <sid>X('Title',        s:syntax_fg, '',        'bold')
  call <sid>X('Visual',       '',          s:gray_6,  '')
  call <sid>X('VisualNOS',    '',          s:gray_6,  '')
  call <sid>X('WarningMsg',   s:red_2,     '',        '')
  call <sid>X('TooLong',      s:red_2,     '',        '')
  call <sid>X('WildMenu',     s:syntax_fg, s:gray_4,  '')
  call <sid>X('SignColumn',   '',          s:gray_8,  '')
  call <sid>X('Special',      s:blue_1,    '',        '')
  " }}}

  " Vim Help highlighting ---------------------------------------------------{{{
  call <sid>X('helpCommand',      s:brown_2, '', '')
  call <sid>X('helpExample',      s:brown_2, '', '')
  call <sid>X('helpHeader',       s:gray_1,  '', 'bold')
  call <sid>X('helpSectionDelim', s:gray_4,  '', '')
  " }}}

  " Standard syntax highlighting --------------------------------------------{{{
  call <sid>X('Comment',        s:gray_4,  '',       s:italic)
  call <sid>X('Constant',       s:green,   '',       '')
  call <sid>X('String',         s:green,   '',       '')
  call <sid>X('Character',      s:green,   '',       '')
  call <sid>X('Number',         s:brown_1, '',       '')
  call <sid>X('Boolean',        s:brown_1, '',       '')
  call <sid>X('Float',          s:brown_1, '',       '')
  call <sid>X('Identifier',     s:red_2,   '',       'none')
  call <sid>X('Function',       s:blue_1,  '',       '')
  call <sid>X('Statement',      s:purple,  '',       'none')
  call <sid>X('Conditional',    s:purple,  '',       '')
  call <sid>X('Repeat',         s:purple,  '',       '')
  call <sid>X('Label',          s:purple,  '',       '')
  call <sid>X('Operator',       s:blue_2,  '',       'none')
  call <sid>X('Keyword',        s:red_2,   '',       '')
  call <sid>X('Exception',      s:purple,  '',       '')
  call <sid>X('PreProc',        s:brown_2, '',       '')
  call <sid>X('Include',        s:blue_1,  '',       '')
  call <sid>X('Define',         s:purple,  '',       'none')
  call <sid>X('Macro',          s:purple,  '',       '')
  call <sid>X('PreCondit',      s:brown_2, '',       '')
  call <sid>X('Type',           s:brown_2, '',       'none')
  call <sid>X('StorageClass',   s:brown_2, '',       '')
  call <sid>X('Structure',      s:brown_2, '',       '')
  call <sid>X('Typedef',        s:brown_2, '',       '')
  call <sid>X('Special',        s:blue_1,  '',       '')
  call <sid>X('SpecialChar',    '',        '',       '')
  call <sid>X('Tag',            '',        '',       '')
  call <sid>X('Delimiter',      '',        '',       '')
  call <sid>X('SpecialComment', '',        '',       '')
  call <sid>X('Debug',          '',        '',       '')
  call <sid>X('Underlined',     '',        '',       'underline')
  call <sid>X('Ignore',         '',        '',       '')
  call <sid>X('Error',          s:red_2,   s:gray_8, 'bold')
  call <sid>X('Todo',           s:purple,  s:gray_8, '')
  " }}}

  " Diff highlighting -------------------------------------------------------{{{
  call <sid>X('DiffAdd',         s:green,   s:gray_7, '')
  call <sid>X('DiffChange',      s:brown_1, s:gray_7, '')
  call <sid>X('DiffDelete',      s:red_2,   s:gray_7, '')
  call <sid>X('DiffText',        s:blue_1,  s:gray_7, '')
  call <sid>X('DiffAdded',       s:green,   s:gray_7, '')
  call <sid>X('DiffFile',        s:red_2,   s:gray_7, '')
  call <sid>X('DiffNewFile',     s:green,   s:gray_7, '')
  call <sid>X('DiffLine',        s:blue_1,  s:gray_7, '')
  call <sid>X('DiffRemoved',     s:red_2,   s:gray_7, '')
  " }}}
  "
  " GitGutter highlighting -------------------------------------------------------{{{
  call <sid>X('GitGutterAdd',    s:green,   s:gray_7, 'bold')
  call <sid>X('GitGutterChange', s:brown_2, s:gray_7, 'bold')
  call <sid>X('GitGutterDelete', s:red_1,   s:gray_7, 'bold')
  " }}}

  " C/C++ highlighting ------------------------------------------------------{{{
  call <sid>X('cInclude',          s:purple,  '', '')
  call <sid>X('cPreCondit',        s:purple,  '', '')
  call <sid>X('cPreConditMatch',   s:purple,  '', '')
  call <sid>X('cType',             s:purple,  '', '')
  call <sid>X('cStorageClass',     s:purple,  '', '')
  call <sid>X('cStructure',        s:purple,  '', '')
  call <sid>X('cOperator',         s:purple,  '', '')
  call <sid>X('cStatement',        s:purple,  '', '')
  call <sid>X('cTODO',             s:purple,  '', '')
  call <sid>X('cConstant',         s:brown_1, '', '')
  call <sid>X('cSpecial',          s:cyan_1,  '', '')
  call <sid>X('cSpecialCharacter', s:cyan_1,  '', '')
  call <sid>X('cString',           s:green,   '', '')
  call <sid>X('cppType',           s:purple,  '', '')
  call <sid>X('cppStorageClass',   s:purple,  '', '')
  call <sid>X('cppStructure',      s:purple,  '', '')
  call <sid>X('cppModifier',       s:purple,  '', '')
  call <sid>X('cppOperator',       s:purple,  '', '')
  call <sid>X('cppAccess',         s:purple,  '', '')
  call <sid>X('cppStatement',      s:purple,  '', '')
  call <sid>X('cppConstant',       s:red_2,   '', '')
  call <sid>X('cCppString',        s:green,   '', '')
  " }}}

  " JSON highlighting -------------------------------------------------------{{{
  call <sid>X('jsonCommentError',       s:gray_1,  '', ''        )
  call <sid>X('jsonKeyword',            s:red_2,   '', ''        )
  call <sid>X('jsonQuote',              s:gray_4,  '', ''        )
  call <sid>X('jsonTrailingCommaError', s:red_2,   '', 'reverse' )
  call <sid>X('jsonMissingCommaError',  s:red_2,   '', 'reverse' )
  call <sid>X('jsonNoQuotesError',      s:red_2,   '', 'reverse' )
  call <sid>X('jsonNumError',           s:red_2,   '', 'reverse' )
  call <sid>X('jsonString',             s:green,   '', ''        )
  call <sid>X('jsonBoolean',            s:purple,  '', ''        )
  call <sid>X('jsonNumber',             s:brown_1, '', ''        )
  call <sid>X('jsonStringSQError',      s:red_2,   '', 'reverse' )
  call <sid>X('jsonSemicolonError',     s:red_2,   '', 'reverse' )
  " }}}

  " Markdown highlighting ---------------------------------------------------{{{
  call <sid>X('markdownUrl',              s:gray_4,  '', '')
  call <sid>X('markdownBold',             s:brown_1, '', 'bold')
  call <sid>X('markdownItalic',           s:brown_1, '', 'bold')
  call <sid>X('markdownCode',             s:green,   '', '')
  call <sid>X('markdownCodeBlock',        s:red_2,   '', '')
  call <sid>X('markdownCodeDelimiter',    s:green,   '', '')
  call <sid>X('markdownHeadingDelimiter', s:red_1,   '', '')
  call <sid>X('markdownH1',               s:red_2,   '', '')
  call <sid>X('markdownH2',               s:red_2,   '', '')
  call <sid>X('markdownH3',               s:red_2,   '', '')
  call <sid>X('markdownH3',               s:red_2,   '', '')
  call <sid>X('markdownH4',               s:red_2,   '', '')
  call <sid>X('markdownH5',               s:red_2,   '', '')
  call <sid>X('markdownH6',               s:red_2,   '', '')
  call <sid>X('markdownListMarker',       s:red_2,   '', '')
  " }}}

  " Python highlighting -----------------------------------------------------{{{
  call <sid>X('pythonImport',          s:purple,  '', '')
  call <sid>X('pythonBuiltin',         s:cyan_1,  '', '')
  call <sid>X('pythonStatement',       s:purple,  '', '')
  call <sid>X('pythonParam',           s:brown_1, '', '')
  call <sid>X('pythonEscape',          s:red_2,   '', '')
  call <sid>X('pythonSelf',            s:gray_2,  '', s:italic)
  call <sid>X('pythonClass',           s:blue_1,  '', '')
  call <sid>X('pythonOperator',        s:purple,  '', '')
  call <sid>X('pythonEscape',          s:red_2,   '', '')
  call <sid>X('pythonFunction',        s:blue_1,  '', '')
  call <sid>X('pythonKeyword',         s:blue_1,  '', '')
  call <sid>X('pythonModule',          s:purple,  '', '')
  call <sid>X('pythonStringDelimiter', s:green,   '', '')
  call <sid>X('pythonSymbol',          s:cyan_1,  '', '')
  " }}}

  " Spelling highlighting ---------------------------------------------------{{{
  call <sid>X('SpellBad',   s:gray_8, s:red_2, '')
  call <sid>X('SpellLocal', s:gray_8, s:red_1, '')
  call <sid>X('SpellCap',   s:gray_8, s:red_2, '')
  call <sid>X('SpellRare',  s:gray_8, s:red_2, '')
  " }}}

  " Vim highlighting --------------------------------------------------------{{{
  call <sid>X('vimCommand',      s:purple, '', '')
  call <sid>X('vimCommentTitle', s:gray_4, '', 'bold')
  call <sid>X('vimFunction',     s:cyan_1, '', '')
  call <sid>X('vimFuncName',     s:purple, '', '')
  call <sid>X('vimHighlight',    s:blue_1, '', '')
  call <sid>X('vimLineComment',  s:gray_4, '', s:italic)
  call <sid>X('vimParenSep',     s:gray_2, '', '')
  call <sid>X('vimSep',          s:gray_2, '', '')
  call <sid>X('vimUserFunc',     s:cyan_1, '', '')
  call <sid>X('vimVar',          s:red_2,  '', '')
  " }}}

  " XML highlighting --------------------------------------------------------{{{
  call <sid>X('xmlAttrib',  s:brown_2, '', '')
  call <sid>X('xmlEndTag',  s:red_2,   '', '')
  call <sid>X('xmlTag',     s:red_2,   '', '')
  call <sid>X('xmlTagName', s:red_2,   '', '')
  " }}}

  " man highlighting --------------------------------------------------------{{{
  hi link manTitle String
  call <sid>X('manFooter', s:gray_4, '', '')
  " }}}

  " Neovim Terminal Colors --------------------------------------------------{{{
  if has('nvim')
    let g:terminal_color_0  = "#353a44"
    let g:terminal_color_8  = "#353a44"
    let g:terminal_color_1  = "#e88388"
    let g:terminal_color_9  = "#e88388"
    let g:terminal_color_2  = "#a7cc8c"
    let g:terminal_color_10 = "#a7cc8c"
    let g:terminal_color_3  = "#ebca8d"
    let g:terminal_color_11 = "#ebca8d"
    let g:terminal_color_4  = "#72bef2"
    let g:terminal_color_12 = "#72bef2"
    let g:terminal_color_5  = "#d291e4"
    let g:terminal_color_13 = "#d291e4"
    let g:terminal_color_6  = "#65c2cd"
    let g:terminal_color_14 = "#65c2cd"
    let g:terminal_color_7  = "#e3e5e9"
    let g:terminal_color_15 = "#e3e5e9"
  endif

  " Delete functions =========================================================={{{
  " delf <SID>X
  " delf <SID>XAPI
  " delf <SID>rgb
  " delf <SID>color
  " delf <SID>rgb_color
  " delf <SID>rgb_level
  " delf <SID>rgb_number
  " delf <SID>grey_color
  " delf <SID>grey_level
  " delf <SID>grey_number
  " }}}

endif
"}}}

" Public API --------------------------------------------------------------{{{
function! one#highlight(group, fg, bg, attr)
  call <sid>XAPI(a:group, a:fg, a:bg, a:attr)
endfunction
"}}}

" vim: set fdl=0 fdm=marker:

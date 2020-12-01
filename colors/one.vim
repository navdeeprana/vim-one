" Lightweight one.vim
" Modified from rakr/one.vim

highlight clear
syntax reset

if exists('g:colors_name')
    unlet g:colors_name
endif
let g:colors_name = 'one'

" Highlight function
function! <SID>hi(group, fg, bg, attr, ...)
    let l:attrsp = get(a:, 1, "")
    if !empty(a:fg)
        exec "hi " . a:group . " guifg=" .  a:fg
    endif
    if !empty(a:bg)
        exec "hi " . a:group . " guibg=" .  a:bg
    endif
    if a:attr != ""
        exec "hi " . a:group . " gui=" .   a:attr
    endif
    if !empty(l:attrsp)
        exec "hi " . a:group . " guisp=" . l:attrsp
    endif
endfunction

" {{{  Color definition
let s:gray_1    = '#4f4f4f'
let s:gray_2    = '#696c77'
let s:gray_3    = '#9e9e9e'
let s:gray_4    = '#a0a1a7'
let s:gray_5    = '#c2c2c3'
let s:gray_6    = '#d0d0d0'
let s:gray_7    = '#e8e8e8'
let s:gray_8    = '#f0f0f0'

let s:cyan_1    = '#0184bc'
let s:cyan_2    = '#3a8b84'

let s:blue_1    = '#4078f2'
let s:blue_2    = '#526fff'
let s:blue_3    = '#5079be'

let s:purple_1  = '#a626a4'
let s:purple_2  = '#bf75d6'

let s:green_1   = '#50a14f'
let s:green_2   = '#76af6f'

let s:red_1     = '#ca1243'
let s:red_2     = '#e45649'

let s:brown_1   = '#986801'
let s:brown_2   = '#c18401'

let s:syntax_fg = s:gray_1
let s:syntax_bg = s:gray_8
" }}}

" {{{  Vim editor color
call <sid>hi('Normal',       s:syntax_fg, s:syntax_bg, '')
call <sid>hi('ColorColumn',  '',          s:syntax_bg, '')
call <sid>hi('Conceal',      s:gray_2,    s:syntax_bg, 'bold')
call <sid>hi('Cursor',       '',          s:blue_2,    '')
call <sid>hi('CursorColumn', '',          s:syntax_bg, '')
call <sid>hi('CursorIM',     '',          '',          '')
call <sid>hi('CursorLine',   '',          s:syntax_bg, 'none')
call <sid>hi('CursorLineNr', s:syntax_fg, s:syntax_bg, 'none')
"Debug
call <sid>hi('DiffAdd',      s:gray_7,    s:green_2,   '')
call <sid>hi('DiffChange',   s:gray_7,    s:brown_2,   '')
call <sid>hi('DiffDelete',   s:red_2,     s:gray_7,    '')
call <sid>hi('DiffText',     s:blue_1,    s:gray_7,    '')
call <sid>hi('DiffAdded',    s:gray_7,    s:green_1,   '')
call <sid>hi('DiffFile',     s:red_2,     s:gray_7,    '')
call <sid>hi('DiffNewFile',  s:green_1,   s:gray_7,    '')
call <sid>hi('DiffLine',     s:blue_1,    s:gray_7,    '')
call <sid>hi('DiffRemoved',  s:red_2,     s:gray_7,    '')
call <sid>hi('Directory',    s:blue_1,    '',          '')
"EndOfBuffer
call <sid>hi('ErrorMsg',     s:red_2,     s:syntax_bg, 'none')
call <sid>hi('FoldColumn',   s:gray_3,    s:syntax_bg, '')
call <sid>hi('Folded',       s:syntax_fg, s:gray_6,    'none')
call <sid>hi('IncSearch',    s:green_1,   s:syntax_bg, '')
call <sid>hi('LineNr',       s:gray_5,    '',          '')
call <sid>hi('MatchParen',   s:red_2,     s:syntax_bg, 'underline,bold')
call <sid>hi('ModeMsg',      s:syntax_fg, '',          '')
call <sid>hi('MoreMsg',      s:syntax_fg, '',          '')
call <sid>hi('NonText',      s:gray_4,    '',          'none')
call <sid>hi('PMenu',        '',          s:gray_7,    '')
call <sid>hi('PMenuSel',     '',          s:gray_5,    '')
call <sid>hi('PMenuSbar',    '',          s:syntax_bg, '')
call <sid>hi('PMenuThumb',   '',          s:gray_1,    '')
call <sid>hi('Question',     s:blue_1,    '',          '')
"QuickFixLine
"ScrollBar
call <sid>hi('Search',       s:syntax_bg, s:brown_2,   '')
call <sid>hi('SignColumn',   '',          s:syntax_bg, '')
call <sid>hi('Special',      s:blue_1,    '',          '')
call <sid>hi('SpecialKey',   s:gray_6,    '',          'none')
"Spell stuff
call <sid>hi('StatusLine',   s:syntax_fg, s:gray_6,    'none')
call <sid>hi('StatusLineNC', s:syntax_fg, s:gray_5,    '')
call <sid>hi('Substitute',   s:syntax_bg, s:brown_2,   '')
call <sid>hi('TabLine',      s:gray_2,    s:gray_6,    'none')
call <sid>hi('TabLineFill',  s:gray_4,    s:gray_6,    'none')
call <sid>hi('TabLineSel',   s:syntax_bg, s:blue_1,    '')
"TermCursor
"TermCursorNC
call <sid>hi('Title',        s:syntax_fg, '',          'bold')
call <sid>hi('TooLong',      s:red_2,     '',          '')
call <sid>hi('VertSplit',    s:gray_7,    '',          'none')
call <sid>hi('Visual',       '',          s:gray_6,    '')
call <sid>hi('VisualNOS',    '',          s:gray_6,    '')
call <sid>hi('WarningMsg',   s:red_2,     '',          '')
call <sid>hi('Whitespace',   s:gray_6,    '',          'none')
call <sid>hi('WildMenu',     s:blue_1,    s:syntax_fg, '')
" }}}

" {{{  Vim Help highlighting
call <sid>hi('helpCommand',      s:brown_2, '', '')
call <sid>hi('helpExample',      s:brown_2, '', '')
call <sid>hi('helpHeader',       s:gray_1,  '', 'bold')
call <sid>hi('helpSectionDelim', s:gray_4,  '', '')
" }}}

" {{{  Standard syntax highlighting
call <sid>hi('Comment',        s:gray_4,   '',          '')
call <sid>hi('Constant',       s:green_1,  '',          '')
call <sid>hi('String',         s:green_1,  '',          '')
call <sid>hi('Character',      s:green_1,  '',          '')
call <sid>hi('Number',         s:brown_1,  '',          '')
call <sid>hi('Boolean',        s:brown_1,  '',          '')
call <sid>hi('Float',          s:brown_1,  '',          '')
call <sid>hi('Identifier',     s:red_2,    '',          'none')
call <sid>hi('Function',       s:blue_1,   '',          '')
call <sid>hi('Statement',      s:purple_1, '',          'none')
call <sid>hi('Conditional',    s:purple_1, '',          '')
call <sid>hi('Repeat',         s:purple_1, '',          '')
call <sid>hi('Label',          s:purple_1, '',          '')
call <sid>hi('Operator',       s:blue_2,   '',          'none')
call <sid>hi('Keyword',        s:red_2,    '',          '')
call <sid>hi('Exception',      s:purple_1, '',          '')
call <sid>hi('PreProc',        s:brown_2,  '',          '')
call <sid>hi('Include',        s:blue_1,   '',          '')
call <sid>hi('Define',         s:purple_1, '',          'none')
call <sid>hi('Macro',          s:purple_1, '',          '')
call <sid>hi('PreCondit',      s:brown_2,  '',          '')
call <sid>hi('Type',           s:brown_2,  '',          'none')
call <sid>hi('StorageClass',   s:brown_2,  '',          '')
call <sid>hi('Structure',      s:brown_2,  '',          '')
call <sid>hi('Typedef',        s:brown_2,  '',          '')
call <sid>hi('Special',        s:blue_1,   '',          '')
call <sid>hi('SpecialChar',    '',         '',          '')
call <sid>hi('Tag',            '',         '',          '')
call <sid>hi('Delimiter',      '',         '',          '')
call <sid>hi('SpecialComment', '',         '',          '')
call <sid>hi('Debug',          '',         '',          '')
call <sid>hi('Underlined',     '',         '',          'underline')
call <sid>hi('Ignore',         '',         '',          '')
call <sid>hi('Error',          s:red_2,    s:syntax_bg, 'bold')
call <sid>hi('Todo',           s:purple_1, s:syntax_bg, '')
" }}}

" {{{ GitGutter highlighting
call <sid>hi('GitGutterAdd',    s:green_1, s:gray_7, 'bold')
call <sid>hi('GitGutterChange', s:brown_2, s:gray_7, 'bold')
call <sid>hi('GitGutterDelete', s:red_1,   s:gray_7, 'bold')
" }}}

" {{{ C/C++ highlighting
call <sid>hi('cInclude',          s:purple_1, '', '')
call <sid>hi('cPreCondit',        s:purple_1, '', '')
call <sid>hi('cPreConditMatch',   s:purple_1, '', '')
call <sid>hi('cType',             s:purple_1, '', '')
call <sid>hi('cStorageClass',     s:purple_1, '', '')
call <sid>hi('cStructure',        s:purple_1, '', '')
call <sid>hi('cOperator',         s:purple_1, '', '')
call <sid>hi('cStatement',        s:purple_1, '', '')
call <sid>hi('cTODO',             s:purple_1, '', '')
call <sid>hi('cConstant',         s:brown_1,  '', '')
call <sid>hi('cSpecial',          s:cyan_1,   '', '')
call <sid>hi('cSpecialCharacter', s:cyan_1,   '', '')
call <sid>hi('cString',           s:green_1,  '', '')
call <sid>hi('cppType',           s:purple_1, '', '')
call <sid>hi('cppStorageClass',   s:purple_1, '', '')
call <sid>hi('cppStructure',      s:purple_1, '', '')
call <sid>hi('cppModifier',       s:purple_1, '', '')
call <sid>hi('cppOperator',       s:purple_1, '', '')
call <sid>hi('cppAccess',         s:purple_1, '', '')
call <sid>hi('cppStatement',      s:purple_1, '', '')
call <sid>hi('cppConstant',       s:red_2,    '', '')
call <sid>hi('cCppString',        s:green_1,  '', '')
" }}}

" {{{ JSON highlighting
call <sid>hi('jsonCommentError',       s:gray_1,   '', ''        )
call <sid>hi('jsonKeyword',            s:red_2,    '', ''        )
call <sid>hi('jsonQuote',              s:gray_4,   '', ''        )
call <sid>hi('jsonTrailingCommaError', s:red_2,    '', 'reverse' )
call <sid>hi('jsonMissingCommaError',  s:red_2,    '', 'reverse' )
call <sid>hi('jsonNoQuotesError',      s:red_2,    '', 'reverse' )
call <sid>hi('jsonNumError',           s:red_2,    '', 'reverse' )
call <sid>hi('jsonString',             s:green_1,  '', ''        )
call <sid>hi('jsonBoolean',            s:purple_1, '', ''        )
call <sid>hi('jsonNumber',             s:brown_1,  '', ''        )
call <sid>hi('jsonStringSQError',      s:red_2,    '', 'reverse' )
call <sid>hi('jsonSemicolonError',     s:red_2,    '', 'reverse' )
" }}}

" {{{  Markdown highlighting
call <sid>hi('markdownUrl',              s:gray_4,  '', '')
call <sid>hi('markdownBold',             s:brown_1, '', 'bold')
call <sid>hi('markdownItalic',           s:brown_1, '', 'bold')
call <sid>hi('markdownCode',             s:green_1, '', '')
call <sid>hi('markdownCodeBlock',        s:red_2,   '', '')
call <sid>hi('markdownCodeDelimiter',    s:green_1, '', '')
call <sid>hi('markdownHeadingDelimiter', s:red_1,   '', '')
call <sid>hi('markdownH1',               s:red_2,   '', '')
call <sid>hi('markdownH2',               s:red_2,   '', '')
call <sid>hi('markdownH3',               s:red_2,   '', '')
call <sid>hi('markdownH3',               s:red_2,   '', '')
call <sid>hi('markdownH4',               s:red_2,   '', '')
call <sid>hi('markdownH5',               s:red_2,   '', '')
call <sid>hi('markdownH6',               s:red_2,   '', '')
call <sid>hi('markdownListMarker',       s:red_2,   '', '')
" }}}

" {{{  Python highlighting
call <sid>hi('pythonImport',          s:purple_1, '', '')
call <sid>hi('pythonBuiltin',         s:cyan_1,   '', '')
call <sid>hi('pythonStatement',       s:purple_1, '', '')
call <sid>hi('pythonParam',           s:brown_1,  '', '')
call <sid>hi('pythonEscape',          s:red_2,    '', '')
call <sid>hi('pythonSelf',            s:gray_2,   '', '')
call <sid>hi('pythonClass',           s:blue_1,   '', '')
call <sid>hi('pythonOperator',        s:purple_1, '', '')
call <sid>hi('pythonEscape',          s:red_2,    '', '')
call <sid>hi('pythonFunction',        s:blue_1,   '', '')
call <sid>hi('pythonKeyword',         s:blue_1,   '', '')
call <sid>hi('pythonModule',          s:purple_1, '', '')
call <sid>hi('pythonStringDelimiter', s:green_1,  '', '')
call <sid>hi('pythonSymbol',          s:cyan_1,   '', '')
" }}}

" {{{  Spelling highlighting
call <sid>hi('SpellBad',   s:syntax_bg, s:red_2, '')
call <sid>hi('SpellLocal', s:syntax_bg, s:red_1, '')
call <sid>hi('SpellCap',   s:syntax_bg, s:red_2, '')
call <sid>hi('SpellRare',  s:syntax_bg, s:red_2, '')
" }}}

" {{{  Vim highlighting
call <sid>hi('vimCommand',      s:purple_1, '', '')
call <sid>hi('vimCommentTitle', s:gray_4,   '', 'bold')
call <sid>hi('vimFunction',     s:cyan_1,   '', '')
call <sid>hi('vimFuncName',     s:purple_1, '', '')
call <sid>hi('vimHighlight',    s:blue_1,   '', '')
call <sid>hi('vimLineComment',  s:gray_4,   '', '')
call <sid>hi('vimParenSep',     s:gray_2,   '', '')
call <sid>hi('vimSep',          s:gray_2,   '', '')
call <sid>hi('vimUserFunc',     s:cyan_1,   '', '')
call <sid>hi('vimVar',          s:red_2,    '', '')
" }}}

" {{{  XML highlighting
call <sid>hi('xmlAttrib',  s:brown_2, '', '')
call <sid>hi('xmlEndTag',  s:red_2,   '', '')
call <sid>hi('xmlTag',     s:red_2,   '', '')
call <sid>hi('xmlTagName', s:red_2,   '', '')
" }}}

" {{{  man highlighting
hi link manTitle String
call <sid>hi('manFooter', s:gray_4, '', '')
" }}}

" {{{  Sneak highlighting
call <sid>hi('Sneak', s:red_1, s:syntax_bg, 'underline,bold')
" }}}

" {{{  Neovim Terminal Colors
if has('nvim')
    let g:terminal_color_0  = "#4f4f4f"
    let g:terminal_color_8  = "#4f4f4f"
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
" }}}

" Vim syntax file
" Language:     F#
" Last Change:  Sun 19 Oct 2014 11:11:44 PM CEST
" Maintainer:   Gregor Uhlenheuer <kongo2002@googlemail.com>
"
" Note:         This syntax file is a complete rewrite of the original version
"               of fs.vim from Choy Rim <choy.rim@gmail.com> and a slight
"               modified version from Thomas Schank <ThomasSchank@gmail.com>

if version < 600
    syntax clear
elseif exists('b:current_syntax')
    finish
endif

" F# is case sensitive.
syn case match

" reset 'iskeyword' setting
setl iskeyword&vim
setl isident+='


" Scripting/preprocessor directives
syn match   fsharpSScript "^\s*#\S\+" transparent contains=fsharpScript,fsharpRegion,fsharpPreCondit

syn match   fsharpScript contained "#"
syn match   fsharpScript contained "#r"
syn keyword fsharpScript contained quitlabels warnings directory cd load use
syn keyword fsharpScript contained install_printer remove_printer requirethread
syn keyword fsharpScript contained trace untrace untrace_all print_depth
syn keyword fsharpScript contained print_length define undef if elif else endif
syn keyword fsharpScript contained line error warning light nowarn


" comments
syn match   fsharpSingleLineComment          "//.*$"
    \ contains=fsharpTodo,@Spell
syn region  fsharpDocComment                 start="///" end="$" keepend oneline
    \ contains=fsharpTodo,fsharpXml,@Spell
syn region  fsharpXml              contained matchgroup=fsharpXmlDoc start="<[^>]\+>" end="</[^>]\+>"
    \ contains=fsharpXml

" Double-backtick identifiers
syn region  fsharpDoubleBacktickIdent contained start="``" end="``" keepend oneline


syn match   fsharpOperator         contained "[-><+*/=~%.&|@^!?(,)[\]]\+"

syn match   fsharpIdentifier       contained "\i\+"

syn match   fsharpUnnamedFieldType contained "\%#=1\%(\i\+\s*:\s*\)\@!\i\+"

syn match   fsharpBinding          contained "\%#=1\<\i\+\%(\s*:[^:]\s*\i\)\@="
    \ transparent
    \ contains=fsharpIdentifier

syn match   fsharpTypeSignature    contained "\%#=1\%(\i\+\s*:\s*\)\@<=[[:alnum:]'_ *[\]]\+"
syn region  fsharpTypeSignature    contained matchgroup=fsharpOperator start="<" matchgroup=fsharpOperator end=">"
    \ contains=fsharpGenericComma

syn match   fsharpGenericComma      contained ","

syn match   fsharpField                      "\<\i\+\s*:\s*[[:alnum:]'_ *[\]]\+"
    \ transparent
    \ contains=fsharpBinding,fsharpTypeSignature,fsharpKeyChar


" symbol names
syn region fsharpParam contained matchgroup=fsharpKeyword start="(" matchgroup=fsharpKeyword end=")"
    \ transparent
    \ contains=fsharpIdentifier,fsharpBinding,fsharpTypeSignature,fsharpKeyChar

syn match fsharpSymbol "\(\<\(let\|use\|and\)!\=\(\s\+mutable\|\s\+rec\|\s\+private\|\s\+inline\)*\)\@<=\s\+\zs\i\+[^=]*\ze="
    \ transparent
    \ contains=fsharpIdentifier,fsharpParam,fsharpTypeSignature
syn match fsharpSymbol "\(\(member\|override\)\(\s\+inline\)\=\)\@<=\s\+\zs\(\i\+\.\)\=\i\+[^=]*\ze="
    \ transparent
    \ contains=fsharpIdentifier,fsharpParam,fsharpTypeSignature,fsharpKeyChar
syn match fsharpSymbol "\(\<fun\)\@<=\s+[^-]\ze->"
    \ transparent
    \ contains=fsharpIdentifier,fsharpBinding,fsharpTypeSignature,fsharpKeyChar
"syn region fsharpFun matchgroup=fsharpFunDef start="\<fun\>"  matchgroup=fsharpFunDef end="->"
    "\ contains=fsharpIdentifier,fsharpBinding,fsharpTypeSignature,fsharpKeyChar


" types
syn match    fsharpTypeName   "\%#=1\%(\<type\s\+\(\(private\|public\)\s\+\)\?\)\@<=\i\+"

syn region   fsharpUnionFields transparent matchgroup=fsharpKeyword start="\Wof\W" end="|\|$"
    \ contains=fsharpNamedFieldType,fsharpTypeSignature,fsharpUnnamedFieldType,fsharpKeyChar


" errors
syn match    fsharpBraceErr   "}"
syn match    fsharpBrackErr   "\]"
syn match    fsharpParenErr   ")"
syn match    fsharpArrErr     "|]"
syn match    fsharpCommentErr "\*)"


" enclosing delimiters
syn region   fsharpEncl transparent matchgroup=fsharpKeyword start="("   matchgroup=fsharpKeyword end=")"   contains=TOP,fsharpScript,fsharpParenErr
syn region   fsharpEncl transparent matchgroup=fsharpKeyword start="{"   matchgroup=fsharpKeyword end="}"   contains=TOP,fsharpScript,fsharpBraceErr
syn region   fsharpEncl transparent matchgroup=fsharpKeyword start="\["  matchgroup=fsharpKeyword end="\]"  contains=TOP,fsharpScript,fsharpBrackErr
syn region   fsharpEncl transparent matchgroup=fsharpKeyword start="\[|" matchgroup=fsharpKeyword end="|\]" contains=TOP,fsharpScript,fsharpArrErr
syn region   fsharpEncl transparent matchgroup=fsharpKeyword start="{|"  matchgroup=fsharpKeyword end="|}"  contains=TOP,fsharpScript,fsharpRecLitErr


" comments
syn region   fsharpMultiLineComment start="(\*" end="\*)" contains=fsharpTodo
syn keyword  fsharpTodo contained TODO FIXME XXX NOTE

" keywords
syn keyword fsharpKeyword    abstract as assert base begin class default delegate
syn keyword fsharpKeyword    do done downcast downto elif else end exception
syn keyword fsharpKeyword    extern for fun function global if in inherit inline
syn keyword fsharpKeyword    interface lazy let match member module mutable
syn keyword fsharpKeyword    namespace new of override rec static struct then
syn keyword fsharpKeyword    to type upcast use val void when while with

syn keyword fsharpKeyword    async atomic break checked component const constraint
syn keyword fsharpKeyword    constructor continue decimal eager event external
syn keyword fsharpKeyword    fixed functor include method mixin object parallel
syn keyword fsharpKeyword    process pure return seq tailcall trait

" additional operator keywords (Microsoft.FSharp.Core.Operators)
syn keyword fsharpKeyword    box hash sizeof typeof typedefof unbox ref fst snd
syn keyword fsharpKeyword    stdin stdout stderr

" math operators (Microsoft.FSharp.Core.Operators)
syn keyword fsharpKeyword    abs acos asin atan atan2 ceil cos cosh exp floor log
syn keyword fsharpKeyword    log10 pown round sign sin sinh sqrt tan tanh

syn keyword fsharpOCaml      asr land lor lsl lsr lxor mod sig

if !exists('g:fsharp_no_linq') || g:fsharp_no_linq == 0
    syn keyword fsharpLinq   orderBy select where yield
endif

" open
syn keyword fsharpOpen       open

" exceptions
syn keyword fsharpException  try failwith failwithf finally invalid_arg raise
syn keyword fsharpException  rethrow

" modifiers
syn keyword fsharpModifier   abstract const extern internal override private
syn keyword fsharpModifier   protected public readonly sealed static virtual
syn keyword fsharpModifier   volatile

" constants
syn keyword fsharpConstant   null
syn keyword fsharpBoolean    false true

" types
"syn keyword  fsharpType      array bool byte char decimal double enum exn float
"syn keyword  fsharpType      float32 int int16 int32 int64 lazy_t list nativeint
"syn keyword  fsharpType      obj option sbyte single string uint uint32 uint64
"syn keyword  fsharpType      uint16 unativeint unit

" core classes
syn match    fsharpCore      "\u\a*\." transparent contains=fsharpCoreClass

syn keyword  fsharpCoreClass Array Async Directory File List Option Path Map Set contained
syn keyword  fsharpCoreClass String Seq Tuple contained

syn keyword fsharpCoreMethod printf printfn sprintf eprintf eprintfn fprintf
syn keyword fsharpCoreMethod fprintfn

" unions
syn keyword  fsharpOption    Some None
syn keyword  fsharpResult    Ok Error
syn keyword  fsharpChoices   Choice1Of2 Choice2Of2
syn keyword  fsharpChoices   Choice1Of3 Choice2Of3 Choice3Of3
syn keyword  fsharpChoices   Choice1Of4 Choice2Of4 Choice3Of4 Choice4Of4
syn keyword  fsharpChoices   Choice1Of5 Choice2Of5 Choice3Of5 Choice4Of5 Choice5Of5
syn keyword  fsharpChoices   Choice1Of6 Choice2Of6 Choice3Of6 Choice4Of6 Choice5Of6 Choice6Of6
syn keyword  fsharpChoices   Choice1Of7 Choice2Of7 Choice3Of7 Choice4Of7 Choice5Of7 Choice6Of7 Choice7Of7

" operators
syn keyword fsharpOperator   not and or

syn match   fsharpFormat     display "%\(\d\+\$\)\=[-+' #0*]*\(\d*\|\*\|\*\d\+\$\)\(\.\(\d*\|\*\|\*\d\+\$\)\)\=\([hlL]\|ll\)\=\([bscdiuxXoEefFgGMOAat]\|\[\^\=.[^]]*\]\)" contained

syn match    fsharpCharacter    "'\\\d\d\d'\|'\\[\'ntbr]'\|'.'"
syn match    fsharpCharErr      "'\\\d\d'\|'\\\d'"
syn match    fsharpCharErr      "'\\[^\'ntbr]'"
syn region   fsharpString       start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=fsharpFormat
syn region   fsharpString       start=+"""+ skip=+\\\\\|\\"+ end=+"""+ contains=fsharpFormat
syn region   fsharpString       start=+@"+ skip=+""+ end=+"+ contains=fsharpFormat

syn match    fsharpFunDef       "->"
syn match    fsharpRefAssign    ":="
syn match    fsharpTopStop      ";;"
syn match    fsharpOperator     "\^"
syn match    fsharpOperator     "::"

syn match    fsharpLabel        "\<_\>"

syn match    fsharpOperator     "&&"
syn match    fsharpOperator     "<"
syn match    fsharpOperator     ">"
syn match    fsharpOperator     "|>"
syn match    fsharpOperator     ":>"
syn match    fsharpOperator     ":?>"
syn match    fsharpOperator     "&&&"
syn match    fsharpOperator     "|||"
syn match    fsharpOperator     "\.\."

syn match    fsharpKeyChar      "|[^\]]"me=e-1
syn match    fsharpKeyChar      ";"
syn match    fsharpKeyChar      "\~"
syn match    fsharpKeyChar      "?"
syn match    fsharpKeyChar      "\*"
syn match    fsharpKeyChar      "+"
syn match    fsharpKeyChar      "="
syn match    fsharpKeyChar      "|"
syn match    fsharpKeyChar      ":"
syn match    fsharpKeyChar      "(\*)"

syn match    fsharpOperator     "<-"

syn match    fsharpNumber        "\<\d\+"
syn match    fsharpNumber        "\<-\=\d\(_\|\d\)*\(u\|u\?[yslLn]\|UL\)\?\>"
syn match    fsharpNumber        "\<-\=0[x|X]\(\x\|_\)\+\(u\|u\?[yslLn]\|UL\)\?\>"
syn match    fsharpNumber        "\<-\=0[o|O]\(\o\|_\)\+\(u\|u\?[yslLn]\|UL\)\?\>"
syn match    fsharpNumber        "\<-\=0[b|B]\([01]\|_\)\+\(u\|u\?[yslLn]\|UL\)\?\>"
syn match    fsharpFloat         "\<-\=\d\(_\|\d\)*\.\(_\|\d\)*\([eE][-+]\=\d\(_\|\d\)*\)\=\>"
syn match    fsharpFloat         "\<-\=\d\(_\|\d\)*\.\(_\|\d\)*\([eE][-+]\=\d\(_\|\d\)*\)\=\>"
syn match    fsharpFloat         "\<\d\+\.\d*"

" modules
syn match    fsharpModule     "\%#=1\%(\<open\s\+\)\@<=[a-zA-Z.]\+"

" attributes
syn region   fsharpAttrib matchgroup=fsharpAttribute start="\[<" end=">]"

" regions
syn region   fsharpRegion matchgroup=fsharpPreCondit start="\%(end\)\@<!region.*$"
            \ end="endregion" fold contains=ALL contained

if version >= 508 || !exists("did_fs_syntax_inits")
    if version < 508
        let did_fs_syntax_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi def link <args>
    endif

    HiLink fsharpBraceErr          Error
    HiLink fsharpBrackErr          Error
    HiLink fsharpParenErr          Error
    HiLink fsharpArrErr            Error
    HiLink fsharpCommentErr        Error

    HiLink fsharpSingleLineComment Comment
    HiLink fsharpMultiLineComment  Comment
    HiLink fsharpDocComment        Comment
    HiLink fsharpXml               Comment

    HiLink fsharpOpen              Include
    HiLink fsharpModPath           Include
    HiLink fsharpScript            Include
    HiLink fsharpPreCondit         Include

    HiLink fsharpKeyword           Keyword
    HiLink fsharpCoreMethod        Keyword

    HiLink fsharpOCaml             Statement
    HiLink fsharpLinq              Statement

    "HiLink fsharpSymbol            Identifier
    HiLink fsharpIdentifier        Identifier
    HiLink fsharpDoubleBacktickIdent Identifier

    HiLink fsharpFunDef            Operator
    HiLink fsharpRefAssign         Operator
    HiLink fsharpTopStop           Operator
    HiLink fsharpKeyChar           Operator
    HiLink fsharpOperator          Operator
    HiLink fsharpGenericComma      Operator

    HiLink fsharpBoolean           Boolean
    HiLink fsharpConstant          Constant
    HiLink fsharpCharacter         Character
    HiLink fsharpNumber            Number
    HiLink fsharpFloat             Float

    HiLink fsharpString            String
    HiLink fsharpFormat            Special

    HiLink fsharpModifier          StorageClass

    HiLink fsharpException         Exception

    HiLink fsharpLabel             Identifier
    "HiLink fsharpOption            Identifier
    "HiLink fsharpResult            Identifier
    "HiLink fsharpChoices           Identifier
    HiLink fsharpTypeName          Identifier
    HiLink fsharpBinding           Identifier
    HiLink fsharpModule            Identifier

    HiLink fsharpType              Type
    HiLink fsharpCoreClass         Type

    HiLink fsharpTypeSignature     Typedef
    HiLink fsharpAttrib            Typedef
    HiLink fsharpXmlDoc            Typedef

    HiLink fsharpTodo              Todo

    HiLink fsharpEncl              Delimiter
    HiLink fsharpAttribute         Delimiter

    delcommand HiLink
endif

let b:current_syntax = 'fsharp'

" vim: sw=4 et sts=4

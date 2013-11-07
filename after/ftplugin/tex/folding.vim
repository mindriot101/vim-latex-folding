fun! LaTeXFold()
    let syntaxGroup = map(synstack(v:lnum, 1), 'synIDattr(v:val, "name")')
    let line = getline(v:lnum)

    let inDocument = index(syntaxGroup, 'texDocZone') >= 0
    let inChapter = index(syntaxGroup, 'texChapterZone') >= 0
    let chapterMod = inChapter ? 1 : 0

    if match(line, '\\chapter') >= 0 
        return ">1"
    elseif match(line, '\\section') >= 0
        return ">" . (1 + chapterMod)
    elseif match(line, '\\subsection') >= 0
        return ">" . (2 + chapterMod)
    elseif match(line, '\\subsubsection') >= 0
        return ">" . (3 + chapterMod)
    elseif inDocument
        return "="
    else
        return "0"
    endif

endfun

setlocal foldmethod=expr
setlocal foldexpr=LaTeXFold()

if exists('g:vim_latex_foldcolumn')
    let &l:foldcolumn=g:vim_latex_foldcolumn
else
    setlocal foldcolumn=0
endif

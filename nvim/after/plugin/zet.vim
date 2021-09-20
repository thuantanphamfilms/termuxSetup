let g:zettelkasten = "~/storage/shared/note/"

command! ZettelHome :execute ":e" zettelkasten . "README.md"

noremap <leader>ww :ZettelHome<cr>

command! NewZettel :execute ":e" zettelkasten . strftime("%Y%m%d%H%M%S") . ".md"

noremap <leader>n :NewZettel<cr>

function! s:make_note_link(l)
    let line = split(a:l[0], ':')
    let ztk_id = l:line[0]
    let ztk_title = substitute(l:line[1], '\#\s\+', '', 'g')
    let mdlink = "[" . ztk_title ."](". ztk_id .")"
    return mdlink
endfunction

inoremap <expr> <c-f><c-f> fzf#vim#complete({
            \ 'source':  'rg --no-heading --smart-case  ^\#',
            \ 'reducer': function('<sid>make_note_link'),
            \ 'options': '--multi --reverse --margin 5%,0',
            \ 'down':    10})

" ============================================================================
" by: Kody
" 希望这个插件会变得毫无用处。
" ============================================================================

" 1. 用户配置映射关系 (在 .vimrc 中定义更佳)
" 格式: '目标编辑文件名': '存储内容的数据文件路径'
if !exists('g:hacker_source_map')
    let g:hacker_source_map = {
    \   'test.js': '~/.vim/hacker_data/payload_js.txt',
    \ }
endif

" 核心逻辑：从外部文件读取内容并实现打字效果
function! s:InitHackerMode()
    let l:target_name = expand('%:t')
    
    " 检查当前文件是否在配置列表中
    if has_key(g:hacker_source_map, l:target_name)
        let l:source_path = expand(g:hacker_source_map[l:target_name])
        
        " 检查数据文件是否存在
        if filereadable(l:source_path)
            " 读取文件内容并转为字符串
            let l:lines = readfile(l:source_path)
            let b:hacker_content = join(l:lines, "\n")
            let b:hacker_index = 0
            let b:hacker_len = strlen(b:hacker_content)
            
            " 激活按键映射
            call s:ApplyHackerMappings()
        else
            echoerr "HackerTyper Error: 源文件未找到 -> " . l:source_path
        endif
    endif
endfunction

" 字符提取函数
function! s:TypeNextChar()
    if !exists('b:hacker_content') || b:hacker_len == 0
        return ""
    endif

    " 获取当前位置字符
    let l:char = b:hacker_content[b:hacker_index]
    
    " 更新索引，如果到末尾则循环
    let b:hacker_index += 1
    if b:hacker_index >= b:hacker_len
        let b:hacker_index = 0
    endif
    
    return l:char
endfunction

" 批量映射所有可打印字符
function! s:ApplyHackerMappings()
    let l:chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_=+[{]};:'\",.<>/?!@#$%^&*() "
    let l:i = 0
    while l:i < strlen(l:chars)
        let l:c = l:chars[l:i]
        if l:c == '"'
            let l:map_cmd = 'inoremap <buffer> <expr> " <SID>TypeNextChar()'
        elseif l:c == '|'
            let l:map_cmd = 'inoremap <buffer> <expr> <Bar> <SID>TypeNextChar()'
        elseif l:c == ' '
            let l:map_cmd = 'inoremap <buffer> <expr> <Space> <SID>TypeNextChar()'
        else
            let l:map_cmd = 'inoremap <buffer> <expr> ' . l:c . ' <SID>TypeNextChar()'
        endif
        
        silent! execute l:map_cmd
        let l:i += 1
    endwhile
endfunction

" 自动命令
augroup ExternalHackerTyper
    autocmd!
    autocmd BufRead,BufNewFile,BufEnter * call s:InitHackerMode()
augroup END
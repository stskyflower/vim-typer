# Vim Typer

**vim_typer.vim** 是一个专为 Vim 设计的“演示”插件。当你开启该插件后，无论你在键盘上乱敲什么按键，编辑器都会按照你预设的文件内容。

## 1. 安装方法

### 手动安装
1. 在你的 Linux 系统中创建插件目录：
   ```bash
   mkdir -p ~/.vim/plugin
   ```
2. 将 `vim_typer.vim` 文件放入该目录中。

## 2. 快速配置

在你的 `~/.vimrc` 中定义映射关系。你需要指定**目标文件名**以及对应的**内容来源文件**。

```vimscript
" 格式：'目标编辑文件名': '存储伪装内容的文件路径'
let g:hacker_source_map = {
\   'test.js': '~/.vim/hacker_data/payload_js.txt',
\ }
```

> **注意**：请确保内容来源文件（如 `payload_js.txt`）已经存在，并且路径正确。

## 3. 使用步骤

1. **准备内容**：创建一个文本文件（例如 `~/.vim/vim_typer_data/payload_js.txt`），写入你想演示的代码
2. **启动 Vim**：打开或创建一个匹配的文件名：
   ```bash
   vim test.js
   ```
3. **进入模式**：按下 `i` 进入插入模式。
4. **开始表演**：此时你可以随意、快速地乱敲键盘。你会发现屏幕上正有条不紊地逐字显示你预设的代码内容。

## 4. 进阶技巧

### 调整打字速度
如果你希望每敲击一下键盘显示多个字符（看起来手速极快），可以修改插件中的 `s:TypeNextChar` 函数：

```vimscript
" 修改 hacker_typer.vim 内部逻辑
function! s:TypeNextChar()
    let l:out = ""
    for i in range(3) " 这里的数字 3 表示每按一下出 3 个字
        let l:char = b:hacker_content[b:hacker_index]
        let l:out .= l:char
        let b:hacker_index = (b:hacker_index + 1) % b:hacker_len
    endfor
    return l:out
endfunction
```

## 5. 常见问题 (FAQ)

*   **Q: 为什么我敲键盘没反应？**
    *   A: 请检查 `g:hacker_source_map` 中的文件名是否与你当前编辑的文件名完全一致（含扩展名），并检查来源文件路径是否正确。
*   **Q: 退格键和回车键还能用吗？**
    *   A: 为了模拟真实感，默认情况下退格键和回车键保持原有功能。如果你希望这两个键也变成伪装输出，可以在插件的 `s:ApplyHackerMappings` 函数中添加对 `<CR>` 和 `<BS>` 的映射。

## 6. 免责声明
本插件仅供娱乐和演示使用。

---

职业教育本来是应该培养真正的技术人才，但是现在的技能大赛应该完全变成了表演形式的比赛。

学生和老师不在专注于技术而是表演，这样的比赛没有任何意义。

**如果喜欢请给个 Star！**
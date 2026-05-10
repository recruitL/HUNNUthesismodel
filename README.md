# 湖南师范大学学位论文 LaTeX 模板

基于 `ctexbook` 文档类，使用 XeLaTeX + BibTeX 编译。适用于博士/硕士/学士学位论文。

## 环境要求

- **编译器**: XeLaTeX（必须，模板使用 `xeCJK` 处理中文字体）
- **参考文献**: BibTeX（BibLaTeX 亦可，需自行修改 `style/bib.tex`）
- **字体**:
  - 英文: Times New Roman（系统自带）
  - 中文: 宋体、黑体、楷体、仿宋（系统自带）
  - 华文行楷 (STXingkai)：封面用，macOS 自带；Windows/Linux 若缺失请替换为楷体
- **宏包**: 见 `style/packages.tex`，均为 TeX Live / MacTeX 标准发行版自带

## 快速开始

### 1. 填写个人信息

打开 `main.tex`，修改 `用户自定义变量` 区域的各项信息：

```latex
\newcommand{\youreduction}{博}          % 学历: 博/硕/学
\newcommand{\yourtitlenamechinese}{...} % 论文中文标题
\newcommand{\yourtitlenameenglish}{...} % 论文英文标题
\newcommand{\degreetype}{science}       % science=科学学位, professional=专业学位
\newcommand{\yourname}{...}             % 作者姓名
...
```

### 2. 编译

```bash
# 方式一：latexmk（推荐，自动处理多遍编译）
latexmk -xelatex main

# 方式二：手动四次编译
xelatex main
bibtex main
xelatex main
xelatex main
```

### 3. 单章独立编译

每个 `content/` 下的文件使用 `subfiles` 宏包，可独立编译用于预览：

```bash
cd content
xelatex 03-chapter1
```

## 目录结构

```
.
├── main.tex                      入口文件（填变量 + 引样式 + 引内容）
├── main-manual.tex               本手册的入口文件
├── style/                        样式模块（15个文件，一个关切一个文件）
│   ├── packages.tex              所有宏包加载（按功能分8组）
│   ├── fonts.tex                 中英文字体配置
│   ├── layout.tex                页面边距、行距、对齐
│   ├── cover.tex                 封面命令（下划线、复选框）
│   ├── abstract.tex              中英文摘要环境
│   ├── toc.tex                   目录样式（tocloft）
│   ├── headers.tex               页眉页脚（fancyhdr）
│   ├── chapters.tex              章节标题格式（\ctexset）
│   ├── theorems.tex              定理环境、彩色盒子、带圈数字
│   ├── listings.tex              Mathematica 代码块样式
│   ├── bib.tex                   参考文献（gbt7714 + natbib）
│   ├── appendix.tex              附录格式（编号重置）
│   ├── commands.tex              自定义数学/物理命令
│   └── custom.tex                【用户扩展区】
├── content/                      论文正文
│   ├── 01-cover.tex              封面 + 扉页
│   ├── 02-abstract.tex           摘要 + 目录
│   ├── 03-chapter1.tex           第一章
│   ├── 04-appendix.tex           附录
│   ├── 05-declaration.tex        成果、致谢、声明
│   └── manual-*.tex              本手册各章节
├── figures/                      图片资源
├── manual-references.bib         本手册参考文献
├── gbt7714.sty                   GB/T 7714 宏包
├── gbt7714-*.bst                 GB/T 7714 样式文件
├── CLAUDE.md                     AI 助手协作指南
├── .latexmkrc                    latexmk 编译配置
├── .gitignore                    Git 忽略规则
└── README.md                     开发者文档
```

## 学位切换（本/硕/博 + 学术/专业）

模板通过两个变量实现 3×2=6 种学位组合：

| 变量 | 可选值 | 说明 |
|------|--------|------|
| `\youreduction` | `博` / `硕` / `学` | 学历层次 |
| `\degreetype` | `science` / `professional` | 学位类型 |

修改 `main.tex` 中的这两行即可，封面大字、页眉、学位全称全部自动适配：

```latex
\newcommand{\youreduction}{博}           % 改为 硕 或 学
\newcommand{\degreetype}{science}        % 改为 professional 切换专业学位
```

**示例组合：**
- 博士学术学位: `博` + `science` → 封面显示"学术学位博士学位论文"
- 硕士专业学位: `硕` + `professional` → 封面显示"专业学位硕士学位论文"
- 学士学术学位: `学` + `science` → 封面显示"学术学位学士学位论文"

**硕士额外操作：** 如需在扉页显示学位类型复选框，取消 `content/01-cover.tex` 中对应行的注释。

**本科额外操作：** 通常不需要"攻读学位期间完成的论文"章节，删除 `content/05-declaration.tex` 中对应部分即可。

## 如何扩展模板

**所有个人新增的宏包、命令、格式覆盖，统一放入 `style/custom.tex`。** 无需理解模块划分。

`style/custom.tex` 有三个区域：
- **自定义宏包** — 加 `\usepackage{...}`
- **自定义命令与环境** — 加 `\newcommand{...}` 或 `\newenvironment{...}`
- **自定义格式覆盖** — 覆盖已有样式

当 custom.tex 内容积累较多后，可以让 AI 助手（Claude Code）帮你把命令迁移到对应的 style 模块中。AI 会根据 `CLAUDE.md` 中的规则自动归类。

## AI 协作

本模板包含 `CLAUDE.md`，Claude Code 启动时会自动读取。你可以直接对 AI 说：
- "我要用 siunitx 宏包" → AI 会加到 `style/custom.tex`
- "定义一个 \pdv 命令" → AI 会加到 `style/custom.tex`
- "帮我把 custom.tex 里的内容整理到对应模块" → AI 会按规则迁移

## 常用操作

### 添加章节

1. 复制 `content/03-chapter1.tex` → `content/06-chapter2.tex`
2. 修改文件内容
3. 在 `main.tex` 中添加 `\subfile{content/06-chapter2}`

### 切换参考文献制式

编辑 `style/bib.tex`，注释/取消注释以下行：

```latex
% 顺序编码制（默认，如 [1]）
\bibliographystyle{gbt7714-numerical}

% 著者-出版年制（如 (张三, 2024)）
% \bibliographystyle{gbt7714-author-year}
```

### 修改边距

编辑 `style/layout.tex` 中的 `\geometry{...}` 参数。

### 修改标题字体/字号

编辑 `style/chapters.tex` 中的 `\ctexset{...}` 配置。

### 修改页眉文字

编辑 `style/headers.tex` 和 `content/02-abstract.tex` 中的 `\fancyhead[...]{...}` 设置。

### 添加代码语言

编辑 `style/listings.tex`，新增 `\lstdefinelanguage{...}{...}` 块。

## 与旧模板的对应关系

| 旧文件 | 新文件 |
|--------|--------|
| `0-PhD-dissertation-mainfile.tex` | `main.tex` |
| `filepreamble.tex` | `style/*.tex` (13个文件) |
| `1-coverfiles.tex` | `content/01-cover.tex` |
| `2-bodycontent.tex` | `content/02-abstract.tex` + `content/03-chapter*.tex` |
| `3-Appendix.tex` | `content/04-appendix.tex` |
| `4-Originality.tex` | `content/05-declaration.tex` |

## 自定义定理环境

在 `style/theorems.tex` 中已有：定理、定义、引理、推论、问题、例题、注。

添加新环境：

```latex
\theoremstyle{thmstyle}           % 选择样式
\newtheorem{conjecture}{猜想}[chapter]  % 按章编号
```

## License

本模板基于湖南师范大学学位论文格式要求制作，可自由修改和分发。

# 湖南师范大学学位论文 LaTeX 模板

基于 `ctexbook` + XeLaTeX + BibTeX。支持 **本/硕/博 × 学术/专业 = 6 种学位组合**一键切换。

## 快速开始

1. 打开 `main.tex`，修改顶部变量区（姓名、标题、学历、学位类型）
2. 编译器选择 **XeLaTeX**
3. 编译 `main.tex` 即可生成学位论文 PDF

详细使用说明见 `main-manual.pdf`（51 页技术手册，由模板自身编译生成）。

## 目录结构

```
├── main.tex                学位论文入口（填变量即可）
├── main-manual.tex         技术手册入口
├── main-manual.pdf         技术手册 PDF
├── style/                  样式模块（15 个文件）
│   └── custom.tex          【用户扩展区，所有个人新增放这里】
├── content/                论文正文
├── figure/                 图片资源
├── CLAUDE.md               AI 助手协作指南
└── README.md               开发者文档
```

## 学位切换

修改 `main.tex` 顶部两行：

```latex
\newcommand{\youreduction}{博}        % 博 / 硕 / 学
\newcommand{\degreetype}{science}     % science / professional
```

封面、页眉、学位全称全部自动适配。

## 参考文献

使用 GB/T 7714—2015 国标格式，BibTeX 管理。在 `content/04-appendix.tex` 末尾的 `\bibliography{...}` 中指定 `.bib` 文件。

## AI 协作

本模板含 `CLAUDE.md`，可在 Claude Code 中使用 AI 辅助排版。详见手册第四章。

## 源码

https://github.com/recruitL/HUNNUthesismodel

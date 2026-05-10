# CLAUDE.md — 论文模板 AI 协作指南

本文档供 Claude Code 等 AI 助手自动读取，确保 AI 理解模板结构并按一致的规则操作。

## 项目概述

湖南师范大学学位论文 LaTeX 模板。基于 `ctexbook` + XeLaTeX + BibTeX。
用途：生成符合 HNU 格式要求的硕/博士学位论文 PDF。

## 模板设计原则

1. **样式与内容分离** — `style/` 只放格式定义，`content/` 只放论文文本
2. **一个模块一个关切** — 每个 `style/*.tex` 只负责一类设置（字体/定理/页眉...）
3. **用户可以不改模块** — 所有个人扩展统一进 `style/custom.tex`，无需理解模块划分
4. **AI 负责整理** — AI 助手在 custom.tex 内容足够多时，主动建议迁移到对应模块

## 文件结构

```
main.tex                    入口：用户变量 + \input{style/*} + \subfile{content/*}
style/
├── packages.tex            所有 \usepackage 调用（按功能分组）
├── fonts.tex               中英文字体（xeCJK, Times New Roman）
├── layout.tex              页面边距、行距、对齐
├── cover.tex               封面命令（\dlmu, \Boxempty, \boxcheck, \yourdegree）
├── abstract.tex            中英文摘要环境（cnabstract, enabstract）
├── toc.tex                 目录样式（tocloft）
├── headers.tex             页眉页脚（fancyhdr）
├── chapters.tex            章节标题格式（\ctexset, \subsec, \ssubsec）
├── theorems.tex            定理环境、彩色盒子、带圈数字（amsthm, tcolorbox）
├── listings.tex            代码块样式（Mathematica 默认）
├── bib.tex                 参考文献（gbt7714 + natbib）
├── appendix.tex            附录格式（\chapappendix, \customappendix）
├── commands.tex            自定义数学/物理命令（\figref, \ime, \eexp, 数学算子）
└── custom.tex              【用户扩展区】— 所有个人新增内容放这里
content/
├── 01-cover.tex            封面 + 扉页
├── 02-abstract.tex         摘要 + 目录
├── 03-chapter1.tex         章节模板
├── 04-appendix.tex         附录
└── 05-declaration.tex      成果 + 致谢 + 声明
```

## 用户变量一览（main.tex 开头）

用户只需修改这些变量，其余自动适配：

```latex
\newcommand{\youreduction}{博}           % 学历: 博 / 硕 / 学(本科)
\newcommand{\degreetype}{science}        % 学位: science(学术) / professional(专业)
\newcommand{\yoursubject}{理学}          % 学科门类: 理学/工学/文学/...

% 以下由上面自动生成，通常不需要修改:
% \yourxuewei   → "理学博士学位" / "工学硕士学位" / ...
% \youreduclass → "学 术 学 位 博 士 论 文" / "专 业 学 位 硕 士 论 文" / ...
```

切换示例：
- 硕士 + 学术学位: `\youreduction{硕}` + `\degreetype{science}` → "学术学位硕士学位论文"
- 硕士 + 专业学位: `\youreduction{硕}` + `\degreetype{professional}` → "专业学位硕士学位论文"
- 本科 + 学术学位: `\youreduction{学}` + `\degreetype{science}` → "学术学位学士学位论文"

## AI 操作规则

### 规则 1：新增宏包

**用户说"我要用 xx 宏包"时：**
- 添加到 `style/custom.tex` 的「自定义宏包」区
- 不要直接修改 `style/packages.tex`
- 原因：用户不需要知道 packages.tex 的分类逻辑

### 规则 2：新增命令/环境

**用户说"定义一个 xx 命令"时：**
- 添加到 `style/custom.tex` 的「自定义命令与环境」区
- 写一行注释说明用途
- 如果命令明显属于已有模块（如新定理环境 → theorems.tex，新数学算子 → commands.tex），可以询问用户是否直接放到对应模块

### 规则 3：格式覆盖

**用户说"把 xx 格式改成 yy"时：**
- 先检查是哪个 style 模块控制的
- 如果是模块内的基础设置，直接修改对应模块文件
- 如果是个人偏好覆盖，在 `style/custom.tex` 的「自定义格式覆盖」区添加覆盖代码

### 规则 4：custom.tex 整理

**当 custom.tex 超过约 80 行或一个会话结束时：**
- AI 应主动检查 custom.tex 的内容
- 将可归类的命令迁移到对应的 style 模块
- 在 custom.tex 中留下迁移记录注释
- 迁移映射：

| 内容类型 | 迁移目标 |
|----------|----------|
| `\usepackage{...}` | `style/packages.tex`（对应功能组） |
| 数学/物理 `\newcommand` | `style/commands.tex` |
| 定理/定义/证明环境 | `style/theorems.tex` |
| 章节/标题格式 | `style/chapters.tex` |
| 页眉/页脚 | `style/headers.tex` |
| 代码语言/样式 | `style/listings.tex` |
| 封面/扉页命令 | `style/cover.tex` |
| 参考文献设置 | `style/bib.tex` |
| 附录格式 | `style/appendix.tex` |
| 无法归类的 | 保留在 `style/custom.tex` |

### 规则 5：添加章节

**用户说"加一章 xx"时：**
1. 复制 `content/03-chapter1.tex` → `content/XX-chapterN.tex`
2. 修改内容
3. 在 `main.tex` 的正文区域添加 `\subfile{content/XX-chapterN}`

### 规则 6：编译验证

修改模板后必须验证编译：
```bash
xelatex -interaction=nonstopmode -halt-on-error main.tex
bibtex main
xelatex -interaction=nonstopmode -halt-on-error main.tex
xelatex -interaction=nonstopmode -halt-on-error main.tex
```
至少跑第一遍 xelatex 确认无 error。如果跑不完四遍，告知用户需要完整编译。

## 用户偏好

- 代码不加注释，除非 WHY 不显而易见的
- 不要创建多余的文档文件（.md），除非用户明确要求
- 改动后不啰嗦总结，直接说做了什么
- 中文字体使用系统自带（宋体/黑体/楷体/仿宋/华文行楷）
- 参考文献格式：GB/T 7714 顺序编码制（默认）

## 已知注意事项

- `gbt7714` 宏包内部加载 `natbib`，不要重复加载带冲突选项的 natbib
- `hyperref` 必须最后加载（在 bib.tex 中配置 \hypersetup）
- 子文件使用 `subfiles` 宏包，`\bibliography` 必须放在 `main.tex` 而非 content 子文件中（路径解析问题）
- 编译需要 XeLaTeX（不能是 pdfLaTeX 或 LuaLaTeX），因为使用了 `xeCJK`
- 华文行楷 (STXingkai) 在 Windows/Linux 上可能不存在，需要替换为楷体

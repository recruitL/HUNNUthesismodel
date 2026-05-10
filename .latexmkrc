# latexmk 配置文件
# 使用: latexmk -xelatex main
# 自动处理 xelatex + bibtex 的多遍编译

$xelatex = 'xelatex -interaction=nonstopmode -halt-on-error -synctex=1 %O %S';
$bibtex = 'bibtex %O %B';
$pdf_mode = 1;
$postscript_mode = 0;
$dvi_mode = 0;

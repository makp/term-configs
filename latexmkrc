# latexmk config
# !ln -s %:p ~/.latexmkrc

$pdf_mode=1;
# $pdf_previewer = "start okular --unique";
$pdf_previewer = "zathura";
$pdf_previewer = "";
# $pdf_update_method = 0;
$pdflatex = "pdflatex -interaction=nonstopmode -file-line-error -synctex=1 %O %S";
$preview_continuous_mode = 1;


# This Makefile generates a RTL booklet (livret.pdf) from the TeX
# source allemand.tex which generates a a5 document.
#
# The process steps are written from the end to the beginning, so if
# you want to follow each step, you may start at the end of the
# document, skiping the clean target.

# Convert the ps booklet in pdf
livret.pdf: livret.ps
	ps2pdf livret.ps livret.pdf

# Put all a5 pages on a4 sheets, the booklet is done, in ps
livret.ps: rtl.ps
	psnup -2 -pa4 -Pa5 rtl.ps livret.ps

# Reverse the order of the booklet to have a RTL document
rtl.ps: book.ps
	pstops 1:-0 book.ps rtl.ps

# Sort the pages so you can print a booklet
book.ps: allemand.ps
	psbook allemand.ps book.ps

# psutils works on ps files, so convert pdf to ps
allemand.ps: allemand.pdf
	pdftops allemand.pdf

# create the pdf
allemand.pdf: allemand.tex
	xelatex allemand.tex

clean:
	rm -f livret.ps rtl.ps book.ps allemand.ps allemand.pdf livret.pdf allemand.log allemand.aux *~

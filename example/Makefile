DOCUMENT=document

document:
	pdflatex $(DOCUMENT)
	bibtex $(DOCUMENT)
	pdflatex $(DOCUMENT)
	pdflatex $(DOCUMENT)

clean:
	rm -f *.aux *.bbl *.blg *.lof *.lot *.log *.toc *.lol

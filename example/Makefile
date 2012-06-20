DOCUMENT=document
REFERENCES=references.bib

# Replace å with \aa{}, Å with \AA{}, ä with \"{a}, Ä with \"{A}, ö with
# \"{o} and Ö with \"{O}
REPLACE := s/å/\\aa{}/g;s/Å/\\AA{}/g;s/ä/\\"{a}/g;s/Ä/\\"{A}/g;s/ö/\\"{o}/g;s/Ö/\\"{O}/g

# Replace & with \& but make sure it's not escaped already
REPLACE := $(REPLACE);s/\([^\]\)&/\1\\\&/g

# Replace é with \'{e}
REPLACE_QUOTED := s/é/\\\'{e}/g

document:
	pdflatex $(DOCUMENT)
	sed -i '$(REPLACE)' $(REFERENCES)
	sed -i "$(REPLACE_QUOTED)" $(REFERENCES)
	bibtex $(DOCUMENT)
	pdflatex $(DOCUMENT)
	pdflatex $(DOCUMENT)

clean:
	rm -f *.aux *.bbl *.blg *.lof *.lot *.log *.toc *.lol

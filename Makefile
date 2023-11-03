# Define the LaTeX source file and the output file
TEX_SRC = src/main.tex
PDF_OUT = ./out

# Define the PlantUML source files and the output directory
PUML_FILES = src/assets/$(wildcard *.puml)
PUML_OUT = src/assets/

# Define the rule to build the LaTeX document
$(PDF_OUT): $(TEX_SRC)
	mkdir -p $(PDF_OUT)
	$(eval PDF_OUT := $(shell realpath $(PDF_OUT)))
	$(eval WD := $(shell dirname $(TEX_SRC)))
	$(eval TEX_FILE := $(shell basename $(TEX_SRC)))
	cd $(WD)
	pdflatex -file-line-error -interaction=nonstopmode -synctex=1 -output-format=pdf -output-directory=${PDF_OUT}  $(TEX_FILE)

# Define the rule to convert the PlantUML files
$(PUML_OUT)/%.eps: %.puml
	mkdir -p $(PUML_OUT)
	plantuml -o $(PUML_OUT) -teps $<

clean:
	rm -rf $(PDF_OUT)

# Define the default rule
all: clean $(PUML_FILES:.puml=.eps) $(PDF_OUT)
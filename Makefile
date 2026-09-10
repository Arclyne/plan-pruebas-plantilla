# =====================================================================
#  Plantilla de Plan de Pruebas de Software · ISO/IEC/IEEE 29119
#  ------------------------------------------------------------------
#  Requiere una instalación estándar de TeX Live o MacTeX (incluye
#  latexmk). No se necesita conexión a internet ni servicios externos.
#
#    make          compila main.tex -> main.pdf
#    make final    compila la versión de entrega (sin guías ni ejemplos)
#    make clean    borra los archivos auxiliares, conserva los PDF
#    make cleanall borra también los PDF generados
#    make watch    recompila automáticamente al guardar cambios
#    make view     abre el PDF (macOS)
# =====================================================================

MAIN      := main
FINAL     := plan-pruebas-final
LATEXMK   := latexmk
LATEXMKFLAGS := -pdf -interaction=nonstopmode -halt-on-error -file-line-error

.PHONY: all final clean cleanall watch view help

all: $(MAIN).pdf

$(MAIN).pdf: $(MAIN).tex $(wildcard config/*.tex) $(wildcard sections/*.tex) \
             $(wildcard appendices/*.tex) $(wildcard diagrams/*.tex)
	$(LATEXMK) $(LATEXMKFLAGS) $(MAIN).tex

# Versión de entrega: define \VERSIONFINAL, que apaga las cajas de guía
# y de ejemplo desde config/metadata.tex.
final:
	$(LATEXMK) $(LATEXMKFLAGS) -jobname=$(FINAL) \
	  -pdflatex='pdflatex %O "\def\VERSIONFINAL{}\input{%S}"' $(MAIN).tex
	@echo "PDF de entrega generado: $(FINAL).pdf"

clean:
	$(LATEXMK) -c $(MAIN).tex
	$(LATEXMK) -c -jobname=$(FINAL) $(MAIN).tex 2>/dev/null || true
	@rm -f *.aux *.log *.out *.toc *.lof *.lot *.fls *.fdb_latexmk \
	       *.synctex.gz *.bbl *.blg *.run.xml
	@echo "Archivos auxiliares eliminados."

cleanall: clean
	@rm -f $(MAIN).pdf $(FINAL).pdf
	@echo "PDF generados eliminados."

watch:
	$(LATEXMK) $(LATEXMKFLAGS) -pvc $(MAIN).tex

view: $(MAIN).pdf
	@open $(MAIN).pdf 2>/dev/null || xdg-open $(MAIN).pdf 2>/dev/null || \
	  echo "Abra $(MAIN).pdf con su visor de PDF."

help:
	@grep -E '^#    make' Makefile | sed 's/^#  //'

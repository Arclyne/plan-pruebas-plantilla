# =====================================================================
#  Plantilla de Plan de Pruebas de Software · ISO/IEC/IEEE 29119
#  ------------------------------------------------------------------
#  UNA sola fuente LaTeX (main.tex) produce TRES variantes del PDF.
#  Lo que cambia entre ellas es sólo la visibilidad de tres tipos de
#  bloque, controlada desde config/metadata.tex:
#
#    variante   objetivo           instrucciones  ejemplos  observaciones
#    ---------  -----------------  -------------  --------  -------------
#    trabajo    make                    sí           sí          no
#    anotada    make annotated          sí           sí          sí
#    final      make final              no           no          no
#
#  Requiere TeX Live o MacTeX (incluye latexmk). Sin servicios externos.
#
#    make            plantilla-trabajo.pdf   · plantilla por rellenar
#    make annotated  plantilla-anotada.pdf   · + origen de las correcciones
#    make final      plantilla-final.pdf     · documento de entrega
#    make variantes  las tres de una vez
#    make clean      borra los auxiliares, conserva los PDF
#    make cleanall   borra también los PDF
#    make watch      recompila la versión de trabajo al guardar
#    make view       abre la versión de trabajo
# =====================================================================

MAIN      := main
TRABAJO   := plantilla-trabajo
ANOTADA   := plantilla-anotada
FINAL     := plantilla-final

LATEXMK   := latexmk
LATEXMKFLAGS := -pdf -interaction=nonstopmode -halt-on-error -file-line-error

FUENTES := $(MAIN).tex $(wildcard config/*.tex) $(wildcard sections/*.tex) \
           $(wildcard appendices/*.tex) $(wildcard diagrams/*.tex)

# Compila una variante. $(1) = jobname, $(2) = macro que la selecciona
# (vacía para la variante de trabajo, que es la configuración por defecto).
define compilar
$(LATEXMK) $(LATEXMKFLAGS) -jobname=$(1) \
  -pdflatex='pdflatex %O "$(2)\input{%S}"' $(MAIN).tex
endef

.PHONY: all annotated anotada final variantes clean cleanall watch view help

all: $(TRABAJO).pdf

$(TRABAJO).pdf: $(FUENTES)
	$(call compilar,$(TRABAJO),)
	@echo ">> $(TRABAJO).pdf — plantilla por rellenar (sin observaciones)"

annotated anotada: $(FUENTES)
	$(call compilar,$(ANOTADA),\def\VARIANTEANOTADA{})
	@echo ">> $(ANOTADA).pdf — incluye el origen de cada corrección"

final: $(FUENTES)
	$(call compilar,$(FINAL),\def\VARIANTEFINAL{})
	@echo ">> $(FINAL).pdf — documento de entrega"

variantes: all annotated final

clean:
	@for j in $(TRABAJO) $(ANOTADA) $(FINAL) $(MAIN); do \
	  $(LATEXMK) -c -jobname=$$j $(MAIN).tex >/dev/null 2>&1 || true; \
	done
	@rm -f *.aux *.log *.out *.toc *.lof *.lot *.fls *.fdb_latexmk \
	       *.synctex.gz *.bbl *.blg *.run.xml
	@echo "Archivos auxiliares eliminados."

cleanall: clean
	@rm -f $(TRABAJO).pdf $(ANOTADA).pdf $(FINAL).pdf $(MAIN).pdf
	@echo "PDF generados eliminados."

watch:
	$(LATEXMK) $(LATEXMKFLAGS) -pvc -jobname=$(TRABAJO) $(MAIN).tex

view: $(TRABAJO).pdf
	@open $(TRABAJO).pdf 2>/dev/null || xdg-open $(TRABAJO).pdf 2>/dev/null || \
	  echo "Abra $(TRABAJO).pdf con su visor de PDF."

help:
	@sed -n 's/^#    \(make.*\)/  \1/p' Makefile

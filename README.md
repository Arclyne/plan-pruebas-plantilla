# Plantilla de Plan de Pruebas de Software · ISO/IEC/IEEE 29119

Plantilla LaTeX **reutilizable** para documentar un plan de pruebas de software y
su reporte de finalización, con los formatos de registro que el proceso de prueba
necesita: casos, procedimientos, ejecuciones, incidentes, informes de estado,
preparación del entorno y matriz de trazabilidad.

Una **sola fuente LaTeX** genera **tres variantes** del documento; lo único que
cambia entre ellas es qué bloques se componen:

| Variante | Comando | Archivo | Para qué sirve |
|---|---|---|---|
| Trabajo | `make` | `plantilla-trabajo.pdf` | Rellenar la plantilla. Incluye guías, ejemplos, diagramas de apoyo, políticas académicas y notas conceptuales. |
| Anotada | `make annotated` | `plantilla-anotada.pdf` | Entender el origen de las correcciones. Añade los bloques de *Observación de la revisión*. No se entrega. |
| Final | `make final` | `plantilla-final.pdf` | Entregar el plan ya rellenado. Sin guías, ejemplos, diagramas de apoyo ni observaciones. |

No existen tres copias de las secciones: las tres variantes salen de los mismos
archivos de `sections/` y `appendices/`.

Universidad Veracruzana · Facultad de Estadística e Informática
Licenciatura en Ingeniería de Software · EE. Pruebas de Software

> **Alcance.** Esta plantilla **no declara conformidad** con ISO/IEC/IEEE 29119.
> Organiza la planificación y el cierre de un esfuerzo de prueba tomando como
> referencia el modelo de procesos de la parte 2 y la estructura documental de la
> parte 3. Demostrar conformidad exigiría, además, evidencia de las actividades
> realizadas y una revisión del texto normativo completo de la edición elegida.
> Véase `docs/DECISIONES.md` (D-01).

---

## 1. Requisitos

| Requisito | Detalle |
|---|---|
| Distribución TeX | **MacTeX** (macOS) o TeX Live 2021 o posterior. La instalación completa incluye todo lo necesario. |
| Herramienta de compilación | `latexmk` (viene con MacTeX y TeX Live). |
| Motor | `pdflatex`. No se requiere XeLaTeX ni LuaLaTeX. |
| `make` | Opcional; incluido en las Herramientas de Línea de Comandos de Xcode. |

No se necesita conexión a internet, Overleaf ni ningún servicio externo. Todas las
rutas del proyecto son relativas.

**Instalación en macOS**

```sh
brew install --cask mactex          # o descargue MacTeX desde tug.org/mactex
xcode-select --install              # proporciona make
```

Si usa **BasicTeX** en lugar de MacTeX completo, instale los paquetes adicionales:

```sh
sudo tlmgr update --self
sudo tlmgr install latexmk tcolorbox environ trimspaces pgf xltabular ltablex \
     ragged2e tocloft titlesec fancyhdr lastpage enumitem caption microtype \
     multirow booktabs babel-spanish hyphen-spanish helvetic
```

**Comprobación rápida**

```sh
latexmk -v && pdflatex --version | head -1
```

## 2. Cómo compilar

```sh
make            # plantilla-trabajo.pdf  · plantilla por rellenar
make annotated  # plantilla-anotada.pdf  · + origen de las correcciones
make final      # plantilla-final.pdf    · documento de entrega
make variantes  # las tres de una vez
make watch      # recompila la versión de trabajo al guardar
make view       # abre la versión de trabajo
make help       # lista los objetivos disponibles
```

Sin `make`, el objetivo principal de compilación es:

```sh
latexmk -pdf main.tex
```

que produce la variante de trabajo (es la configuración por defecto de
`config/metadata.tex`). Las otras dos se obtienen definiendo una macro al
compilar:

```sh
latexmk -pdf -jobname=plantilla-anotada \
  -pdflatex='pdflatex %O "\def\VARIANTEANOTADA{}\input{%S}"' main.tex

latexmk -pdf -jobname=plantilla-final \
  -pdflatex='pdflatex %O "\def\VARIANTEFINAL{}\input{%S}"' main.tex
```

`latexmk` ejecuta `pdflatex` las veces necesarias para resolver el índice, los
índices de cuadros y figuras y las referencias cruzadas (normalmente tres pasadas,
unos 25 segundos).

## 3. Cómo limpiar los archivos auxiliares

```sh
make clean      # borra .aux .log .toc .lof .lot .out .fls .fdb_latexmk …
make cleanall   # borra además los PDF de las tres variantes
```

Equivalente sin `make`: `latexmk -c main.tex`.

## 4. Estructura del proyecto

```
main.tex                  Configuración, metadatos y orden de inclusión. Sin contenido.
Makefile                  Objetivos de compilación y limpieza.

config/
  preamble.tex            Paquetes, geometría, tipografía, encabezado, pie y estilos de tabla.
  metadata.tex            ← DATOS DEL EQUIPO Y DEL PROYECTO. Es lo primero que debe editar.
  commands.tex            Cajas de la plantilla (instrucción, ejemplo, política, nota, observación)
                          y comandos propios.

sections/
  00-portada.tex          Consideraciones de uso, portada e información del proyecto.
  01-control-versiones.tex  Historial, revisiones y aprobación formal.
  02-introduccion.tex     Presentación, referentes y glosario.
  03-contexto.tex         Caso de estudio, objetivo, objeto y base de prueba, criticidad, alcance,
                          supuestos e interesados.
  04-riesgos.tex          Riesgos de producto y de proyecto; tratamiento.
  05-estrategia.tex       Niveles, tipos, diseño, técnicas, cobertura, criterios de entrada y de
                          salida, confirmación y regresión, entorno, datos, configuración,
                          métricas, entregables y desviaciones.
  06-seguimiento.tex      Monitoreo, hitos, registro de seguimiento, control e informes.
  07-incidentes.tex       Análisis previo, severidad, prioridad, estados y comunicación.
  08-actividades.tex      Actividades, esfuerzo, dependencias y productos.
  09-equipo.tex           Roles, responsabilidades, autoridad y competencias.
  10-calendarizacion.tex  Cronograma.
  11-finalizacion.tex     PARTE II: resumen, resultados, criterios de salida, incidentes abiertos,
                          métricas, riesgos residuales, aceptación, archivo, limpieza y lecciones.

appendices/
  a-casos-prueba.tex      Ficha e índice de casos de prueba.
  b-procedimientos.tex    Ficha e índice de procedimientos.
  c-ejecuciones.tex       Ficha y registro consolidado de ejecuciones.
  d-incidentes.tex        Ficha y registro consolidado de incidentes.
  e-informes-estado.tex   Formato de informe de estado periódico.
  f-preparacion-entorno.tex  Verificación, cambios y restauración del entorno y los datos.
  g-trazabilidad.tex      Matriz de trazabilidad y resumen de cobertura de la base de prueba.

diagrams/
  estructura-29119.tex    Figura 1. Partes de la norma y su correspondencia con este documento.
  procesos-prueba.tex     Figura 2. Flujo del proceso de prueba y sus bucles de retroalimentación.
  tecnicas-prueba.tex     Figura 3. Mapa de técnicas de diseño y su elemento de cobertura.
  cadena-trazabilidad.tex Figura 4. Cadena base → riesgo → … → incidente.

docs/
  MATRIZ_CAMBIOS.md       Qué cambió respecto de la plantilla Word y por qué.
  DECISIONES.md           Decisiones de diseño, con su justificación y fuente.
  VALIDACION.md           Evidencia de la compilación y revisiones realizadas.

sources/                  Materiales de partida (plantilla Word, observaciones, plan de trabajo).
```

## 5. Dónde editar los metadatos

**`config/metadata.tex`** es el único archivo que hay que tocar para personalizar
la identificación del documento. Contiene:

- identificación institucional (universidad, facultad, programa, EE) — encabezado y pie;
- identificación del documento (título, proyecto, fecha, equipo, integrantes, versión);
- autoridad de aprobación y autoridad de aceptación;
- los interruptores de la plantilla (sección 9 de este README).

No edite el encabezado ni el pie en `config/preamble.tex`: se construyen a partir
de los valores de `metadata.tex`.

## 6. Cómo agregar contenido

Cada apartado del PDF tiene tres tipos de hueco por rellenar:

1. **Marcadores `\campo{...}`** — texto en cursiva y color entre corchetes, dentro
   de las tablas y del cuerpo. Sustituya el comando completo por su contenido:

   ```latex
   Fecha & \campo{dd/mm/aaaa} \\      →      Fecha & 14/03/2026 \\
   ```

2. **Filas vacías de las tablas** — duplique la última fila hasta tener las que
   necesite. Toda fila termina en `\\ \hline`.

3. **Párrafos de redacción libre** — un `\campo{Redacte aquí…}` en un párrafo
   propio; sustitúyalo por su texto.

Para añadir un apartado nuevo, cree el archivo en `sections/` y añádalo a
`main.tex` en el orden que corresponda. Los archivos se incluyen con `\input`, sin
extensión y con ruta relativa.

## 7. Cómo agregar casos de prueba (y los demás registros)

Los anexos A–G traen **un formato en blanco** de cada registro. Para documentar
varios elementos, replique el bloque completo.

**Un caso de prueba nuevo** — en `appendices/a-casos-prueba.tex`, copie el bloque
`\begin{xltabular}…\end{xltabular}` de la ficha y cambie el `\label`:

```latex
\begin{xltabular}{\textwidth}{|E{4.4cm}|Y|}
\caption{Caso de prueba CP-002.}\label{tab:cp-002}\\ \hline
\endfirsthead
\multicolumn{2}{@{}l@{}}{\footnotesize\itshape\tablename~\thetable{} (continuación)}\\ \hline
\endhead
\multicolumn{2}{@{}r@{}}{\footnotesize\itshape continúa en la página siguiente}\\
\endfoot
\endlastfoot
Identificador del caso & CP-002 \\ \hline
% … resto de campos …
\end{xltabular}
```

Cada `\label` debe ser único. Después añada una fila al índice
(`Cuadro: Índice de casos de prueba especificados`) y otra a la matriz de
trazabilidad del Anexo G.

Los anexos B, C, D, E y F siguen el mismo patrón. Los registros consolidados
(ejecuciones, incidentes, trazabilidad) son `longtable`: basta con añadir filas.

> Si mantiene los registros en una herramienta externa (hoja de cálculo, gestor de
> incidencias), no es obligatorio reproducirlos aquí: indique en el
> `Cuadro: Control de configuración de los activos de prueba` dónde están, quién
> los mantiene y cómo se relacionan.

## 8. Cómo agregar figuras

**Una imagen.** Colóquela en una carpeta `img/` del proyecto y refiérala con ruta
relativa. Toda figura necesita `caption`, `label` y una mención desde el texto:

```latex
\begin{figure}[htbp]
  \centering
  \includegraphics[width=0.85\textwidth]{img/cronograma.png}
  \caption{Cronograma real del esfuerzo de prueba.}
  \label{fig:cronograma}
\end{figure}
```

y en el texto: `La Figura~\ref{fig:cronograma} muestra…`.

**Un diagrama vectorial.** Cree `diagrams/mi-diagrama.tex` con la figura completa
—`figure`, `tikzpicture`, `caption` y `label`— siguiendo el patrón de los cuatro
existentes, e inclúyalo con `\input{diagrams/mi-diagrama}` desde la sección
correspondiente. Las bibliotecas TikZ ya cargadas están en `config/preamble.tex`.

Si el diagrama es material de apoyo y no contenido del plan, envuelva la inclusión
y el párrafo que lo describe en `\ifmostrardiagramas … \fi`, como los cuatro
existentes, para que no aparezca en la versión de entrega.

## 9. Cómo controlar qué se muestra en cada variante

El documento usa **cinco tipos de bloque** con significado propio, y tres
interruptores deciden cuáles se componen:

| Bloque | Color | Qué es | trabajo | anotada | final |
|---|---|---|:--:|:--:|:--:|
| `instruccion` | verde | Guía de la plantilla: qué debe escribirse. | sí | sí | — |
| `ejemplo` | azul | Ilustración; no es contenido a conservar. | sí | sí | — |
| `observacion` | morado | Origen de una corrección respecto de la plantilla anterior. | — | sí | — |
| Diagramas | — | Las cuatro figuras: explican la norma y el uso de la plantilla. | sí | sí | — |
| `politicaacademica` | naranja | Regla local del curso, **no** requisito de la norma. | sí | sí | sí |
| `notanormativa` | gris | Referencia normativa o aclaración conceptual. | sí | sí | sí |

Los dos últimos **nunca se ocultan**: son contenido del plan. Una política
académica sigue vigente mientras el curso la exija, y una nota conceptual explica
una distinción que el plan necesita (cobertura frente a veredicto, confirmación
frente a regresión), no el historial de la plantilla.

**Lo habitual es no tocar nada**: elija la variante desde el Makefile. Si quiere
fijar una combinación distinta de forma permanente, edite los interruptores de
`config/metadata.tex`:

```latex
\newif\ifmostrarinstrucciones   \mostrarinstruccionestrue
\newif\ifmostrarejemplos        \mostrarejemplostrue
\newif\ifmostrarobservaciones   \mostrarobservacionesfalse
\newif\ifmostrardiagramas       \mostrardiagramastrue
```

### Por qué los diagramas no van en la entrega

Las cuatro figuras explican **la norma y el uso de la plantilla**, no el sistema
bajo prueba: un plan de pruebas entregado no necesita un diagrama de las partes
de ISO/IEC/IEEE 29119. Por eso son material de apoyo y acompañan a las guías.

Si su Experiencia Educativa espera que el documento entregado incluya ese marco
conceptual, ponga `\mostrardiagramastrue` dentro del bloque `\VARIANTEFINAL` de
`config/metadata.tex` y volverán a aparecer.

### El documento se refiere a sí mismo según la variante

Mientras se rellena es una plantilla; una vez entregado es un plan de prueba. El
interruptor `\ifversionfinal` —derivado de `mostrarinstrucciones`, no independiente—
permite ajustar la redacción sin duplicar párrafos:

```latex
\segunvariante{Esta plantilla}{Este plan} \textbf{no declara conformidad} con …
```

Para suprimir un bloque entero en la entrega (por ejemplo, la leyenda de los
bloques de color, que no tiene sentido en un documento ya rellenado):

```latex
\ifversionfinal\else
  … contenido que sólo existe mientras es plantilla …
\fi
```

Si añade texto que hable del documento como plantilla, o que explique cómo
compilarlo, envuélvalo así: la versión de entrega no debe contener ninguna
referencia a los colores, a los interruptores ni a los objetivos del Makefile.

### Menciones a las figuras

Las menciones a las figuras dentro del texto van envueltas en `\sidiag{...}`, de
modo que la frase siga siendo correcta cuando la figura no está. Si añade una
mención nueva, use el mismo envoltorio y redacte la frase de manera que se
sostenga sin el inciso:

```latex
Este proceso opera de forma concurrente con la ejecución\sidiag{, como muestra la
Figura~\ref{fig:procesos}}: no es una etapa entre dos entregas.
```

### Cómo escribir una observación nueva

Sólo tiene sentido en la variante anotada. El bloque del PDF es un **resumen**;
la explicación completa vive en `docs/MATRIZ_CAMBIOS.md`, para no duplicarla:

```latex
\begin{observacion}[Título corto]
  \obsproblema{Qué estaba mal en la plantilla anterior.}
  \obscambio{Qué se hizo en su lugar.}
  \obsjustificacion{Por qué ese cambio resuelve el problema.}   % opcional
  \obsfuente{OBS §4.4}
\end{observacion}
```

Las claves de `\obsfuente` siguen el criterio de `docs/MATRIZ_CAMBIOS.md`:
`OBS §n` (documento de observaciones), `PDF §n` (plan de trabajo 29119), `DIAG`
(análisis de los diagramas) y `PROPIA` (criterio de esta reingeniería).

## 10. Solución de problemas

| Síntoma | Causa y solución |
|---|---|
| Los números de cuadro o las referencias salen como `??` | Falta una pasada. `latexmk` las resuelve solo; si compila a mano, ejecute `pdflatex` tres veces. |
| `File 'xltabular.sty' not found` | Instalación BasicTeX incompleta: ejecute el `tlmgr install` de la sección 1. |
| Una tabla se sale del margen | Reduzca el ancho de alguna columna `C{...}`/`L{...}`, o deje que una columna `Y` absorba el sobrante. |
| Cambió un dato y el PDF no se actualiza | `make clean && make`. |
| El PDF de entrega sigue mostrando las guías | Está abriendo `plantilla-trabajo.pdf`; la entrega es `plantilla-final.pdf`. |
| La versión de trabajo muestra bloques morados | Está abriendo `plantilla-anotada.pdf`; para rellenar use `plantilla-trabajo.pdf`. |
| Cambió una observación y no aparece | Las observaciones sólo se componen en `make annotated`. |

## 11. Documentación del proyecto

- **`docs/MATRIZ_CAMBIOS.md`** — qué elemento de la plantilla Word original se
  conservó, amplió, corrigió o añadió, con su justificación y fuente.
- **`docs/DECISIONES.md`** — decisiones de diseño (por qué se separó el registro de
  ejecución del caso, por qué se etiquetaron las reglas académicas, cómo se
  interpretaron las observaciones ambiguas).
- **`docs/VALIDACION.md`** — evidencia de que el proyecto compila y qué se revisó.

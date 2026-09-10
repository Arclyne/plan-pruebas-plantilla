# Validación de la compilación

Registro de las comprobaciones realizadas sobre la plantilla. Se documenta el
entorno usado, el resultado de la compilación y las revisiones manuales, junto con
los problemas encontrados y cómo se corrigieron.

## 1. Entorno de compilación

| Elemento | Valor |
|---|---|
| Distribución | TeX Live 2023 (paquetes `texlive-latex-recommended`, `texlive-latex-extra`, `texlive-pictures`, `texlive-lang-spanish`, `texlive-fonts-recommended`, `latexmk`) |
| Motor | pdfTeX 1.40.25 |
| Orquestador | `latexmk` |
| Sistema | Linux x86-64 |

> **Nota sobre macOS.** La validación se ejecutó en Linux con TeX Live, no en
> macOS con MacTeX. Ambas distribuciones comparten el mismo árbol de paquetes y
> las mismas versiones de `pdflatex` y `latexmk`, y el proyecto sólo usa paquetes
> de la instalación estándar y rutas relativas, por lo que no se esperan
> diferencias. Aun así, **la compilación en MacTeX no ha sido verificada
> directamente**: conviene ejecutar `latexmk -pdf main.tex` una primera vez en el
> equipo de destino. En `README.md` §1 se incluye el `tlmgr install` necesario si
> se parte de BasicTeX en lugar de MacTeX completo.

## 2. Resultado de la compilación

Una sola fuente (`main.tex`) produce tres variantes. Las tres se compilaron desde
un árbol limpio (`make cleanall`) y desde un clon recién creado del repositorio.

| Variante | Comando | Archivo | Páginas | Salida |
|---|---|---|---|---|
| Trabajo | `make` | `plantilla-trabajo.pdf` | 67 | 0 |
| Anotada | `make annotated` | `plantilla-anotada.pdf` | 73 | 0 |
| Final | `make final` | `plantilla-final.pdf` | 52 | 0 |

En las **tres** variantes:

| Métrica | Resultado |
|---|---|
| Errores (`!`) | **0** |
| `LaTeX Warning` | **0** |
| Advertencias de paquete | **0** |
| `Overfull \hbox` / `\vbox` | **0** |
| `Underfull \hbox` / `\vbox` | **0** |
| Referencias sin resolver | **0** |
| Pasadas de `pdflatex` | 3 |
| Tiempo por variante | ~26 s |
| Tamaño de página | A4 (595,3 × 841,9 pt) |

### 2.1 Contenido efectivo de cada variante

Recuento sobre el texto extraído de cada PDF, que es lo que verifica que los
interruptores hacen lo que dicen:

| Bloque | Trabajo | Anotada | Final |
|---|:--:|:--:|:--:|
| Instrucciones (`Qué debe documentarse`) | 67 | 67 | **0** |
| Observaciones (`Observación de la revisión`) | **0** | 32 | **0** |
| Campos de observación (`Problema identificado`) | **0** | 32 | **0** |
| Figuras compuestas | 4 | 4 | **0** |
| Políticas académicas | 9 | 9 | 9 |
| Menciones a «plantilla» en el texto | 7 | 8 | **0** |

Al ocultar los diagramas se comprobó además que **no queda ninguna referencia sin
resolver** (`??` en el texto extraído: 0 en las tres variantes) y que las frases
que remitían a una figura siguen siendo gramaticalmente correctas sin el inciso.
Se inspeccionaron los seis pasajes afectados en la variante final.

### 2.2 Ausencia de fugas del historial de revisión

Se buscó en el texto extraído de cada PDF el patrón
`plantilla (original|anterior)`, `diagrama (original|de referencia)`,
`la revisión (señaló|detectó|pide|pedía)` y `respecto de la original`:

| Variante | Coincidencias |
|---|---|
| Trabajo | **0** |
| Final | **0** |
| Anotada | 30 (todas dentro de bloques de observación) |

Esto confirma el requisito de separación: la plantilla de trabajo y la de entrega
no muestran por qué se corrigió nada; la anotada sí. La única coincidencia
descartada fue «Cambio aplicado y motivo», encabezado legítimo de una columna del
registro de cambios del entorno (Anexo F).

## 3. Comprobaciones automáticas

### 3.1 Referencias cruzadas

Se verificó, recorriendo todos los `.tex`, que cada `\label` tenga al menos un
`\ref` y que ningún `\ref` apunte a una etiqueta inexistente.

| Comprobación | Resultado |
|---|---|
| Etiquetas definidas | 117 |
| Referencias emitidas | 291 |
| Etiquetas sin ninguna referencia | **0** |
| Referencias a etiquetas inexistentes | **0** |
| **Figuras** con `caption`, `label` y mención en el texto | **4 / 4** |
| **Cuadros** con `caption`, `label` y mención en el texto | **72 / 72** |

Esto satisface el requisito heredado de la plantilla original: «TODOS los cuadros
y figuras deberán ser mencionados en el texto, indicando qué información se
presenta y una breve explicación». Cada cuadro y cada figura va seguido de un
párrafo que explica qué muestra.

### 3.2 Índices y numeración

| Comprobación | Resultado |
|---|---|
| Tabla de contenido | Generada; incluye preliminares, PARTE I, PARTE II y ANEXOS |
| Índice de cuadros | 72 entradas, rotuladas «Cuadro» |
| Índice de figuras | 4 entradas |
| Numeración de secciones | Reinicia en cada parte (I: 1–9; II: 1–10), como el Word original |
| Numeración de anexos | `ANEXO A` … `ANEXO G`; `\ref` devuelve «ANEXO C» |
| Marcadores del PDF | Generados con `bookmark`, numerados y desplegados |
| Encabezado y pie | Presentes en todas las páginas; pie con «Página *n* de *N*» |

### 3.3 Caracteres y tipografía

| Comprobación | Resultado |
|---|---|
| Caracteres Unicode fuera del repertorio T1 | Declarados en el preámbulo (`×`, `÷`, `≤`, `≥`, `≠`, `→`, `←`, `≈`, `−`, `•`) |
| Partición de palabras | Patrones españoles activos (verificado con `\showhyphens`) |
| Acentuación y signos de apertura | Correctos en cuerpo, tablas, figuras e índices |

## 4. Revisión visual

Se renderizaron páginas a imagen y se inspeccionaron. Páginas revisadas:
consideraciones de uso, portada, información del proyecto, control de versiones,
tabla de contenido, las cuatro figuras, una página de estrategia con cuadro y
cajas, el inicio de los anexos, el Anexo G y los cuadros 23, 49 y 72 (definición
de cobertura, resultados agregados y cobertura de la base).

Las **tres variantes** se revisaron por separado: portada de cada una, una página
de contenido de la variante final (sin guías ni observaciones) y una página de la
variante anotada con un bloque de observación junto a la figura que corrige.

| Aspecto | Resultado |
|---|---|
| Banda de encabezado (3 celdas + banda inferior) | Reproduce la del Word original |
| Pie con universidad, facultad, paginación y versión | Correcto |
| Cuadros dentro del margen | Sí, en todas las páginas |
| Figuras dentro del margen | Sí; las cuatro caben en el ancho de texto |
| Solapamiento de nodos en los diagramas | Ninguno tras las correcciones de §5 |
| Cajas de color con su título y sangrado | Correctas; se parten entre páginas cuando procede |
| Etiqueta de variante en la portada | Presente en trabajo y anotada; ausente en la final, como se pretendía |
| Bloques de observación | Sólo en la variante anotada, junto al apartado que corrigen |
| Ausencia de las figuras en la variante final | Sin huecos ni párrafos huérfanos; el texto enlaza directamente con el apartado siguiente |
| Fichas largas de los anexos | Se parten con encabezado repetido y aviso de continuación |

## 5. Problemas encontrados y corregidos

| # | Problema | Diagnóstico | Corrección |
|---|---|---|---|
| 1 | 227 `Overfull \hbox`, el mayor de 345 pt (≈12 cm) | `\campo` componía el marcador dentro de un `\colorbox`, que es una caja indivisible y desbordaba toda columna estrecha. | `\campo` pasa a componer texto normal en cursiva y color. Overfull: 227 → 67. |
| 2 | Desbordes residuales en encabezados de tabla («Responsable», «Componente») | TeX no divide con guion la **primera palabra** de un párrafo, y cada celda es un párrafo. | Se añadió `\hspace{0pt}` al inicio de los tipos de columna `Y`, `C`, `L` y `E`, y se pasó de `\raggedright` a `\RaggedRight` (`ragged2e`), que conserva la partición. Overfull: 67 → 7. |
| 3 | 7 desbordes de ≈36 pt en el índice | Las entradas de anexo («ANEXO G») exceden la caja de número de 2,3 em de `article`. | `\iniciaranexos` ensancha la caja a 6,4 em desde ese punto del índice (`\cftsetindents`, `tocloft`). Overfull: 7 → 1. |
| 4 | 1 desborde de 5,6 pt en la figura de estructura | La fila de cinco cuadros medía 16,1 cm frente a 16,0 cm de ancho de texto. | Se redujo el ancho de los cuadros de 2,45 cm a 2,35 cm. Overfull: 1 → **0**. |
| 5 | 2 `Underfull \hbox` en la primera página | Nombres de macro largos en `\texttt` sin puntos de corte dejaban líneas muy sueltas. | Se reescribió la viñeta remitiendo a `make final`. Underfull: 2 → **0**. |
| 6 | Cuadros superpuestos en la figura de estructura | Nodos colocados por coordenadas absolutas; al crecer el texto, se solapaban. | Reconstruida con posicionamiento relativo (`below=… of …`), que desplaza los nodos en vez de superponerlos. |
| 7 | Una flecha atravesaba un nodo en la figura de procesos | El bucle «lecciones aprendidas» cruzaba el cuadro de política de prueba. | Se rodea por encima de la capa organizacional; además se reordenó el bucle de confirmación/regresión para que ambas actividades retornen a la ejecución. |
| 8 | Rótulo automático «Tabla» frente a menciones «Cuadro» en el texto | Las versiones recientes de `babel-spanish` rotulan «Tabla» por defecto. | Se fija `\tablename` a «Cuadro» con `\addto\captionsspanish`, coherente con el Word original. |
| 9 | La nota al pie de los cuadros se montaba sobre la última línea de la tabla | `\notatabla` aplicaba `\vspace{-4pt}`. | Se sustituyó por `\vspace{3pt}`. |
| 10 | Fichas largas dejaban media página en blanco | `table[H]` no puede partirse: si no cabe, salta de página entera. | Las seis fichas extensas pasaron a `xltabular` (`longtable` con columnas `X`), con encabezado repetido. |
| 11 | Los marcadores de fecha se partían como `dd/m-m/aaaa` | Efecto secundario de habilitar la partición en la primera palabra, en columnas de 1,9–2,3 cm. | Se ensancharon a 2,5 cm las seis columnas de fecha; las columnas `Y` absorben la diferencia. |
| 12 | La compilación abortaba con «Unicode character ≥ (U+2265)» | T1 no incluye `≥`, `×` ni `÷`. | Se declararon esos caracteres y otros ocho en el preámbulo, de modo que el equipo pueda escribirlos directamente. |
| 13 | COB-01 se definía sobre «requisitos con al menos un caso **aprobado**» | Mezclaba cobertura con resultado: un requisito probado por un caso fallido contaba como no cubierto, de modo que la cobertura bajaba al encontrar defectos. | COB-01 pasa a medir elementos ejercitados con independencia del veredicto; los criterios de salida pasan de tres tipos a cuatro y el resumen de cobertura de la base separa «¿Cubierto?» de «Veredictos». |
| 14 | Un envoltorio `\begin{ficha}` alrededor de `xltabular` abortaba con «File ended while scanning use of `\TX@get@body`» | `xltabular` busca literalmente su `\end{xltabular}` en la entrada y no lo encuentra si está oculto tras una macro. | Las fichas se escriben con el entorno literal en cada anexo; el patrón queda documentado en el README. |
| 15 | El pie mostraba «Página ii de 58» en los preliminares | Los preliminares van en romanos y el cuerpo reinicia en arábigos, así que `\pageref{LastPage}` devuelve el último número arábigo, no el total físico. | El interruptor `\ifcontarpaginas` omite «de *N*» fuera del cuerpo. |
| 17 | La versión de entrega hablaba de sí misma como plantilla | Explicaba el código de colores, remitía a `config/metadata.tex` y se presentaba como «esta plantilla»: voz del andamiaje en un documento sobre un sistema. | Discriminante derivado `\ifversionfinal`: se suprime la leyenda de colores y `\segunvariante{…}{…}` reescribe las referencias al documento. Menciones a «plantilla» en la final: 7 → **0**. |
| 16 | Los diagramas de la norma aparecían en el documento de entrega | Son material de apoyo sobre ISO/IEC/IEEE 29119, no contenido del plan; se incorporaron al documento sin distinguir entre existir en el repositorio y formar parte del entregable. | Cuarto interruptor `\mostrardiagramas`, activo en trabajo y anotada. Las 15 menciones dispersas se envolvieron en `\sidiag{...}` y se reescribieron para leerse sin el inciso; se ocultan también el índice de figuras y la mención a las figuras en el título del índice de cuadros. |

## 6. Lo que esta validación **no** cubre

- **No se ha compilado en macOS con MacTeX** (véase la nota de §1).
- **No es una verificación de conformidad con ISO/IEC/IEEE 29119.** Se comprobó
  que la plantilla compila y que su contenido es coherente con los materiales de
  `sources/`; no se contrastó contra el texto normativo, del que no se dispone.
  Véase `DECISIONES.md` (D-01).
- **No se ha validado el contenido de un plan real.** La plantilla está vacía por
  diseño: se verificó que los formatos existen y son utilizables, no que un
  proyecto concreto los haya completado correctamente.
- **No se comprobó la impresión física.** Se verificó el tamaño A4, los márgenes y
  que ningún elemento sobresalga del ancho de texto, pero no se imprimió.

## 7. Cómo reproducir esta validación

```sh
make cleanall
make            # plantilla-trabajo.pdf
make annotated  # plantilla-anotada.pdf
make final      # plantilla-final.pdf

for v in trabajo anotada final; do
  grep -c "Overfull\|Underfull\|LaTeX Warning" plantilla-$v.log   # debe dar 0
done

# las variantes de trabajo y final no deben filtrar el historial de revisión
for v in trabajo final; do
  pdftotext plantilla-$v.pdf - | grep -ci "plantilla \(original\|anterior\)"  # debe dar 0
done

# la variante final no debe llevar figuras ni referencias sin resolver
pdftotext plantilla-final.pdf - | grep -c "^Figura "   # debe dar 0
pdftotext plantilla-final.pdf - | grep -c "??"         # debe dar 0

# ni hablar de sí misma como plantilla o herramienta
pdftotext plantilla-final.pdf - | grep -ciE "plantilla|metadata\\.tex|bloques de color"  # debe dar 0
```

Para repetir la comprobación de referencias cruzadas basta con verificar que
`main.log` no contenga la advertencia `There were undefined references` tras una
compilación completa desde cero.

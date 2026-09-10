# Decisiones de diseño

Registro de las decisiones tomadas al rehacer la plantilla, con su motivo. Se
documentan aquí para que puedan revisarse o revertirse con conocimiento de causa.
La correspondencia detallada con la plantilla original está en `MATRIZ_CAMBIOS.md`.

Convención de fuentes: `OBS` = documento de observaciones; `PDF` = plan de trabajo
29119; `PLANTILLA` = Word original; `PROPIA` = criterio de esta reingeniería.

---

## D-01. No se declara conformidad con ISO/IEC/IEEE 29119

**Decisión.** La plantilla afirma explícitamente que *no* declara conformidad, y
lo repite en la introducción del PDF generado.

**Motivo.** Las observaciones son claras: «Tampoco basta con llenar sus apartados
para demostrar la aplicación completa de ISO/IEC/IEEE 29119: deben existir
actividades realizadas, decisiones y evidencias trazables», y «una declaración
formal requeriría revisar el texto normativo completo de la edición elegida».
No se dispone del texto normativo. Todas las referencias a actividades (TP1, TMC3,
TE3, ES1…) proceden del PDF de procesos incluido en `sources/`, y se citan como
correspondencia, no como prueba de cumplimiento. *(OBS §1, §Alcance)*

## D-02. Las reglas del curso se conservan, pero se etiquetan

**Decisión.** Ninguna regla académica se elimina. Todas pasan a una caja naranja
rotulada «Política académica de la Experiencia Educativa»: los porcentajes
100/80/60/40, las tres entregas, el mínimo de dos métricas por tipo, la autoridad
de aprobación del profesor, la escala de criticidad y la restricción de no reparar
defectos.

**Motivo.** «Son válidas para el curso, pero deben identificarse como políticas
locales.» Eliminarlas rompería la plantilla para su uso previsto; presentarlas sin
marcar reproduce el problema detectado. Las cajas naranjas **no** desaparecen con
`make final`, porque son contenido vigente del plan, no guías de redacción.
*(OBS §5.1)*

## D-03. Cuatro tipos de bloque, no «texto en verde»

**Decisión.** Se sustituye el mecanismo original (párrafos en verde que el alumno
debe borrar) por cuatro entornos tipificados con color, título y semántica propia:
`instruccion` (verde), `ejemplo` (azul), `politicaacademica` (naranja) y
`notanormativa` (gris).

**Motivo.** El requisito de la revisión es que «el lector debe poder distinguir
inmediatamente requisito del curso, contenido del plan y referencia normativa».
Un único color no permite esa distinción. Además, borrar texto a mano es propenso
a error: los dos primeros tipos se apagan con un interruptor. *(OBS §5.1 · PROPIA)*

## D-04. Tres variantes desde una sola fuente

**Decisión.** `config/metadata.tex` define tres interruptores
(`mostrarinstrucciones`, `mostrarejemplos`, `mostrarobservaciones`) y el Makefile
compila tres variantes de un único `main.tex`, sin duplicar las secciones:

| Variante | Comando | Archivo | instrucciones | ejemplos | observaciones | diagramas |
|---|---|---|:--:|:--:|:--:|:--:|
| Trabajo | `make` | `plantilla-trabajo.pdf` | sí | sí | — | sí |
| Anotada | `make annotated` | `plantilla-anotada.pdf` | sí | sí | sí | sí |
| Final | `make final` | `plantilla-final.pdf` | — | — | — | — |

Cada objetivo define una macro (`\VARIANTEANOTADA`, `\VARIANTEFINAL`) al llamar a
`pdflatex`, y `metadata.tex` la traduce a la combinación de interruptores. La
variante de trabajo es la configuración por defecto, de modo que un
`latexmk -pdf main.tex` sin argumentos produce la plantilla por rellenar.

**Motivo.** Trabajar con las guías visibles, conservar la trazabilidad del proceso
de mejora y entregar un documento limpio son tres necesidades distintas que no
pueden satisfacerse con un solo PDF, pero tampoco justifican mantener tres copias
del contenido: cualquier corrección tendría que aplicarse tres veces y las
variantes divergirían. Páginas resultantes: 67 (trabajo), 73 (anotada), 53 (final).
*(PROPIA)*

## D-05. Orden de las secciones: riesgos antes que estrategia

**Decisión.** El registro de riesgos pasa de ser la sección 4 (después de los
puntos de revisión) a ser la sección 3, inmediatamente antes de la estrategia.

**Motivo.** En el modelo de procesos, la planificación identifica y analiza
riesgos (TP3) y decide su tratamiento (TP4) **antes** de diseñar la estrategia
(TP5): «es el único proceso que integra explícitamente la gestión de riesgos como
paso previo». Con el orden original, la estrategia se redactaba antes de conocer
los riesgos que debía mitigar. *(PDF §1.3)*

## D-06. El seguimiento se convierte en sección propia

**Decisión.** El apartado 3 original («Puntos de revisión de la prueba», que
listaba las entregas del curso) se convierte en la sección 5 «Seguimiento y
control», con cinco subapartados. Los hitos de entrega son ahora uno de ellos.

**Motivo.** «Organiza entregas del curso, pero no define el monitoreo continuo ni
las acciones de control.» El monitoreo y control es un proceso completo
(TMC1–TMC4) que opera de forma concurrente, no una lista de fechas.
*(OBS §3, §5.6)*

## D-07. El caso de prueba y la ejecución son artefactos distintos

**Decisión.** El Anexo A (casos) no contiene ningún campo de resultado real,
veredicto ni evidencia. Esos campos viven en el Anexo C (ejecuciones), que tiene
identificador propio y admite varias ejecuciones del mismo caso. El registro
consolidado del Anexo C incluye deliberadamente un ejemplo con el mismo caso
ejecutado dos veces, en versiones distintas del software.

**Motivo.** «El resultado real se conserva en la ejecución para permitir repetir
el mismo caso sin sobrescribir su historial.» Es la separación que hace posible
demostrar cuándo se corrigió un defecto. *(OBS §6 · PDF §1.4, TE3)*

## D-08. Criterio de entrada y precondición se definen por contraste

**Decisión.** El apartado de criterios de entrada incluye una nota que los
distingue de las precondiciones de un caso de prueba, y ambos conceptos aparecen
en el glosario.

**Motivo.** Es una confusión frecuente que invalida la auditoría del inicio de un
ciclo: el criterio de entrada es una condición de proceso que se verifica una vez
y tiene responsable; la precondición es un estado del sistema que se establece en
cada ejecución. *(OBS §3 · PDF §1.4, TE1 · PROPIA)*

## D-09. La cobertura se define antes de medirse

**Decisión.** El apartado de cobertura obliga a declarar siete atributos
(elemento, numerador, denominador, fórmula, objetivo, fuente e interpretación)
antes de poder usar una medida como criterio de salida. El reporte final presenta
en filas separadas el «avance de ejecución» y cada medida de cobertura.

**Motivo.** «La proporción de casos ejecutados es avance de ejecución y no
equivale automáticamente a cobertura de requisitos.» Separarlas en el cuadro de
resultados hace la confusión difícil de cometer. *(OBS §4.4)*

## D-10. La escala de criticidad se mantiene, pero se remite a ISO/IEC/IEEE 15026-3

**Decisión.** Se conservan las cuatro etiquetas (Catastrófico, Crítico, Marginal,
Despreciable) como política académica, con un cuadro que obliga a definir
significado, asignador y efecto sobre la estrategia. Una nota gris aclara que
ISO/IEC/IEEE 29119 no define esa escala y señala ISO/IEC/IEEE 15026-3 como el
marco de niveles de integridad.

**Motivo.** «No deben tratarse como un esquema normativo de niveles de integridad
sin explicar sus requisitos y fundamento. La referencia sobre niveles de
integridad es ISO/IEC/IEEE 15026-3.» No se afirma que la escala del curso *sea*
conforme a esa norma, sólo se indica dónde está el marco aplicable. *(OBS §4.5)*

## D-11. Finalización y aceptación se separan en apartados distintos

**Decisión.** El §4.7 (criterios de finalización) cierra únicamente actividades.
La Parte II dedica apartados independientes a resultados, evaluación de criterios
de salida, incidentes abiertos, riesgos residuales y decisión de aceptación, esta
última con una autoridad identificada en `config/metadata.tex`.

**Motivo.** «Ejecutar todos los casos, aun cuando fallen, no demuestra que el
producto sea aceptable. La decisión debe considerar defectos abiertos, severidad,
resultados, cobertura relevante y autoridad de aceptación.» *(OBS §4.6)*

## D-12. La contradicción sobre corrección de defectos se resuelve declarándola

**Decisión.** No se elimina el apartado de confirmación y regresión pese a que el
curso indica que no se repararán defectos. En su lugar, una caja de política
académica obliga a declarar si habrá correcciones durante el periodo y, si no las
hay, a registrar esa limitación y los defectos pendientes al cierre.

**Motivo.** «No es una contradicción inevitable: se debe explicar si el equipo
solo reportará hallazgos y si repetirá pruebas cuando el desarrollador entregue
una corrección.» *(OBS §5.3)*

---

## Decisiones técnicas de la implementación LaTeX

## D-13. `article` con partes manuales, no `report`

**Decisión.** Clase `article`, con un comando `\parteplan` que compone las
portadillas de PARTE I / PARTE II, reinicia el contador de secciones y añade la
entrada al índice.

**Motivo.** El Word original numera 1–8 en la Parte I y 1–7 en la Parte II. Con
`report` habría que usar capítulos, cuya numeración y salto de página no
corresponden a esa estructura. *(PLANTILLA)*

## D-14. Los anexos numeran «ANEXO A», no «A»

**Decisión.** `\iniciaranexos` redefine `\thesection` como `ANEXO \Alph{section}`.
Como efecto secundario deseado, `\ref{anx:casos}` produce «ANEXO A», y el texto
puede escribir «véase el \ref{anx:casos}».

**Motivo.** Reproduce la rotulación del Word original y evita tener que escribir
«Anexo» a mano delante de cada referencia, con el riesgo de desincronización.
Requiere ensanchar la caja del número en el índice a partir de los anexos, lo que
hace `\cftsetindents` (paquete `tocloft`) desde el propio `\iniciaranexos`.

## D-15. Rótulo «Cuadro», no «Tabla»

**Decisión.** Se fija `\tablename` a «Cuadro» mediante `\addto\captionsspanish`.

**Motivo.** La plantilla original exige que «TODOS los cuadros y figuras deberán
ser mencionados en el texto», y todo el cuerpo redactado cita «Cuadro~\ref{...}».
Las versiones recientes de `babel-spanish` rotulan por defecto «Tabla», lo que
produciría un desajuste entre el rótulo automático y las menciones del texto.
Para volver a «Tabla» hay que cambiar las dos líneas de `config/preamble.tex` y,
con ellas, las menciones del cuerpo.

## D-16. Fichas largas como `xltabular`, no como flotantes

**Decisión.** Las seis fichas extensas (caso, procedimiento, ejecución, incidente,
informe de estado y registro de seguimiento) se componen con `xltabular`
—`longtable` con columnas `X`— en lugar de `table[H]` + `tabularx`.

**Motivo.** Con `[H]` una ficha que no cabe en el espacio restante salta de página
y deja un hueco de media página. `xltabular` permite que la ficha se parta y
continúe, con encabezado repetido y aviso de continuación. No se usó un entorno
propio que envolviera `xltabular` porque el paquete busca literalmente su
`\end{xltabular}` en la entrada y falla si está oculto tras una macro.

## D-17. Ajustes tipográficos para columnas estrechas

**Decisión.** Los tipos de columna (`Y`, `C`, `L`, `E`) insertan `\hspace{0pt}` al
inicio de cada celda y usan `\RaggedRight`/`\Centering` de `ragged2e`. El comando
`\campo` compone texto normal, no una caja de color.

**Motivo.** TeX no divide con guion la primera palabra de un párrafo, por lo que
un encabezado como «Responsable» desbordaba una columna de 1,9 cm. `\RaggedRight`
conserva la división que `\raggedright` desalienta. Un `\colorbox` es indivisible
y desbordaba cualquier celda estrecha. Con estos tres cambios el documento pasó de
227 desbordes (`Overfull \hbox`) a cero.

## D-18. Diagramas en TikZ con posicionamiento relativo

**Decisión.** Los cuatro diagramas son TikZ en archivos propios de `diagrams/`,
cada uno con su `figure`, `caption` y `label` completos. La figura de estructura
usa `below=… of …` en lugar de coordenadas absolutas.

**Motivo.** Vectoriales, versionables y compilables sin dependencias externas. El
posicionamiento relativo evita que los cuadros se superpongan al editar sus textos
—problema que apareció en la primera versión de la figura de estructura—. Los
diagramas con topología fija (procesos, técnicas, trazabilidad) sí usan
coordenadas, porque su disposición forma parte del mensaje.

## D-19. Los materiales de origen se versionan en `sources/`

**Decisión.** Los tres documentos de partida se incluyen en el repositorio.

**Motivo.** La matriz de cambios y este registro los citan constantemente; sin
ellos las justificaciones no serían verificables. **Los tres diagramas PNG no se
incluyen**: se analizaron a partir de las imágenes aportadas en la conversación de
trabajo, pero no se recibieron como archivos. Sus correcciones están documentadas
en `MATRIZ_CAMBIOS.md` §9 y en los comentarios de cabecera de cada archivo de
`diagrams/`.

## D-20. Interpretaciones de observaciones ambiguas

| Observación | Lectura adoptada | Motivo |
|---|---|---|
| «Nuevo 5.11» para los criterios de entrada (OBS §6) | Se colocaron como §4.6, antes de los criterios de salida, en lugar de al final de la estrategia. | Entrada y salida se leen juntas; dejar la entrada al final los separaba. La ubicación sugerida era orientativa. |
| «Añadir C–D» a los anexos (OBS §6) | Se añadieron cinco anexos (C a G), no dos. | Los mismos apartados de OBS §3 y §6 exigen informe de estado, preparación de entorno y matriz de trazabilidad, que no caben en dos anexos. |
| «Ampliar el apartado 3» (OBS §3) | Se reescribió como sección completa (D-06). | Ampliar una lista de entregas no produce un proceso de monitoreo. |
| «Dos métricas de cada tipo» y tres tipos (proceso, producto, proyecto) | Se conserva la clasificación del curso tal cual. | La revisión no cuestiona los tipos, sólo pide identificar el mínimo como regla local. |

## D-21. La observación se separa de la nota conceptual

**Decisión.** Se distinguen dos tipos de bloque que antes estaban fundidos:

- `notanormativa` (gris) explica un **concepto** que el plan necesita —qué es una
  base de prueba, por qué confirmación y regresión no son lo mismo, qué mide la
  cobertura—. Se conserva en las tres variantes.
- `observacion` (morado) explica el **origen de una corrección**: qué hacía la
  plantilla anterior, qué se cambió, por qué y con qué fuente. Sólo se compone en
  la variante anotada.

La separación exigió partir bloques existentes: casi todas las cajas que
empezaban por «Corrección respecto de la plantilla original» contenían a la vez la
definición que el plan necesita y el historial del cambio. Por ejemplo, la caja de
riesgos contenía las definiciones de riesgo de producto y de proyecto —que se
quedan— y la explicación de que la plantilla anterior las confundía —que se va a
la observación—.

**Motivo.** El requisito es que la plantilla de trabajo y la final no muestren el
historial de correcciones, pero sí las distinciones conceptuales sin las cuales el
plan se rellena mal. Etiquetar los bloques sin partirlos habría obligado a elegir
entre perder el concepto o filtrar el historial. Hay 32 observaciones repartidas
en secciones, anexos y diagramas.

**Sin duplicación.** El bloque del PDF es un resumen de cuatro campos; la
explicación completa, con el estado de cada elemento y su fuente, está en
`MATRIZ_CAMBIOS.md`, al que remite cada `\obsfuente`. *(PROPIA)*

## D-22. El pie sólo cuenta páginas en el cuerpo

**Decisión.** El pie muestra «Página *n* de *N*» en el cuerpo del documento y
sólo «Página *n*» en los preliminares, mediante el interruptor `\ifcontarpaginas`
que `main.tex` activa al llamar a `\pagenumbering{arabic}`.

**Motivo.** Los preliminares se numeran en romanos y el cuerpo reinicia en
arábigos, de modo que `\pageref{LastPage}` devuelve el último número arábigo
(58 en la variante de trabajo), no el total físico de páginas (67). Antes de la
corrección, una página preliminar mostraba «Página ii de 58», mezclando dos
sistemas de numeración. *(PROPIA)*

## D-23. Los diagramas son material de apoyo, no contenido del plan

**Decisión.** Las cuatro figuras se controlan con un cuarto interruptor,
`mostrardiagramas`: aparecen en las variantes de trabajo y anotada, y no en la
final.

**Motivo.** Los tres PNG de partida eran material de referencia sobre la norma, y
sus versiones corregidas siguen siéndolo: las figuras 1–3 explican qué es
ISO/IEC/IEEE 29119, no dicen nada del sistema bajo prueba. Un plan de pruebas
entregado no necesita un diagrama de las partes de la norma. La figura 4 (cadena
de trazabilidad) es de creación propia y explica cómo rellenar el Anexo G, de modo
que también es instruccional; se le da el mismo trato para mantener una regla
única.

Que los diagramas se incorporaran al documento no fue una invención: el encargo
inicial pedía crear al menos tres visualizaciones en `diagrams/` y exigía que toda
figura se mencionara desde el texto. Lo que faltaba era distinguir entre
*existir en el repositorio* y *formar parte del documento entregable*.

**Consecuencia técnica.** Quince menciones a las figuras estaban repartidas por
secciones y anexos. Se envolvieron en `\sidiag{...}` y se reescribieron las frases
para que se sostengan sin el inciso; los párrafos que sólo describían una figura
—los que el encargo exigía para cada una— quedaron dentro del bloque condicional
junto a la propia figura. También se ocultan el índice de figuras y la mención a
las figuras en el título del índice de cuadros. Resultado: 0 referencias sin
resolver en las tres variantes.

**Reversible.** Basta con poner `\mostrardiagramastrue` dentro del bloque
`\VARIANTEFINAL` de `config/metadata.tex` si el curso espera que la entrega
incluya el marco conceptual. *(PROPIA · decisión del autor tras revisar el
resultado)*

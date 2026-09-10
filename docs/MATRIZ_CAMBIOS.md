# Matriz de cambios respecto de la plantilla original

Documento de trabajo. Relaciona cada elemento de
`sources/PS-PLANTILLAPlanPruebas_Ver011025.docx` con su tratamiento en la nueva
plantilla LaTeX, y registra los elementos que se añadieron por no existir en el
original.

## Cómo leer esta matriz

**Estado** describe la situación del elemento *en la plantilla original*:

| Estado | Significado |
|---|---|
| Correcto | El apartado existía y era adecuado; se conserva con ajustes menores. |
| Parcial | Existía una base, pero no desarrollaba los elementos operativos necesarios. |
| Incorrecto | La instrucción existía pero inducía a error y se ha corregido. |
| Ausente | No existía apartado ni formato; se ha añadido. |
| Regla local | Requisito del curso presentado sin distinguirse de la norma; se ha etiquetado. |

**Fuente** identifica de dónde procede el cambio:

- `OBS §n` — `sources/Observaciones_plantilla_pruebas_ISO_29119.docx`, apartado *n*.
- `PDF §n` — `sources/Plan_de_trabajo_29119_AngelAguilar.pdf`, sección *n*.
- `DIAG` — análisis de los tres diagramas de referencia.
- `PLANTILLA` — la plantilla Word original.
- `DECISIÓN` — criterio propio de esta reingeniería, registrado en `DECISIONES.md`.

Las referencias a apartados nuevos (`§2.3`, `§4.5`…) corresponden a la numeración
del PDF generado por esta plantilla, no a la del Word original.

---

## 1. Portada, control de versiones e identificación

| Elemento original | Estado | Observación | Cambio realizado | Justificación | Fuente |
|---|---|---|---|---|---|
| Consideraciones generales (texto en verde) | Parcial | Pedía «remover el texto explicativo en verde», sin mecanismo para hacerlo. | Sistema de cuatro cajas tipificadas (`instruccion`, `ejemplo`, `politicaacademica`, `notanormativa`) y un interruptor en `config/metadata.tex`; `make final` genera el PDF de entrega sin guías. | Borrar texto a mano es propenso a error y no distingue guía de contenido. | PLANTILLA · DECISIÓN |
| Portada | Correcto | Identifica proyecto, equipo y fecha. | Se conserva; los datos se centralizan en `config/metadata.tex`. | Evita editar el mismo dato en varios lugares. | OBS §2 |
| Historial de versiones | Correcto | Registra cambios del documento. | Se conserva como Cuadro *Historial de cambios*. | — | OBS §2 |
| Revisiones (cuadro único con estatus) | Parcial | «Conviene distinguir revisión de aprobación formal.» | Separado en dos cuadros: *Revisiones* (hallazgos) y *Aprobación formal* (autoridad, ámbito, estatus). | Una revisión puede cerrarse sin que el documento quede aprobado; son decisiones distintas. | OBS §2 |
| Información del proyecto | Correcto | — | Se conserva, añadiendo equipo de prueba y periodo del esfuerzo. | Delimita lo que el resto del plan puede asumir. | PLANTILLA |
| Control de versiones limitado al documento | Parcial | «Además del historial del Word, identificar versiones de software, casos, scripts, datos y entorno usadas en cada ejecución.» | Nuevo §4.12 *Gestión de configuración de los activos de prueba* y columnas de versión en el registro de ejecución. | Sin identificar la versión de cada activo, un resultado no es reproducible. | OBS §3 |

## 2. Introducción

| Elemento original | Estado | Observación | Cambio realizado | Justificación | Fuente |
|---|---|---|---|---|---|
| 1.1 Presentación del documento | Correcto | — | Se conserva; se añade la Figura 1 (estructura de la norma) y una declaración explícita de que la plantilla **no** declara conformidad. | «Tampoco basta con llenar sus apartados para demostrar la aplicación completa de ISO/IEC/IEEE 29119.» | OBS §1 |
| 1.2 Referentes utilizados | Parcial | «Debe precisarse la edición de cada norma y la versión de las fuentes técnicas.» | El cuadro pide edición/versión y clave; la clave se reutiliza en la base de prueba. | «La referencia al Anexo A, páginas 32–38, de la Parte 4 queda ambigua sin año de edición.» | OBS §2, §5.2 |
| 1.3 Glosario | Parcial | Pedía definir términos, sin señalar cuáles. | Se añaden seis definiciones ya redactadas (objeto de prueba, base de prueba, condición, defecto, fallo, incidente). | La revisión detectó que esos conceptos se confundían entre sí en el propio documento. | OBS §4.3, §5.5 · PDF §3.1 |

## 3. Contexto

| Elemento original | Estado | Observación | Cambio realizado | Justificación | Fuente |
|---|---|---|---|---|---|
| 2.1 Proyecto caso de estudio | Correcto | — | Se conserva. | — | OBS §2 |
| 2.2 Objetivo y elementos de prueba | Incorrecto | «El apartado 2.2 equipara los elementos de prueba con casos de uso.» | Dividido en §2.2 *Objetivo de la prueba* y §2.3 *Objeto de prueba y base de prueba*, con dos cuadros independientes. | Un caso de uso es base de prueba, no objeto de prueba; separarlos permite usar la plantilla en proyectos sin casos de uso. | OBS §4.3 |
| 2.2 Objetivo de la prueba | Parcial | Pedía el objetivo «de la prueba, no del sistema», sin ilustrarlo. | Se añade un ejemplo contrastado y un cuadro de objetivos específicos ligados a riesgos. | Un objetivo sin riesgo asociado no permite justificar la estrategia. | PDF §1.3 (TP1) |
| 2.2 Nivel de integridad (SIL) | Regla local | «Las etiquetas catastrófico, crítico, marginal y despreciable requieren una definición y un método de asignación.» | Nuevo §2.4 *Criticidad asignada*, con cuadro de definición (significado, quién asigna, efecto) y nota que remite a **ISO/IEC/IEEE 15026-3**. | No debe presentarse como esquema normativo de ISO 29119 sin explicar su fundamento. | OBS §4.5 |
| 2.3 Alcance de la prueba | Incorrecto | «El apartado 2.3 orienta las características a probar hacia requisitos no funcionales.» | §2.5 con tres cuadros: características funcionales, no funcionales y exclusiones con su riesgo asumido. | «Debe solicitar expresamente ambos tipos.» Las exclusiones deben justificarse y ligarse a riesgos. | OBS §4.2 |
| 2.4 Supuestos y límites | Correcto | «Hay que separar reglas académicas de referencias normativas.» | Se conserva; los porcentajes 100/80/60/40 pasan a una caja *Política académica* que remite a §4.5 para el denominador. | El lector debe distinguir requisito del curso de umbral normativo. | OBS §4.4, §5.1 |
| 2.5 Interesados | Correcto | «Conviene añadir … expectativas.» | Se conserva; se añade columna de información y frecuencia, que alimenta el plan de comunicación. | Cierra el vínculo entre interesados e informes de estado. | OBS §2 · PDF §1.3 (TMC4) |

## 4. Riesgos

| Elemento original | Estado | Observación | Cambio realizado | Justificación | Fuente |
|---|---|---|---|---|---|
| 4.1 Riesgos del producto | Incorrecto | «El riesgo del producto se explica principalmente por su efecto sobre el tiempo y el desarrollo de la prueba.» | Definición corregida: consecuencia de un fallo del software sobre usuarios, negocio, datos, seguridad u operación, con ejemplo. | «Debe centrarse en consecuencias de fallos del software.» | OBS §4.1 |
| 4.2 Riesgos del proyecto | Correcto | — | Se conserva; se añaden categorías sugeridas. | — | OBS §4.1 |
| Escala de valoración | Ausente | Pedía «evaluar la exposición» sin definir la escala. | Nuevo cuadro de escala (probabilidad, impacto, fórmula y umbral). | Sin escala declarada, dos personas valoran el mismo riesgo de forma distinta. | DECISIÓN |
| Tratamiento de riesgos | Ausente | — | Nuevo §3.3, con la columna «¿se mitiga mediante prueba?». | Actividad **TP4** de la norma; es lo que justifica el contenido de la estrategia. | PDF §1.3 (TP4) |

## 5. Estrategia

| Elemento original | Estado | Observación | Cambio realizado | Justificación | Fuente |
|---|---|---|---|---|---|
| 5.1 Niveles de prueba | Parcial | «Elegir y justificar los niveles aplicables, sin asumir que todos deben ejecutarse.» | Cuadro con columna «¿se aplica?» y justificación obligatoria también para los niveles descartados. | Un nivel omitido en silencio no es una decisión documentada. | OBS §5.2 |
| Tipos de prueba | Ausente | — | Nuevo §4.2, ligado a las características del alcance. | Evita declarar características no funcionales sin prever cómo evaluarlas. | DECISIÓN |
| Diseño: condiciones y elementos de cobertura | Parcial | «Ampliar 2.2 y 5.3 con condiciones, modelos o elementos de cobertura.» | Nuevo §4.3 con cuadro de condiciones de prueba y elementos de cobertura. | Reconstruye los eslabones **TD2/TD3** que el original saltaba. | OBS §3 · PDF §1.4 |
| 5.3 Técnicas de diseño | Correcto | «No es necesario incluir todas las técnicas: hay que elegir las pertinentes y justificar.» | Se conserva; el cuadro pide objetivo, elemento, justificación, cobertura y riesgo. | — | OBS §5.6 |
| Definición de cobertura | Ausente | «La proporción de casos ejecutados es avance de ejecución y no equivale automáticamente a cobertura.» | Nuevo §4.5, con numerador, denominador, fórmula, objetivo, fuente e interpretación. | Un porcentaje sin denominador declarado no es interpretable. | OBS §4.4 |
| **Criterios de entrada** | Ausente | «Definir condiciones para iniciar cada nivel o ciclo … indicar quién verifica.» | Nuevo §4.6 con seis criterios mínimos (CE-01…CE-06) y nota que los distingue de las precondiciones de un caso. | La actividad **TE1** exige verificar criterios de entrada antes de ejecutar. | OBS §3 · PDF §1.4 (TE1) |
| 5.4 Criterios de finalización | Incorrecto | «El apartado 5.4 favorece terminar por cobertura … Ejecutar todos los casos, aun cuando fallen, no demuestra que el producto sea aceptable.» | §4.7 limitado a cerrar *actividades*; la aceptación se traslada a la Parte II §7. | Separa actividades completadas, resultados y decisión de aceptación. | OBS §4.6 |
| 5.5 Métricas | Correcto | Regla del curso: dos métricas de cada tipo. | Se conserva; el cuadro exige fórmula, fuente e interpretación acordada. El mínimo se etiqueta como política académica. | «Sustituirlas por campos configurables: … métricas justificadas.» | OBS §5.1 |
| 5.6 Datos de prueba | Parcial | «Complementar 5.6–5.7 con comprobación de preparación, versiones, responsable, mantenimiento y restauración.» | §4.11 con versión y tratamiento de confidencialidad; registro efectivo en el Anexo F. | Los datos también tienen versión: sin ella un resultado no se reproduce. | OBS §3 |
| 5.7 Entorno de prueba | Parcial | Ídem. | §4.10 con un segundo cuadro de gestión: preparación, verificación, versiones, mantenimiento, restauración y liberación (**ES1/ES2**). | Describir el entorno no acredita que estuviera listo al ejecutar. | OBS §3 · PDF §1.4 |
| 5.8 Re-prueba y regresión | Incorrecto | «La confirmación comprueba que el defecto original quedó corregido; la regresión busca efectos adversos del cambio.» | §4.9 define ambas por separado, con cuadro comparativo y criterio de selección propio. | «No llamar regresión a cualquier verificación de una corrección.» | OBS §5.5 |
| 5.9 Suspensión y reinicio | Correcto | — | Se conserva; se añade «qué se repite al reanudar». | Evita discutir al reanudar qué resultados siguen siendo válidos. | PLANTILLA |
| 5.10 Desviaciones | Correcto | «Precisar … parametrizar reglas académicas.» | Se conserva; el cuadro admite también las adaptaciones al reutilizar la plantilla. | Una adaptación legítima no debe confundirse con un incumplimiento. | OBS §5.1 |
| 5.2 Entregables | Parcial | Listaba cuatro entregables. | Se amplía a nueve, incorporando los registros nuevos, con ubicación y responsable. | «Siempre que el plan indique dónde están, quién los mantiene y cómo se relacionan.» | OBS §3 |

## 6. Seguimiento, incidentes y planificación operativa

| Elemento original | Estado | Observación | Cambio realizado | Justificación | Fuente |
|---|---|---|---|---|---|
| 3. Puntos de revisión | Parcial | «Organiza entregas del curso, pero no define el monitoreo continuo ni las acciones de control.» | Sección 5 completa: enfoque de monitoreo (TMC1), hitos, registro de seguimiento por periodo, reglas de control y replanificación (TMC3) y plan de comunicación (TMC4). | El seguimiento acompaña la ejecución; no es un evento entre entregas. | OBS §3, §5.6 |
| Informe de estado | Ausente | «Incluir un formato periódico con avance, cobertura, incidentes, consumo de esfuerzo y acciones pendientes.» | Nuevo Anexo E, con los campos solicitados agrupados en cinco bloques. | Producto de la actividad **TMC4**. | OBS §3, §6 |
| Gestión de incidentes | Ausente | «Definir formato, estados, responsables, severidad, prioridad, comunicación y tratamiento de incidentes abiertos.» | Nueva sección 6 (análisis IR1, escalas separadas de severidad y prioridad, ocho estados con responsable, comunicación) y Anexo D. | Sin ella, un resultado fallido no produce consecuencia documentada. | OBS §3 · PDF §1.4 (IR1/IR2) |
| Las 3 entregas del curso | Regla local | «Las tres entregas … son condiciones académicas.» | Se conservan como caja *Política académica* dentro de un cuadro de hitos configurable. | «Válidas para el curso, pero deben identificarse como políticas locales.» | OBS §5.1 |
| 6. Actividades y estimaciones | Correcto | «Conviene añadir dependencias, disponibilidad y competencias.» | Se conserva; se añaden dependencias y producto generado, con ocho actividades de partida derivadas del modelo de procesos. | Las dependencias son las que hacen realista el cronograma. | OBS §2 |
| 7. Equipo de trabajo | Correcto | Ídem. | Se conserva; nuevo cuadro de competencias, disponibilidad y formación (**TP6**). | Una brecha de competencia es un riesgo de proyecto. | OBS §2 · PDF §1.3 |
| 8. Calendarización | Correcto | — | Se conserva, ligado a las actividades y a los hitos. | — | PLANTILLA |

## 7. Parte II — Reporte de finalización

| Elemento original | Estado | Observación | Cambio realizado | Justificación | Fuente |
|---|---|---|---|---|---|
| 1. Resumen de pruebas realizadas | Correcto | — | Se conserva; cuadro real *vs.* planificado con estado por actividad. | — | PLANTILLA |
| 2. Evaluación de la finalización | Incorrecto | «Determinar el nivel de garantía de calidad con base a la cobertura» mezcla proceso y producto. | Desglosado en cinco apartados: resultados, evaluación de criterios de salida, incidentes abiertos, riesgos residuales y **decisión de aceptación** con autoridad identificada. | «Deben distinguirse actividades completadas, resultados obtenidos y aceptación del riesgo residual.» | OBS §4.6 |
| 3. Métricas de prueba | Correcto | — | Se conserva; obliga a declarar qué no permite concluir cada métrica. | — | PLANTILLA |
| 4. Riesgos residuales | Correcto | — | Se conserva; se alimenta de riesgos no mitigados, exclusiones e incidentes abiertos. | Hace explícito lo que la prueba no llegó a descartar. | OBS §4.6 |
| 5. Entregables | Correcto | — | Se conserva con versión final y ubicación. | — | PLANTILLA |
| 6. Activos reutilizables | Parcial | «Indicar repositorio, responsables y activos conservados; restaurar o liberar entorno y tratar los datos conforme a lo acordado.» | Sección 9 *Archivo, limpieza y activos reutilizables*, con cuadro de custodia (**TC1**) y cuadro de limpieza y liberación (**TC2**), incluida la eliminación segura de datos. | El original no decía dónde se conservan ni en qué estado se deja el entorno. | OBS §3 |
| 7. Lecciones aprendidas | Correcto | — | Se conserva; se añaden ámbito, evidencia que la sustenta y destinatario. | **TC3** retroalimenta la capa organizacional: una lección sin destinatario no cierra el bucle. | PDF §2.2 |

## 8. Anexos

| Elemento original | Estado | Observación | Cambio realizado | Justificación | Fuente |
|---|---|---|---|---|---|
| Anexo A. Procedimientos | Parcial | «Solicita incorporarlos, pero no proporciona campos o formatos listos.» | Anexo B con ficha completa (ID, casos incluidos, orden y su justificación, entorno, datos, preparación, pasos, guion, limpieza) más índice. | **TD6**: el procedimiento es el artefacto que realmente se ejecuta. | OBS §2, §6 |
| Anexo B. Casos de prueba | Parcial | Ídem. | Anexo A con ficha completa (base, riesgo, condición, técnica, elemento de cobertura, precondiciones, datos, pasos, resultado esperado, postcondiciones, limpieza) más índice. | «Campos mínimos para los anexos.» | OBS §6 |
| Registro de ejecución | Ausente | «El resultado real se conserva en la ejecución para permitir repetir el mismo caso sin sobrescribir su historial.» | Nuevo Anexo C: ficha de ejecución y registro consolidado, con ejemplo de un mismo caso ejecutado dos veces. | **TE3**. Separa el diseño del caso del resultado de una ejecución concreta. | OBS §3, §6 |
| Registro de incidentes | Ausente | — | Nuevo Anexo D: ficha con origen determinado (IR1), severidad y prioridad separadas, reproducción, estado y disposición. | «Distinguir severidad de prioridad.» | OBS §3 · PDF §3.2 |
| Informe de estado | Ausente | — | Nuevo Anexo E. | Ver sección 6 de esta matriz. | OBS §6 |
| Preparación de entorno y datos | Ausente | — | Nuevo Anexo F: verificación de disponibilidad, cambios durante el ciclo y restauración. | Implementa la verificación de los criterios CE-04 y CE-05. | OBS §3 |
| Matriz de trazabilidad | Parcial | «Elaborar una tabla de trazabilidad» sin indicar qué encadenar. | Nuevo Anexo G: matriz de nueve columnas (base → riesgo → condición → elemento de cobertura → caso → procedimiento → ejecución → evidencia → incidente), Figura 4 y resumen de cobertura de la base. | Reproduce la cadena `REQ-01 → RIESGO-03 → COND-02 → CP-07 → EJ-014 → EVID-014 / INC-05`. | OBS §6 |

## 9. Diagramas

| Diagrama original | Estado | Observación | Cambio realizado | Justificación | Fuente |
|---|---|---|---|---|---|
| `normal general.png` | Incorrecto | Colgaba «Procesos organizacionales · política y estrategia» de la Parte 1. | `diagrams/estructura-29119.tex`: los procesos —incluido el organizacional— cuelgan de la Parte 2; la Parte 1 aporta conceptos y vocabulario. Se añade la correspondencia con las secciones y anexos de este documento. | «La Parte 2 describe los procesos de prueba; la Parte 3 describe su documentación; la Parte 4 define técnicas.» | OBS §1 · DIAG |
| `Procesos de prueba.png` | Incorrecto | «"Verificar correcciones" se asocia a regresión»; el flujo se lee como secuencia rígida. | `diagrams/procesos-prueba.tex`: confirmación y regresión como actividades distintas; monitoreo y control marcado como concurrente; tres bucles explícitos (control, replanificación, mejora); entorno y datos como proceso propio (ES1/ES2); planificación con riesgos de producto **y** de proyecto. | «El seguimiento acompaña la ejecución; los incidentes y riesgos nuevos pueden cambiar prioridades y reabrir la planificación.» | OBS §5.5, §5.6 · PDF §2.2 · DIAG |
| `tenicas de prueba.png` | Incorrecto | «El diagrama muestra 100 % como cobertura mínima para sentencias y decisiones.» | `diagrams/tecnicas-prueba.tex`: se retiran los porcentajes y cada técnica indica el **elemento de cobertura** que produce; nota que remite el objetivo numérico al apartado 4.5; se añaden conjetura de errores y palabras clave. | «No hay base en los materiales examinados para atribuir ese mínimo universal a ISO 29119.» | OBS §5.4 · DIAG |
| — | Ausente | — | `diagrams/cadena-trazabilidad.tex` (nuevo). | Hace visible la cadena que el Anexo G registra. | DECISIÓN |

## 10. Observaciones que NO se implementaron como cambio de estructura

| Observación | Tratamiento | Motivo |
|---|---|---|
| «Precisar ediciones normativas» (OBS §5.2) | El cuadro de referentes exige edición y cláusula verificada, pero la plantilla **no** cita cláusulas concretas de la norma. | No se dispone del texto normativo completo; citar cláusulas sin verificarlas reproduciría el error señalado. Las referencias se hacen a actividades (TP1, TE3…) tomadas del PDF de procesos, que sí está disponible. |
| «Pruebas por palabras clave» (OBS §5.6) | Se menciona como enfoque opcional en el mapa de técnicas y en el cuadro de técnicas. | «Su falta no invalida la plantilla. Esa técnica o enfoque debe incorporarse si se utiliza.» |
| Prioridades alta/media de OBS §6 | Se implementaron todas, pero no se reproduce la tabla de prioridades en el PDF. | «Las prioridades son recomendaciones prácticas de esta evaluación, no categorías impuestas por la norma»; pertenecen a este documento de trabajo, no al plan. |

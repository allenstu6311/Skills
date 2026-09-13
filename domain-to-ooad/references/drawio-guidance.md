# Editable OOAD diagrams

## OOAD.drawio

Produce standard uncompressed draw.io XML: `mxfile` containing named `diagram` pages, each with an `mxGraphModel` and `root`. Include root cell `0` and layer cell `1`. Use editable `mxCell` vertices and edges with `mxGeometry`, not a screenshot or a single embedded SVG. Escape XML text correctly.

### Class diagram page(s)

- Include relevant attributes, operation signatures, and necessary interfaces/services, with a consistent legend for visibility and relation notation.
- Show meaningful association roles and multiplicities. Use composition only when ownership and lifecycle justify it; do not infer composition from a database foreign key.
- Distinguish catalog/current data from historical snapshots where required.
- Show interfaces or polymorphism only when variation in behavior warrants them.
- Add short rule references or notes to explain important responsibilities and invariants.
- Mark technical design choices as design, separate from confirmed domain policy. Put unresolved policy notes near affected elements without inventing an implementation.

### Sequence diagram pages

- One page per principal use case or a focused related scenario; choose coverage based on scope, not a fixed number.
- Use editable participant boxes, dashed lifelines, ordered message arrows, and return arrows when useful.
- Show actor/system boundaries and object collaboration at the same level as the class diagram.
- Express confirmed prerequisites and branches with guards and UML `alt`, `opt`, or `loop` frames as appropriate.
- Sequence messages invoking modeled objects must match class operations. Include types/signatures consistently enough to trace responsibilities.
- Clearly mark manual external work; do not turn a human action into an automated integration.
- Include confirmed rejection/failure paths where they affect the design. Pending cancellation or recovery rules remain pending.

### Activity diagram pages

- Generate only when activity diagrams are selected. Use editable UML activity notation: initial node, action nodes, directed control flows, decision/merge diamonds with guards, and activity-final nodes.
- Split into focused business processes or use cases. Use swimlanes when actor/system responsibility matters; keep manual external actions in the correct lane.
- Label outgoing decision edges with confirmed conditions. Account for alternative outcomes without inventing business rules; unresolved branches must be visibly pending.
- Use fork/join bars only for confirmed concurrent behavior. A decision between alternatives is not a parallel fork. Distinguish a flow-final from an activity-final if both are needed.
- Show loops and exits clearly; avoid dead ends except explicitly modeled termination or pending paths. Trace important actions and guards to specification rules.
- For activity-only requests, do not require method signatures or generate additional class/sequence pages.

### Review criteria

Apply checks only to selected types. Follow sequences to verify receiving-object responsibilities; when class diagrams are also selected, verify they carry the information and operations needed by the sequences. Trace activities from initial to final nodes, checking guards, loops, lane ownership, and fork/join semantics. Compare shared scenarios across selected types for consistent ordering and outcomes. Ensure state changes and recalculation occur at confirmed points. Avoid routing every action through one generic service while domain objects have no justified responsibilities.

Use readable spacing, consistent class widths, and no overlapping text or arrows where avoidable. Split overcrowded diagrams into focused pages while retaining consistent names. XML structural checks do not establish layout quality; report visual validation separately.

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

### Review criteria

Follow a scenario through the sequence diagram and confirm each receiving object owns the indicated responsibility. Ensure state changes and recalculation occur at the confirmed points. Verify the class model carries information required by the sequence. Avoid diagrams that merely route every action through one generic service while domain objects have no justified responsibilities.

Use readable spacing, consistent class widths, and no overlapping text or arrows where avoidable. Split overcrowded diagrams into focused pages while retaining consistent names. XML structural checks do not establish layout quality; report visual validation separately.

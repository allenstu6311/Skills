---
name: domain-to-ooad
description: Generate or update editable draw.io class and sequence diagrams from a confirmed DOMAIN.md, with framework-independent attributes, operations, interfaces, and necessary services. Use for OOAD design from established business specifications; does not conduct a full initial requirements interview or implement application code.
---

# Domain to OOAD

Use the user's language (default Traditional Chinese). Treat confirmed business requirements as authority, and separate them from technical design choices. This skill can run independently from the requirements interview skill.

## 1. Establish the design basis

Read the supplied DOMAIN.md, applicable repository instructions, existing diagrams, and relevant code. Inspect code narrowly to understand current behavior and integration constraints. Code does not override confirmed requirements. A request to design from a supplied specification is sufficient to start; do not require a redundant approval merely because it was created in another conversation.

If no specification is supplied or discoverable, ask for its location or recommend preparing it with `requirements-to-domain`. Do not silently turn raw requirements into an approved specification. Preserve the user's design scope and distinguish current implementation from intended behavior.

Check whether business gaps or contradictions affect object identity, ownership, invariants, lifecycle, calculations, or principal scenarios. Previously agreed non-core pending items may remain explicitly unresolved; never encode them as decided policy.

## 2. Resolve only design-blocking business gaps

When a gap appears, identify the affected rule and scenario and explain its concrete design impact. Reuse the user's established clarification mode if known; otherwise default to one question at a time. Offer concrete candidate answers and 「待確認（需向客戶確認）」. If several questions are requested together, give stable IDs and a copyable checklist.

For interactive selection tools, keep the turn open until the reply arrives and use interruptible waits of at most 60 seconds where available. Do not send a final answer while a selector is pending. Selecting pending does not approve a recommendation. Continue independent analysis, then summarize blockers for client consultation; do not finalize an affected diagram through assumptions.

Do not restart the whole requirements interview. Once the user resolves a business gap, show the complete amended DOMAIN.md draft, clearly identify the change, and obtain approval before writing it and continuing affected design. If the user defers to `requirements-to-domain`, provide the focused questions and affected rules as the handoff. This is optional routing, not a mandatory dependency.

Routine technical choices that do not change business policy can be made and explained without another specification approval. Do not add a blanket approval gate for generating diagrams from already confirmed rules.

## 3. Design object responsibilities and interactions

Read [references/drawio-guidance.md](references/drawio-guidance.md). Produce a framework-independent design sufficient to guide implementation: relevant attributes, operations, interfaces, and necessary application/domain services.

Derive responsibilities from behavior, ownership, invariants, and variation, not only nouns or database tables. Do not force inheritance, repositories, controllers, patterns, or one class per noun. Actors are not automatically persisted classes. Preserve historical snapshots and external/manual boundaries when specified.

Build the class model and use-case sequences together. Each modeled receiving object's message must match an operation on its class/interface. Use consistent names and types across pages. Include confirmed alternate or failure paths that affect responsibilities; do not invent retries, refunds, recovery, or cancellation policies. Link significant responsibilities to specification rule IDs or section references.

## 4. Write editable draw.io output

Write a native OOAD.drawio, or the user-specified path, with separate pages for the class diagram and each principal use case's sequence diagram. Inspect existing output and preserve unrelated pages and user edits. Default to the project root when no location is specified.

Use editable XML vertices and edges, not a raster image or a single embedded SVG. Keep design choices and unresolved policy notes visibly distinct from confirmed business rules. Do not install integrations, implement code, modify schemas, or migrate data as a side effect.

## 5. Validate and deliver

Check rule coverage, multiplicities, lifecycle constraints, snapshot requirements, and consistency among the specification, class operations, and sequence messages. Verify calculations and alternate paths against confirmed examples and conditions.

Validate XML syntax, unique cell IDs within each page, and valid parent/source/target references. Check that shapes and connections remain editable. Visually inspect with an available renderer when possible; XML validation alone does not prove layout quality. State clearly if opening/rendering was not verified.

Finish with artifact links, concise validation evidence, and agreed unresolved limitations. On subsequent design updates, re-read the relevant specification and update affected class and sequence pages together. Business changes require the focused clarification and amended-specification approval described above.

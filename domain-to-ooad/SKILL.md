---
name: domain-to-ooad
description: Use when explicitly invoked by the user to generate or update a selected combination of editable draw.io class, sequence, and activity diagrams from user-provided requirements or domain specifications, regardless of filename. Produces framework-independent OOAD design and business-flow visualization; does not conduct a full requirements interview or implement application code.
---

# Domain to OOAD

Use the user's language (default Traditional Chinese). Translate the English question examples and option labels below into that language. Treat confirmed business requirements as authority, and separate them from technical design choices. This skill can run independently from the requirements interview skill.

## 0. Select diagram types

Before design or business-gap questions, ask which diagrams to generate, allowing any nonempty combination: 1. class diagrams, 2. sequence diagrams, 3. activity diagrams. If the user already explicitly named the desired types, use that selection without asking again. Preserve the selection through follow-ups and allow changes without discarding confirmed requirements.

Use a genuine interactive multi-select ONLY if the available tool schema supports it, with independent choices for class diagrams, sequence diagrams, and activity diagrams. Do not invent a multi-select parameter or claim a single-select UI supports multiple checked options.

When only single-select is available, use ONE interactive question with ALL seven nonempty combinations as selectable options, in this order:
1. "Class diagram only"
2. "Sequence diagram only"
3. "Activity diagram only"
4. "Class and sequence diagrams"
5. "Class and activity diagrams"
6. "Sequence and activity diagrams"
7. "All three diagram types"

`request_user_input_async` supports this seven-option single-select fallback. Do not replace it with only common shortcuts or require typed combinations when all choices can be displayed. If a different tool imposes a smaller option limit, respect its schema and use successive single-select questions asking whether to include each type, one question at a time. Require at least one type. Free-text diagram names or combinations may still be accepted when unambiguous. If using numbered free-text answers, explicitly define their mapping in the displayed question; never confuse option numbers 1–7 with diagram-type numbers 1–3. If the answer is empty or ambiguous, clarify rather than assuming all types. Only when no interactive input tool is available, explain the limitation briefly and ask in conversation.

Keep the turn open until this selection is answered, following the waiting rules below. This output-scope question does not require a business-policy pending option. Generate only selected diagram types; do not produce an unselected class diagram merely to support another diagram. Existing unselected pages must be preserved; report any known inconsistencies without changing them unless the user authorizes expanding scope.

## 0.1 Select delivery mode

After diagram types are answered, and before business clarification or generation, display a separate interactive single-choice question: "How would you like to receive the diagrams?" with options "Open in the draw.io browser editor" and "Save a .drawio file". Ask one question at a time and follow the same keep-open waiting rules. Honor an already explicit delivery preference without asking again; preserve it through follow-ups.

Browser mode means an actual rendered diagram in a browser editor, not HTML source, a generic homepage, or an unopened file. File mode means an accessible native diagram artifact with a clear file link. Do not silently substitute one mode for the other. If browser tools cannot open/import the diagram, explain that specific limitation and ask whether to switch to file delivery or provide a user-openable editor link. Do not claim the diagram is open without observing it.

## 1. Establish the design basis

Read the user-specified requirements or domain specification document(s), regardless of filename, and applicable repository instructions. DOMAIN.md is only an example filename, not a prerequisite. For an update, inspect the existing diagrams; for a new design, derive the diagrams from the supplied specifications rather than treating existing output as the completed task. Read relevant code only as needed. Inspect code narrowly to understand current behavior and integration constraints. Code does not override confirmed requirements. A request to design from a supplied specification is sufficient to start; do not require a redundant approval merely because it was created in another conversation.

If no specification is supplied or discoverable, ask for its location or recommend preparing it with `requirements-to-domain`. Do not silently turn raw requirements into an approved specification. Preserve the user's design scope and distinguish current implementation from intended behavior.

Check whether business gaps or contradictions affect the selected diagrams' object identity, ownership, invariants, lifecycle, calculations, or principal scenarios. Ask only about gaps that materially affect the selected output, not questions needed solely for an unselected diagram type. Previously agreed non-core pending items may remain explicitly unresolved; never encode them as decided policy.

## 2. Resolve only design-blocking business gaps

When a gap appears, identify the affected rule and scenario and explain its concrete design impact. Reuse the user's established clarification mode if known; otherwise default to one question at a time. Offer concrete candidate answers and "Pending (requires client confirmation)". If several questions are requested together, give stable IDs and a copyable checklist.

In one-question mode, MUST call `request_user_input_async` when available to display ONE interactive question with concrete selectable answers and a final "Pending (requires client confirmation)" option. Merely writing bullet points, numbered choices, or a question in the final response does not satisfy this requirement. Only fall back to a plain-text question when the selection tool is unavailable or has explicitly failed, and explain that limitation briefly. The user-selected complete-checklist mode remains a copyable list rather than multiple popup questions.

After displaying the selector, keep the turn open until the reply arrives and use interruptible waits of at most 60 seconds where available. Do not send a final answer while a selector is pending, even after repeated wait timeouts. A timeout is not a tool failure or a user answer; do not replace the selector with a textual final-response question. If the user reports that choices disappeared, display the same unanswered question again and wait. Avoid repeated reminders while waiting. Selecting "Pending" does not approve a recommendation. Continue independent analysis, then summarize blockers for client consultation only after the user has replied; do not finalize an affected diagram through assumptions.

Do not restart the whole requirements interview. Once the user resolves a business gap, show the complete amended draft of the affected user-specified specification document, clearly identify the change, and obtain approval before writing it and continuing affected design. If the user defers to `requirements-to-domain`, provide the focused questions and affected rules as the handoff. This is optional routing, not a mandatory dependency.

Routine technical choices that do not change business policy can be made and explained without another specification approval. Do not add a blanket approval gate for generating diagrams from already confirmed rules.

## 3. Design object responsibilities and interactions

Read [references/drawio-guidance.md](references/drawio-guidance.md). Produce a framework-independent design sufficient to guide implementation: relevant attributes, operations, interfaces, and necessary application/domain services.

Derive responsibilities from behavior, ownership, invariants, and variation, not only nouns or database tables. Do not force inheritance, repositories, controllers, patterns, or one class per noun. Actors are not automatically persisted classes. Preserve historical snapshots and external/manual boundaries when specified.

Develop selected diagrams together where they overlap. When class and sequence diagrams are both selected, each modeled receiving object's message must match an operation on its class/interface. For sequence-only output, keep participant responsibilities and operations coherent without emitting an extra class diagram. For activity-only output, focus on actions, decisions, responsibilities, and control flow without requiring class signatures or infrastructure design. Use consistent names and types across selected pages. Include confirmed alternate or failure paths; do not invent retries, refunds, recovery, concurrency, or cancellation policies. Link significant responsibilities/actions to specification rule IDs or section references.

## 4. Generate and deliver in the selected mode

Write a native OOAD.drawio, or the user-specified path, with separate named pages for selected diagram types: class model pages, per-use-case sequence pages, and/or activity pages for business processes. Inspect existing output and preserve unrelated pages and user edits. Default to the project root when no location is specified.

For browser delivery, discover available browser/editor tools, open the draw.io editor and load the generated native diagram using supported import/open capabilities. Verify that the diagram itself is visible and identify the browser tab and page names in the handoff. Selecting this mode authorizes opening the visible editor; do not publish to a public host or upload to an unrelated cloud account. A locally saved native file may support import or recovery, but it is not a substitute for the selected browser experience. If an editor link is supplied as an agreed fallback, label it accurately as a link for the user to open, not a browser already opened. State whether edits were saved or exist only in the browser session.

For file delivery, provide one clearly labeled clickable OOAD.drawio download/artifact link when the environment supports downloads. In a shared local workspace, provide a clickable absolute file path and say "Saved locally" rather than claiming a download attachment exists. Include one short instruction to open it with draw.io and list its diagram pages. Never tell the user to copy raw XML or HTML to assemble the result.

Do not create or deliver HTML wrappers, raw HTML/XML code blocks, temporary scripts, or a collection of helper files as the user-facing result. Any necessary internal helpers remain implementation details. Use editable XML vertices and edges, not a raster image or a single embedded SVG. Keep design choices and unresolved policy notes visibly distinct from confirmed business rules. Do not install integrations, implement code, modify schemas, or migrate data as a side effect.

## 5. Validate and deliver

Check rule coverage and lifecycle constraints in all selected diagrams; check multiplicities and snapshot requirements for class models, message/operation coherence for sequences, and guards, branches, responsibility lanes, and termination for activities. Check consistency between selected diagrams where they overlap. Verify calculations and alternate paths against confirmed examples and conditions.

Validate XML syntax, unique cell IDs within each page, and valid parent/source/target references. Check that shapes and connections remain editable. Visually inspect with an available renderer when possible; XML validation alone does not prove layout quality. State clearly if opening/rendering was not verified.

Lead the final response with where the user can see the result: the verified browser editor/tab and page names, or the directly linked native file and its saved location. Then give the diagram types generated, concise validation evidence, and agreed unresolved limitations. Never finish with only "done" or unexplained HTML files. Separate file creation, browser opening, rendering verification, and persistence claims according to what actually succeeded. On subsequent design updates, re-read the relevant specification and update affected pages of selected types together. Business changes require the focused clarification and amended-specification approval described above.

---
name: requirements-to-domain
description: Clarify informal software requirements into a confirmed DOMAIN.md through a one-question-at-a-time interview or a complete client discussion checklist. Use for business requirements discovery and specification revisions; does not generate design diagrams or implement code.
---

# Requirements to Domain

Use the user's language (default Traditional Chinese). Convert informal requirements into explicit domain concepts, responsibilities, rules, and scenarios before designing software. Preserve scope: examples are not automatically required features, and missing details are not permission to invent business policy.

## Workflow

### 0. Choose the clarification mode

At the start of a new requirements intake, before asking business clarification questions, display ONE selection question: 「這次要用哪種方式確認需求？」 with two options:
- 「逐題確認」: ask one question at a time, adapt to answers, then consolidate pending client questions.
- 「一次列出完整確認清單」: present all currently identifiable questions and candidate answers together for direct discussion with the client.

Use the available selection tool and keep the turn open until answered, using interruptible waits of at most 60 seconds where available. Do not send a final answer while this selection is pending. If no selection tool is available, ask in conversation. This workflow-choice question does not need the business-policy pending option. If the user already explicitly selected a mode, honor it without asking again. Preserve the choice through follow-ups and allow switching modes without losing answers or question IDs.

### 1. Understand and compare

Read supplied requirements, existing DOMAIN.md, applicable repository instructions, and relevant code when available. Inspect narrowly around the requested functionality. Distinguish requested behavior, confirmed specification, current implementation, and proposed design. Code is evidence of current behavior, not authority over requirements. Ask about material conflicts; confirmed user decisions prevail. Do not silently replace requirements with implementation behavior.

Maintain a working decision ledger in conversation context: confirmed facts, unresolved questions, proposals, and explicit deferrals. Do not create new output Markdown or diagram files before the full specification draft has been approved. Existing files may be read during discovery.

### 2. Clarify in the selected mode

Both modes use the discovery lenses and completion criteria below. Recommendations are proposals, not confirmed requirements. Every business question offers 「待確認（需向客戶確認）」, including follow-ups.

#### Mode A: Interview one question at a time

Use a probing, concrete interview: examine ambiguous terms, challenge contradictions respectfully, and ask what happens in realistic scenarios. Each turn presents exactly ONE decision question, not a bundle disguised as one question. Prioritize questions whose answers determine other questions.

When `request_user_input_async` is available, display one question with 1–2 concrete suggested answers, putting the recommendation first with a brief consequence, and ALWAYS include a final selectable option: 「待確認（需向客戶確認）」. Allow free-text answers. Do not make the user choose implementation details to answer a business question. If selection tools are unavailable, ask one concise question in conversation and explicitly allow the user to answer 「待確認」.

Selecting pending defers the question; it does not approve the recommended answer or authorize carrying the uncertainty into final deliverables. Record the original question, scenario, candidate answers and consequences, whether it is core, and affected rules/use cases. Continue with independent questions, even when the deferred question is core. Defer dependent questions with their dependency noted instead of assuming an answer or repeatedly pressing for one. This pending option also applies to follow-up clarification rounds.

After displaying an asynchronous question, keep the turn open until the reply arrives: do not send a final answer while the choice is pending. Use interruptible waits of at most 60 seconds where available; silence is never approval. Briefly acknowledge the answer, update the working decisions, and then ask the next question. Do not repeat questions already answered.

#### Mode B: Complete client discussion checklist

After inspecting the requirements and relevant context, present all currently identifiable material questions together in the conversation. Do not conduct the sequential interview first and do not open a separate interactive selector for every question. The deliverable is a copyable discussion checklist, suitable for using with the client immediately.

Group questions by business topic and order prerequisite decisions before dependent questions. Give each question a stable ID (Q01, Q02, ...), one concrete decision/scenario, 1–3 meaningful candidate answers with their consequences, and a final 「待確認（需向客戶確認）」 option. Mark recommendations, core/non-core status, and affected behavior. Allow an alternative free-text answer. For conditional questions, state the condition explicitly rather than assuming the preceding answer. Use readable numbered blocks; avoid very wide tables.

Include a brief summary of known scope and confirmed facts, and a compact answer example such as 「Q01：A；Q02：待確認；Q03：自訂答案……」. Explain that new questions may emerge from client answers; “complete” means complete against currently available information, not a guarantee that no further clarification will be needed.

Once the complete checklist has been presented, end the turn and let the user discuss it with the client. Do not create DOMAIN.md or diagrams at this point. Accept full or partial answers by question ID; retain unanswered items as unresolved. On follow-up, list only newly discovered, conflicting, or still-unanswered questions, preserving IDs and the selected batch mode. Do not silently switch to sequential questioning. Move to the client-confirmation checkpoint when reconciling answers, reusing the existing checklist rather than duplicating it.

#### Shared discovery and completion criteria

Inspect, as relevant to scope:
- Actors, permissions, system boundary, and manual/external actions.
- Domain terms, identity, ownership, cardinality, and historical snapshots.
- Commands, prerequisites, outcomes, state transitions, and invalid operations.
- Calculations, units, thresholds, composition, rounding, and worked examples.
- Editing, deletion, restoration, dependencies, and historical retention.
- Main scenarios and business-relevant alternate or failure paths.

These are discovery lenses, not a mandatory exhaustive questionnaire. Avoid speculative edge cases unrelated to the task.

Finish the interview pass when all material areas have been examined and each identified question is answered, deferred, or dependent on a deferred answer. Core questions that change object identity, ownership, invariants, lifecycle, or principal flow may be deferred during the interview but must be resolved before specification drafting and file generation. Other questions may remain pending in final deliverables ONLY with the user's explicit agreement after the client-confirmation checkpoint. Do not force scope reduction merely because the user needs to consult the client.

### 3. Client-confirmation checkpoint

If questions were deferred, present a consolidated client-confirmation list in the conversation BEFORE presenting the complete DOMAIN.md draft or creating output files. Make it copyable and understandable to the client: stable question ID, concrete question/scenario, candidate answers and consequences, affected behavior, core/non-core status, and any dependent questions. Keep recommendations clearly separate from decisions. Include a brief summary of confirmed decisions for context.

Pause here so the user can consult the client. Ending the turn with the completed list is appropriate; do not leave a selection question pending while ending. Do not contact the client yourself. Do not create DOMAIN.md, design diagrams, or a separate Markdown checklist unless the user explicitly requests that checklist file.

When the user returns with answers, reconcile them by question ID, preserve previously confirmed decisions, and ask any new or conflicting clarification in the selected mode with the pending option. Repeat the checkpoint if needed. Proceed only after core questions are resolved and the user confirms readiness for drafting; ask explicitly whether any remaining non-core questions may be carried into the draft as pending. If all questions are answered and none were deferred, proceed to the full draft directly.

### 4. Present the complete specification draft

Read [references/domain-format.md](references/domain-format.md). Present the FULL proposed DOMAIN.md in the conversation, including agreed pending questions, not just a decision summary. Adapt sections to the domain rather than copying DHC-specific concepts or policies.

Ask one confirmation question and wait for explicit approval before writing DOMAIN.md or diagrams. If the draft must span multiple messages, show every part before asking for approval. If the user requests changes, revise the affected decisions and present the complete revised draft for confirmation. Earlier interview answers do not replace this final draft confirmation.

### 5. Write and validate the approved specification

Write the approved DOMAIN.md to the user-specified location, or the project root by default. Inspect existing content and preserve unrelated requirements. Check consistent terminology, rule IDs, state transitions, examples, and agreement between scenarios and rules. Keep agreed pending items explicit; do not promote proposals into decisions.

Do not generate diagrams, implement code, change schemas, or run migrations. Finish with a link to DOMAIN.md and any agreed pending limitations. The user can invoke `domain-to-ooad` separately when ready for design; do not automatically start it unless the user already requested both stages. This skill remains usable without the design skill installed.

For later changes, clarify only affected or conflicting decisions, preserve established answers, present the complete revised specification, and obtain confirmation before updating it.

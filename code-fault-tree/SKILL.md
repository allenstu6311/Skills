---
name: code-fault-tree
description: Build code-grounded fault diagnosis trees that branch from a user operation through symptoms and possible causes to the software's actual handling. Use for requests such as fault diagnosis trees, failure-scenario branching diagrams, explicitly marking absent solutions, or checking recovery coverage visually. Not a module architecture diagram or generic troubleshooting advice.
---

# Code-grounded fault diagnosis tree

Produce a diagnosis tree grounded in the current repository:
**User operation → observable symptoms → possible causes → finer distinctions → actual handling or “None”.**

Use the user's language. This is a diagnostic branching tree, not a formal Boolean fault-tree analysis unless requested. Organize from the user's experience, not folders, classes, managers, or a feature checklist.

## Establish scope and shape

Infer the operation and execution path from the conversation and code. State a short scope, including relevant clients, protocols and processes; do not silently extend one playback path into claims about the entire application.

When shape or scope is unclear, render one meaningful branch first for feedback. Do not require another confirmation when the user already approved this shape or explicitly requested a full diagram.

A shape example, not a universal catalog:
Playback -> connection lost -> network / device / authentication issues -> actual handling for each cause.
Include other relevant symptoms discovered in the project; do not limit the tree to examples given by the user.

## Trace actual implementation

Read applicable repository instructions and trace the real entrypoint across involved modules and process boundaries. Follow events, IPC, subscriptions, timeouts, retries, cleanup, decoder or library calls, and caller behavior. Function names and comments alone are not evidence.

For each branch, distinguish:
- The condition that could occur.
- Whether the application detects it, and how.
- Whether it distinguishes the root cause or funnels several causes into one handler.
- What the handler actually does and whether its caller completes recovery.
- What remains unimplemented or unverified.

Attach stable scenario IDs to leaves so diagrams, evidence tables and future tests can refer to the same condition. Avoid claiming every possible fault is covered.

## Classify every terminal branch

Every leaf must end with an actual action or an explicit absence:

- **Implemented**: identify the implemented action, not a guarantee of recovery.
- **Partial**: identify both the existing action and the missing step.
- **None**: explicitly name the absent detection, diagnosis, or automatic recovery in the inspected path.
- **Unverified / undetermined**: implementation depends on uninspected native code, external infrastructure, library behavior, or runtime evidence. Do not relabel uncertainty as absence.

“Only logs”, “ignores input”, or “waits indefinitely” are observable behaviors, not solutions. Label them accordingly, e.g. **No automatic recovery; only logs the error**.

A retry is not root-cause repair. Recreating a backend worker is not proof that frontend sessions, recording or subscriptions recover. Check cancellation and cleanup across the entire relevant transition.

Possible causes supplied by analysis must be labeled as diagnostic possibilities: a decision diamond must not imply the software can distinguish them. If causes share one generic retry, show the shared handler and explicitly state the lack of cause-specific handling.

Do not insert recommended fixes into the current-behavior tree. If requested separately, label proposals clearly and keep them distinct from implementation.

## Render and preserve evidence

Use the user's requested diagram tool. Prefer draw.io when no tool is specified and draw.io MCP is available. Discover its callable tools; create an editable diagram and open it through the MCP when available. If unavailable, save a compatible diagram source and state that it was not opened; do not silently substitute a different service.

Use clear branch labels and short leaf text. Optional colors:
- Green: implemented handling.
- Amber: partial or unverified.
- Red: no applicable handling.
Always include textual statuses; color alone is insufficient.

For a large tree, split into linked pages by symptom or provide an overview with detailed branches. Preserve the user-operation root and cause-to-handling structure.

Save an editable source in the project's existing documentation location, or docs/diagrams when appropriate. Prefer .drawio XML for a self-contained draw.io file; preserve Mermaid source if used for import. State exactly which artifact was saved.

Save a compact evidence table alongside the diagram:
scenario ID | condition | detection | actual handling / missing behavior | file and function or line | verification status.

Include scope and inspection date. “None” means no matching implementation found in the inspected path, not proof that external systems or manual operations cannot help. Clearly distinguish static evidence from executed fault tests.

Do not change application behavior or run disruptive fault injection just to draw the tree. Run tests only within the user's authorized scope. Close with the artifact links, the scope, and a brief description of any material uncertainty.

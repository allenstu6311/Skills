---
name: design-decision
description: Decide, mid-edit, whether the change point in front of you warrants a design pattern. Invoke right before continuing when you are about to (1) add a third-or-later branch to an existing if/else or switch; (2) write a block that is near-identical to existing code, or realize right after writing that you just duplicated one; (3) add a value to an enum or constant table that forces matching branches elsewhere; (4) add a boolean or mode parameter that switches behavior; (5) name a new class as an existing class name plus an adjective (Cached-, Async-, Reversed-). The first and second occurrence of the same kind of action need no invocation. Also invoke when the user asks to apply, explain, or review a design pattern.
---

# Force-Driven Design Decision

You are usually invoked mid-edit — the change is half done, and you need to keep writing once the decision is made.
Being invoked does not mean a pattern is needed. Most decisions end in "write it as-is", so that path must be cheap: run the judgment in your head, output one line, and continue.

> **Design patterns resolve conflicting forces, not the mere presence of a force.**
> A single force always has a simpler solution. A problem exists only when two forces hold at once and each one's simplest solution violates the other.

## Judgment Process

### 0. Is there already an abstraction here?

If the change point already has a family of strategies / handlers / states → add one more implementation. Do not add a branch beside it, and skip the rest of this process.

### 1. Context

Three to five lines: in what situation this code is called, and which **concrete** cases exist today.
Use real cases ("PDF export paginates, CSV does not"), not abstract descriptions. Cases are the only basis for identifying forces.

### 2. List the Forces (both directions)

Attach to each force **its simplest solution if it existed alone** — this is the material for the conflict check:

```
Force 1 (variability): export formats handle fields differently
  └ simplest solution alone: a switch inside the exporter

Force 2 (stability): adding a format must not modify the existing exporter
  └ simplest solution alone: hard-code the formats and allow no new ones
```

**Counter-forces must be listed too**, otherwise the list will be biased toward abstraction:

- **Simplicity**: with one more layer of indirection, can the next person still read it?
- **Debugging cost**: will polymorphic dispatch make stack traces harder to follow?
- **YAGNI**: is this variation in the requirements, or am I imagining it?
- **Existing convention**: how does this codebase currently handle it?
- **Performance**: is one more delegation per call acceptable?

### 3. Conflict Check (the gate)

Pair the forces and write this sentence **in both directions**:

> Adopting Force A's simplest solution violates Force B, because `<concrete reason>`;
> conversely, adopting Force B's simplest solution violates Force A, because `<concrete reason>`.

For the example above: a switch satisfies variability, but every new format means editing the exporter, which violates stability;
hard-coded formats satisfy stability, but no new format can get in, which violates variability.

Cannot write both directions → it is one of the false conflicts below.

### 4. Define the Problem

Condense the conflict into **one** question that contains both opposing forces:

> How can `<who>` do `<what>`, without modifying `<which existing code>`?

A one-sided question ("How do we support multiple formats?") means step 3 is unfinished — go back.

## False Conflict → Write It As-Is

- **Only one force**: the other one is imagined.
- **Forces point the same way**: "variability" + "should not know the details" + "follows OCP" all ask for abstraction —
  that is one force phrased three ways, not a conflict.
- **Language features suffice**: polymorphism, default parameters, first-class functions, or a map lookup solve it without a full pattern's role structure.
- **Counter-forces win**: the conflict is real, but costs such as simplicity and YAGNI outweigh the benefit (e.g. only two cases exist).

## Real Conflict → Choose a Pattern

Choose by **the shape of the conflict**, not by keyword association:

| Conflict shape | Pattern | Structure |
|---|---|---|
| Whole algorithm must be swappable, chosen by the caller × caller must not change | **Strategy** | Context holds an interface; each algorithm is its own class |
| Behavior depends on the object's own state, which transitions by itself × Context must not change | **State** | Context delegates to the current state; the state decides the next one |
| Fixed flow with only a few differing steps × flow must not be duplicated | **Template Method** | Parent defines the skeleton; subclasses fill in primitive operations |
| Rules tried in order, stop at the first that handles it × rule set must be configurable externally | **Chain of Responsibility** | Handlers form a chain; unhandled requests pass down |
| Features stack freely, every layer acts, order may vary × class count must stay small | **Decorator** | Wrappers share one interface and delegate layer by layer |
| Two dimensions evolve independently × no m×n classes | **Bridge** | Abstraction holds an implementor interface; each side has its own hierarchy |
| One event triggers many reactions × event source must not know those effects | **Observer** | Subject only holds a list and sends notifications |
| Objects created by name / config × users must not know concrete classes | **Factory** | Name-to-construction mapping lives in one place |
| Caller wants simplicity × subsystem is inherently complex | **Facade** | Single entry point that forwards calls, adding no logic |
| Data is a tree of wholes and parts × caller does not want to distinguish leaves from containers | **Composite** | Leaves and containers share one interface |

### When Variation Axes Multiply

Count the independent variation axes and the values on each, e.g. `export format (3) × data source (4) = 12 combinations`.

To judge whether they multiply: does adding one format force a new class or branch for every data source?
Yes → make each axis its own abstraction and connect them by composition, not cross-inheritance.

## Verification (after applying a pattern)

1. **Add-one test**: how many existing files must change to add one more behavior of the same kind?
   It must be **0 existing files + 1 new file (plus at most one registration line)**. Otherwise → back to the conflict check.
2. The class holding the abstraction no longer checks for concrete types.
3. The project's existing tests pass.

## Decision Record (when the user asks, or the project already has a decision-record directory)

Convention: `docs/design-decisions/<two-digit number>-<topic>-<pattern>.md`. Match the language and granularity of the project's existing docs.
Section order: `Context` / `Observed Forces` (including the two-way conflict sentence) / `Problem` / `Pattern Chosen` / `Resulting Context` / `Why Not`.
Implementation details are not separate decisions; put them under `Implementation Note`.

## Output Format

Reply in the user's language.

**No pattern** — one line:

> No pattern: `<which false conflict>`. `<condition for re-evaluating, e.g. "when a third rule appears">`.

**Pattern applied** — five points:

1. **Conflict** — the two-way sentence.
2. **Problem** — one question.
3. **Pattern** — name + one-line reason.
4. **Why Not** — why not the most obvious if/else + enum (list concretely which branches it would grow into), and why not the closest alternative pattern.
5. **Verification** — the add-one test result + test results.

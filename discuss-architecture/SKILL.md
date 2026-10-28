---
name: discuss-architecture
description: Analyze responsibility boundaries, state ownership, dependency direction, lifecycle, public contracts, and migration options in existing or proposed systems. Use for architecture reviews, refactoring tradeoffs, and reassessing earlier architecture recommendations, including local questions involving these relationships. Not for naming alone, syntax, or generic conceptual explanations.
---

# Discuss Architecture

Evaluate structure against concrete problems and system evidence. Clarify responsibilities and tradeoffs rather than applying architecture patterns without solving an actual problem.

## Establish the problem before judging the structure

Identify the specific problem the user wants to improve and the evidence supporting it.

Do not infer an architecture defect solely from file size, dependency count, nesting, naming, or framework patterns. Identify concrete effects such as change amplification, mixed responsibilities, hidden coupling, uncontrolled mutation, lifecycle conflicts, or unstable contracts.

If the problem is not yet established, clarify or inspect before proposing extraction.

## Inspect the relationships relevant to the boundary

- **Responsibility boundaries:** Inspect the implementation, direct collaborators, and shared reasons to change.
- **State ownership:** Trace initialization, readers, writers, synchronization, and cleanup.
- **Dependency direction:** Inspect calls, public contracts, and reverse dependencies.
- **Lifecycle:** Inspect ordering, asynchronous coordination, cancellation, retries, and recovery.
- **Migration:** Inspect compatibility, external consumers, persisted data, and verification methods.

Do not assign ownership merely because state is displayed in a component, a call chain is long, or many events exist. Consider lifecycle, mutation authority, and consumers together.

## Test candidate boundaries against concrete behavior

When proposing responsibility moves, extraction, or dependency changes, explain:

- Which problem improves.
- Who owns the responsibility now and who would own it afterward.
- Which existing data flows or behaviors need reconnecting after the move.
- Which interfaces, coupling, and coordination costs are introduced.
- How preserved behavior will be verified.

Do not omit important shared state, layout responsibility, asynchronous ordering, or recovery from a sketch and then treat it as a viable solution. Call unverified structures sketches or candidates.

## Compare options and plan migration

Choose criteria relevant to the actual problem, such as ownership clarity, change isolation, lifecycle safety, compatibility, testability, runtime cost, and migration risk.

Do not conclude only that a direction is cleaner, simpler, or easier to maintain. Explain concrete improvements and added costs. Identify unresolved constraints that determine the choice.

A migration plan should at least define:

- Behavior and contracts that must remain stable.
- How responsibilities, interfaces, and dependencies transition.
- An implementation sequence with verifiable steps.
- Important failure scenarios and rollback or recovery methods.

Scale depth to the risk. Local questions can receive concise answers; changes spanning modules or lifecycles need enough evidence to assess feasibility.

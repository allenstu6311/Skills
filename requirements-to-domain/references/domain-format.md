# Domain specification format

## DOMAIN.md

Use numbered, atomic domain statements and stable rule IDs where useful for tracing diagram responsibilities. Define terms consistently, with English model names alongside local-language names when helpful. Explain constraints and observable outcomes, not only screen actions.

Suggested structure, adapted to the actual domain:

1. Purpose and scope: supported outcomes, explicit exclusions, system boundary.
2. Actors and permissions.
3. Domain concepts: identity, business attributes, relationships, ownership.
4. Use cases and operations: actor, prerequisites, changes, outcomes.
5. Lifecycle rules: named states and confirmed allowed transitions.
6. Calculations and policies: conditions, effects, combination rules, examples.
7. Historical data, deletion, restoration, and dependencies.
8. Complete scenarios: primary path and confirmed alternate/failure paths.
9. Explicitly deferred questions and their impact, only as agreed by the user.

Omit irrelevant sections and split large domain areas where appropriate. Keep database tables, framework details, migration notes, and implementation progress out of the business specification. Existing implementation discrepancies can be explained in the conversation without converting them into business rules.

The DHC example is a structural inspiration, not a source of defaults: never import its payment, discount, retention, anonymous access, or deletion policies into a different project. In particular, do not transform “recover within 7 days” into permanent deletion while claiming to merely reformat requirements.

Useful transformation:

“Staff can edit an order” requires clarification about what is edited, when, by whom, and with what effects. Once confirmed, express separate rules for allowed item changes, valid states, recalculation, and preservation of historical information. These rules justify object responsibilities; noun extraction alone does not.


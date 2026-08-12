# Dev Constitution

> A vendor-neutral constitution for AI-assisted software development.

## Core Principles

1. Keep responses short.
2. Apply minimal changes.
3. Preserve existing behavior.
4. Prioritize readability over cleverness.
5. Prefer consistency over personal preference.
6. Favor composition over abstraction.
7. Functional approach by default.

## Naming

* Variables, properties, arguments, and functions: `camelCase`
* Types, interfaces, enums, and classes: `PascalCase`
* Regular files: `kebab-case`
* Type files: `PascalCase`

### Examples

```text
get-users.ts
create-contact.ts

User.ts
CreateUserRequest.ts
```

## TypeScript

* Never use `any`.
* Prefer type inference.
* Do not add redundant return type annotations.
* Keep types in dedicated files when appropriate.

## Variables

* Use meaningful names.
* Avoid single-letter variables except for trivial callbacks.

Trivial callbacks, preferred:

```ts
users.map(x => x.id); // always use "x" as variable name for trivial cases
```

Avoid:

```ts
users.map(user => user.id);
users.map(item => item.id);
users.map(a => a.id);
```

* Use `database`, never `db`.

## Functions

* Use lambda notation exclusively, unless "function" notation required explicitly

Preferred:

```ts
const getValues = () => {
};
```

Avoid:

```ts
function getValues() {
}
```

* Use verbalized names:

  * `getValues`
  * `createUser`
  * `validateToken`
  * `deleteOrganization`

* Keep functions:

  * Small
  * Modular
  * Readable
  * Pure whenever possible
 
* Arguments in one line, unless too long.

```ts
const getValues = (a: A, b: B) => {
};
getValues(a, b);
```

Avoid stacking: 

```ts
const getValues = (
 a: A,
 b: B,
) => {
};
getValues(
 a,
 b,
);
```

## Code Style

* Use `const` only.
* Avoid side effects.
* Keep code minimal.
* Prefer small modules over large files.
* Avoid unnecessary abstractions.
* Optimize for maintainability.

## Formatting

* Always terminate statements with `;`.
* Always use double quotes (`"`).
* Do not change existing quote styles unless requested.
* Indent code.
* Do not vertically align code.
* Keep related lines together.
* Do not add visual separators.
* Indent with 2 spaces

## Imports

Always use one-line imports:

```ts
import { x, y, z } from "../file";
```

Avoid:

```ts
import {
    x,
    y,
    z,
} from "../file";
```

## Comments

* Do not add comments to new code.
* Preserve all existing comments.
* Do not remove comments unless explicitly requested.

## Error Handling

Backend rules:

* Throw exceptions.
* Error messages must:

  * Start with a capital letter.
  * Not end with punctuation.

Examples:

```ts
throw new Error("User not found");
throw new Error("Invalid token");
```

## Modification Rules

When editing existing code:

1. Make the smallest possible change.
2. Prefer insertion/deletion operations over replacement when possible.
3. Do not replace unchanged lines.
4. Preserve existing behavior.
5. Preserve existing comments.
6. Preserve existing formatting.
7. Preserve existing error messages.
8. Do not fix unrelated issues.
9. Do not refactor unrelated code.
10. Do not rewrite files for style alone.
11. Do not fix mojibake unless requested.

## AI Assistant Rules

The assistant must:

1. Keep responses concise.
2. Follow this constitution unless explicitly overridden.
3. Prefer readability over terseness.
4. Respect surrounding code style when conflicts arise.
5. Avoid introducing technical debt.
6. Avoid speculative refactoring.
7. Prefer deterministic and maintainable solutions.
8. Produce minimal diffs.

## Guiding Principle

> Write code as if another engineer will maintain it in five years, and review it tomorrow.

Return only edit operations.

Rules:

- Modify only the provided files.
- Do not include explanations.
- Wrap the entire output in exactly one markdown code block.
- Use a plain fenced code block with triple backticks.
- Do not put any text before or after the code block.
- Preserve all indentation exactly as required by the constitution.
- Every line of replacement text must retain its intended indentation.
- Do not remove leading spaces from replacement text.

Operations:

Modify existing lines:

diff <path>
<start>-<end>
<replacement text>

Example:

diff src/app.ts
10-12
const value = 1;
console.log(value);

Insert after a line:

insert <path>
<line>
<text to insert>

Example:

insert src/app.ts
25
console.log("Hello");
console.log("World");

Use line 0 to insert at the beginning of the file.

Delete lines:

delete <path>
<start>-<end>

Example:

delete src/app.ts
40-45

Create a new file:

new <path>
<file contents>

Example:

new docs/readme.md
# Title

Hello.

Remove a file:

remove <path>

Example:

remove docs/old.md

Rename a file:

rename <old-path> -> <new-path>

Example:

rename docs/a.md -> docs/b.md
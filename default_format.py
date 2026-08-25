from devflow_sdk.draft_pr_plugin import DraftPrPlugin

_CHANGE_TYPES = [
    "New feature",
    "Bug fix",
    "Refactoring (no functional changes)",
    "Documentation update",
    "Infrastructure / CI/CD",
    "Performance improvement",
]


class DefaultPlugin(DraftPrPlugin):
    name = "Default Format"

    def get_questions(self, data: dict) -> list[dict]:
        return []

    def build_prompt(self, data: dict, user_inputs: dict) -> str:
        return (
            "Analyze the following git log and diff summary, then output ONLY a JSON object"
            " with these exact keys:\n"
            '  "description": one or two sentences summarizing what this PR does and why,\n'
            '  "change_type": exactly one of '
            + str(_CHANGE_TYPES)
            + ",\n"
            '  "changes": list of 2-5 concise bullet strings describing specific changes,\n'
            '  "how_to_test": list of 2-5 numbered step strings for reviewers to verify the change,\n'
            '  "related_issues": string with linked issue references or empty string if none.\n\n'
            "Git log:\n"
            + data["git_log"]
            + "\n\nDiff summary:\n"
            + data.get("diff_stat", "")
        )

    def build_body(self, ai_result: dict, user_inputs: dict) -> str:
        change_type = ai_result.get("change_type", "")
        type_checkboxes = "\n".join(
            f"- [{'x' if ct == change_type else ' '}] {ct}" for ct in _CHANGE_TYPES
        )

        changes = ai_result.get("changes", [])
        changes_list = "\n".join(f"- {c}" for c in changes) if changes else "-"

        steps = ai_result.get("how_to_test", [])
        steps_list = "\n".join(f"{i + 1}. {s}" for i, s in enumerate(steps)) if steps else "1."

        related = ai_result.get("related_issues", "").strip()
        jira = user_inputs.get("jira_ticket", "").strip()
        if jira and jira not in related:
            related = f"{jira}\n{related}".strip() if related else jira

        related_section = related if related else "<!-- Link related tickets or issues. Use \"Closes #123\" to auto-close. -->"

        return f"""\
## Description

{ai_result.get("description", "")}

## Type of Change

{type_checkboxes}

## Changes Made

{changes_list}

## How to Test

{steps_list}

## Checklist

- [ ] Code follows the project's style guidelines
- [ ] Self-reviewed the code for obvious errors
- [ ] Added or updated tests where applicable
- [ ] Existing tests pass locally
- [ ] Updated documentation if needed
- [ ] No new warnings or console errors introduced

## Related Issues

{related_section}

## Screenshots

<!-- If applicable, add screenshots or screen recordings. -->
"""

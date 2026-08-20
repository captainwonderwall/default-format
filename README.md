# default-format

A [devflow](https://github.com/captainwonderwall/devflow) plugin for `draft-pr`.

## Install

```bash
bash install.sh
```

## Uninstall

```bash
bash uninstall.sh
```

## Develop

```bash
# Install dev dependencies (or point PYTHONPATH at a local devflow-sdk clone)
pip install devflow-sdk pytest

# Run tests — no AI required
PYTHONPATH=. pytest tests/
```

## Publish a release

1. Fill in `build_prompt` and `build_body` in `default_format.py`.
2. Run tests: `PYTHONPATH=. pytest tests/`.
3. Commit your changes, then run:
   ```bash
   bash scripts/release.sh
   ```
   This bumps the version, tags, and pushes. GitHub Actions creates a release and attaches `default_format.py` as an asset.

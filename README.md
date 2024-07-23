# Get Number of Git Commits

## Introduction
This is designed to be used in GitHub Actions.  It simply gets the number of commits in a given PR.

## Inputs
| Input | Type | Description |
|-------|------|-------------|
| `url` | string | The URL for the PR.  When used in a GH workflow, will typically be `${{ github.event.pull_request.url }}`. |

## Outputs
| Output | Type | Description |
|-------|------|-------------|
| `all_files_changed` | string | String of JSON array listing all files changed in the PR. |
| `added_files` | string | String (JSON array) of all added files in the PR. |
| `copied_files` | string | String (JSON array) of all copied files in the PR. |
| `deleted_files` | string | String (JSON array) of all deleted files in the PR. |
| `modified_files` | string | String (JSON array) of all modified files in the PR. |
| `renamed_files` | string | String (JSON array) of all renamed files in the PR. |
    
## Usage
Coming soon...

## Copyright Notice
Copyright (c) 2024 Oracle and/or its affiliates.
# Azure review checklist linter

This action verifies the correctness of an Azure review checklist (stored in [this repo](https://github.com/Azure/review-checklists) and forks).

## Inputs

## `who-to-greet`

**Required** The name of the person to greet. Default `"World"`.

## Outputs

## `time`

The time we greeted you.

## Example usage

uses: actions/hello-world-docker-action@v2
with:
  who-to-greet: 'Mona the Octocat'
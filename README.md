# Azure review checklist linter

This action verifies the correctness of an Azure review checklist (stored in [this repo](https://github.com/Azure/review-checklists) and forks).

## Inputs

## `language`

**Optional** Language whose lists will be linted. Default `"en"`.

## Outputs

## `number_of_checklists`

Number of checklists that have been linted

## Example usage

uses: erjosito/review-checklists-lint@v1
with:
  language: 'en'
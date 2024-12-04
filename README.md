# helmless-gcp-infrastructure

This repository contains the Terraform code to create the infrastructure for the [helmless](https://helmless.io) GCP project using [Terramate](https://terramate.io).

## Prerequisites

All tools in this project are managed using [asdf](https://asdf-vm.com/). You must install asdf and the required plugins before you can use the tools in this project.

```bash
brew install asdf
asdf plugin add terraform
asdf plugin add terramate
asdf plugin add tflint
asdf plugin add pre-commit
```

Then run the following command to install the required versions of the tools:

```bash
asdf install
```

And finally, install the pre-commit hooks:

```bash
pre-commit install
```

## Project Structure

The project is structured into the following [stacks](https://terramate.io/docs/cli/stacks/):

- `stacks/project-factory`: Contains the base infrastructure and GCP project setup, including the state bucket.
- `stacks/github-federation`: Contains the Github integration setup to allow the pipelines to authenticate with GCP.
- `stacks/e2e-tests`: Contains Cloud Run Services for the e2e tests in [helmless/helmless](https://github.com/helmless/helmless).

## Usage

To plan changes for all stacks, run the following command:

> **NOTE**  
> You must commit all changes before running this command.  
> The command will fail if there are uncommitted changes.  
> To work around this, you can set `export TM_DISABLE_SAFEGUARDS=git`

```bash
terramate script run plan
```

And to apply the changes, run the following command:

```bash
terramate script run deploy
```
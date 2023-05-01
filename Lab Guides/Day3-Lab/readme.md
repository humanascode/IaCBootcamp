# 3-Day Bootcamp - Infrastructure as Code with Terraform on Azure (Day 3 Lab Guide)

## Objective
In this lab, you will create a GitHub Actions workflow to automate the Continuous Integration (CI) and Continuous Deployment (CD) process for your Terraform on Azure project.

## Prerequisites
1. Completed Lab 1 and Lab 2
2. Familiarity with GitHub Actions and YAML syntax

## Lab Overview
1. Create a service principal for 
2. Configure secrets in the GitHub repository
GitHub Actions to authenticate with Azure
3. Create a GitHub Actions workflow file
4. Configure the Terraform CI job
5. Configure the Terraform CD job
6. Test the workflow

## Instructions

### 1. Create a service principal for GitHub Actions to authenticate with Azure

- Open the Azure Cloud Shell
- Run the following command to create a service principal with the Contributor role scoped to the subscription
```powershell
az ad sp create-for-rbac -n "GitHubActions" --role Contributor --scopes /subscriptions/<subscription-id>
```
- Capture the appId, password, tenant, and subscription values from the output of the command for use in the next step

### 2. Configure secrets in the GitHub repository
You will need to create the following secrets in your GitHub repository for the workflow to be able to authenticate with Azure:

1. ARM_CLIENT_ID `(use the appId from the previous step)`
2. ARM_CLIENT_SECRET `(use the password from the previous step)`
3. ARM_TENANT_ID
4. ARM_SUBSCRIPTION_ID
5. RESOURCE_GROUP `(the RG where the storage account for the terraform backend is located)`
6. STORAGE_ACCOUNT `(the name of the storage account for the terraform backend)`
7. CONTAINER_NAME `(the name of the container for the terraform backend)`

To create the secrets:

- Go to your GitHub repository
- Click on the "Settings" tab
- Click on "Secrets" on the left sidebar
- Click on the "New repository secret" button and create each secret with the appropriate value

### 3. Create a GitHub Actions workflow file
- In your GitHub repository, create a new folder called `.github` at the root level if it doesn't already exist
- Inside the `.github` folder, create another folder named `workflows`
- Inside the `workflows` folder, create a new file named `terraform-ci-cd.yml`
- Configure the event that will trigger the workflow to run (push / pull request / etc.)
- Configrue a name for the workflow

### 4. Configure the Terraform CI job

Configure the following steps in the CI job:

1. Checkout the repository to the GitHub Actions runner
2. Install the preferred version of Terraform CLI
3. Initialize the Terraform working directory with the backend configuration
4. Run a Terraform format check
5. Run a Terraform validate check
6. Run a Terraform plan and output the result to a tfplan file
7. Upload the tfplan artifact
> **Note:** You can concatenate the name of the artifcat with the job id to ensure that the artifact is unique for each run of the workflow. for example: `tfplan-${{ github.run_id }}`

### 5. Configure the Terraform CD job
Configure the following steps in the CD job:
> **Note:** Jobs in GitHub Actions run in parallel by default. To ensure that the CD job runs after the CI job, you will need to configure the CD job to run only when the CI job completes successfully. You can do this by adding the `needs` keyword to the CD job and specifying the name of the CI job as a dependency.

1. Checkout the repository to the GitHub Actions runner
2. Install the preferred version of Terraform CLI
3. Download the tfplan artifact from the CI job
4. Initialize the Terraform working directory with the backend configuration
5. Apply the tfplan
> **Remember:** the plan file was downloaded from the CI job, so you will need to specify the path to the plan file in the `terraform apply` command


### 6. Test the workflow
- Commit and push your changes to the repository
- Go to the "Actions" tab in your GitHub repository
- Verify that the workflow runs successfully, and the Terraform plan is executed and applied correctly

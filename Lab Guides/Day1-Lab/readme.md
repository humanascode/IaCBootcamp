# 3-Day Bootcamp - Infrastructure as Code with Terraform on Azure (Day 1 Lab Guide)

## Objective
In this lab, you will learn how to create a new project and repository in GitHub, clone it to your local machine, set up a gitignore file for working with Terraform, and create a simple Terraform configuration to deploy Azure resources. At the end of this lab, you will have a better understanding of how to use Terraform to deploy Azure resources and combining it with GitHub to version control your Terraform configuration.

## Prerequisites
Before starting this lab, ensure you have the following prerequisites in place:
1. [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
2. [Visual Studio Code](https://code.visualstudio.com/download)
3. [HashiCorp Terraform extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform)
4. Owner or Contributor rights on the Azure subscription you are working on
5. A GitHub account

## Lab Overview
1. Authenticate with Azure with the Azure CLI
2. Create a new GitHub project and repository
3. Clone the repository to your local machine
4. Set up a gitignore file for working with Terraform
5. Create Terraform configuration files to deploy Azure resources
6. Plan and apply your Terraform configuration

## Instructions

### 1. Authenticate with Azure
- Open your terminal or command prompt
- Run the command `az login` to authenticate with your Azure account
- Follow the instructions to sign in with your account
- After signing in, run `az account show` to ensure you are working on the correct subscription

### 2. Create a new GitHub project and repository
- Open your web browser and visit GitHub
If you haven't already, sign in to your GitHub account or create a new account
- Once you are signed in, click on the '+' icon in the upper-right corner of the page, and then click on 'New repository'
- On the 'Create a new repository' page, fill in the following information:
   - Repository name: Choose a descriptive name for your repository
   - Description (optional): Provide a brief description of your project
   - Repository visibility: Choose either 'Public' or 'Private' based on your preference
   - Initialize this repository with: You can leave this unchecked, as you will be adding Terraform files later
- Click on the 'Create repository' button to create your new repository
- On the next page, you will see the URL of your newly created repository. Copy this URL to your clipboard, as you will need it to clone the repository to your local machine later

### 3. Clone the repository to your local machine
- Open your terminal or command prompt
- Navigate to the directory where you want to store your repository
- Run `git clone <repository-url>` to clone the repository to your local machine
- Change to the newly created directory by running `cd <repository-name>`

### 4. Set up a gitignore file for working with Terraform

> **Info:** In the next step you will create a new file called `.gitignore`. This file tells Git which files to ignore when committing changes to the repository. For Terraform, we want to ignore the `.terraform` directory, as well as any files with the extensions `.tfstate`, `.tfstate.backup`, `.tfvars`, and `.tfplan` as these files contain sensitive information and are not meant to be shared in git repositories.

- In the repository, create a new file called `.gitignore` 
- Add the following lines to the `.gitignore` file:
```
**/.terraform/*
*.tfstate
*.tfstate.backup
*.tfvars
*.tfplan
```

- Save and commit the changes to your repository

> **Remember:** You can commit your changes into the git repository by running the following commands: `git add .` and `git commit -m "a descriptive commit message"` to push changes to the remote repository, run `git push origin <branch name>`

### 5. Create Terraform configuration files to deploy Azure resources
- Create a new file called `providers.tf`
- Add the following content to `providers.tf`:

```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}
```

- Save and commit the changes to your repository

> **Tip:** Configure auto-saving in Visual Studio Code by going to File > and checking `Auto Save` This will automatically save your changes and prevent frustration when you forget to save your changes before running Terraform ot Git commands.

### 6. Create Terraform configuration files to deploy Azure resources
- Create a new file called `main.tf`
- Write a Terraform configuration to deploy the following Azure resources:
  - Resource group
  - Virtual network
  - Subnet
  - Network interface card
  - Virtual machine
- You can use the following resources to help you:

   - [Resource Group (azurerm_resource_group)](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)
   - [Virtual Network (vnet) (azurerm_virtual_network)](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network)
   - [Subnet (azurerm_subnet)](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet)
   - [Network Interface Card (azurerm_network_interface)](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface)
  - Virtual Machine (on of the following, depending on your preference):
    - [Windows (azurerm_windows_virtual_machine)](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine)
    - [Linux (azurerm_linux_virtual_machine)](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine)

- Dont forget to use variables as much as possible to make your Terraform configuration generic

- Save and commit the changes to your repository

### 7. Plan and apply your Terraform configuration
- Open your terminal or command prompt
- Navigate to the directory where your Terraform configuration files are stored
- Run the command `terraform init` to initialize your Terraform working directory
- Run the command `terraform plan -out <tfplan file name>` to generate an 
execution plan
> **Note:** If you want to supply variable values using the command line, you can use the `-var` flag. For example: `terraform plan -var="location=westeurope" -out <tfplan file name>`
- Review the plan and confirm the resources to be created
- Run the command `terraform apply tfplan file name` to apply the configuration and create the resources
- Confirm the creation of the resources in the Azure portal
- When done, run the command `terraform destroy` to destroy the resources
> **Note:** When running `terraform destroy`, you will need to provide the values for the variables you defined in your Terraform configuration (same as you did with `terraform plan`). You can do this by using the `-var` flag. For example: `terraform destroy -var="location=westeurope"`


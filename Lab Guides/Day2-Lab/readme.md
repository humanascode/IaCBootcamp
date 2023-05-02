# 3-Day Bootcamp - Infrastructure as Code with Terraform on Azure (Day 2 Lab Guide)

## Objective
In this lab, you will refactor the Terraform configuration from Lab 1 to create a module for networking resources and use loops to deploy a dynamic number of virtual machines.

## Prerequisites
1. Completed Lab 1

## Lab Overview
1. Refactor the Terraform configuration to use a module for networking resources:
   - you will create the module itself
   - the module will be used to create a VNet and a subnet and will be called from the main configuration. 
   - It will receive variables needed to create the VNet and subnet and return the output needed to create the VMs.
2. Create a dynamic number of VMs using Terraform loops:
   - Use either the "count" loop or the "foreach" loop to create a dynamic number of VMs.
3. (Bonus Task) Create a module for Network Security Group (NSG) and subnet association:
   - Create a module for creating an NSG and associating it with a subnet.
   - The module will receive the subnet ID and a list of NSG rules represented as a list of objects as input variables.


## Instructions

### 1. Refactor the Terraform configuration
- Move the networking resources (VNet and subnet) from your main.tf file to a separate module
  - Create a new folder named "modules" in the root of your repository
  - Inside the "modules" folder, create a folder named "networking"
  - In the "networking" folder, create a new file named "main.tf"
  - Move the VNet and subnet resource blocks from your main Terraform configuration to the "main.tf" file inside the "networking" folder
- Define input variables for the required values in the "networking" module, such as the VNet name, address space, subnet name, and subnet address prefix
- In your root Terraform configuration, replace the VNet and subnet resource blocks with a module block that references the "networking" module and provides values for the required input variables
- Remember to define output values in the "networking" module 
- After creating the module, you need to run `terraform init` in the root of your repository to initialize the module


> **Important**: modules called from the root module are unaware of the root module's objects (resources, variables, locals etc.) and vice versa. This means that any information that needs to flow between the root module and the child module must be passed explicitly. Also, if the child module requires information from the user, the variable for this information must be defined twice: once in the root module and once in the child module. Same goes for outputs: if the user needs to get an output from a resource that was created in the child module, the output must be defined in the child module and then again in the root module.

### 2. Create a dynamic number of VMs using Terraform loops
- Choose to use either the ["count" loop](https://www.terraform.io/docs/language/meta-arguments/count.html) or the ["foreach" loop](https://www.terraform.io/docs/language/meta-arguments/for_each.html)
- If using the "count" loop, modify the VM resource block in your main Terraform configuration to use the "count" meta-argument, and provide a variable for the number of VMs required
- If using the "foreach" loop, create a list or map containing the VM details (e.g., names, sizes) and modify the VM resource block to use the "for_each" meta-argument, and provide the list or map as the value
>**Note**: You can use [Demo7](./Resources/Terraform%20Demos/Demo7) for an example using the count loop


### 3. Test your changes
- Run `terraform init` to initialize your Terraform working directory
- Run `terraform plan` to generate an execution plan and ensure that your changes are working as expected
- Apply your configuration with `terraform apply` and verify the correct resources are created in the Azure portal
- When done, run the command `terraform destroy` to clean up the resources (unless you plan to do the bonus task)

### 4. (Bonus Task 🤗) Create a module for Network Security Group (NSG) and subnet association
- Create a new folder named "nsg" inside the "modules" folder
- In the "nsg" folder, create a new file named "main.tf"
- Write the Terraform configuration for creating a Network Security Group and associating it with a subnet
- Define input variables for the required values in the "nsg" module, such as the subnet ID and a list of NSG rules represented as a list of objects
> **Note**: NSG rules are represented as a list of objects, where each object has the following attributes: name, priority, direction, access, protocol, source_port_range, destination_port_range, source_address_prefix, destination_address_prefix. For example: 
>```h
>  nsg_rules = [
>    {
>      name                       = "AllowSSH"
>      priority                   = 100
>      direction                  = "Inbound"
>      access                     = "Allow"
>      protocol                   = "Tcp"
>      source_port_range          = "*"
>      destination_port_range     = "22"
>      source_address_prefix      = "*"
>      destination_address_prefix = "*"
>    }
>  ]
>```
> The variable that recieves the list of NSG rules should be defined as follows:
>```hcl
>variable "nsg_rules" {
>  type = list(object({
>    name                       = string
>    priority                   = string
>    direction                  = string
>    access                     = string
>    protocol                   = string
>    source_port_range          = string
>    destination_port_range     = string
>    source_address_prefix      = string
>    destination_address_prefix = string
>  }))
>}
>```

- In your root Terraform configuration, add a module block that references the "nsg" module and provides values for the required input variables
- Remember to run `terraform init` in the root of your repository to initialize the module
- Run `terraform destroy` to clean up the resources

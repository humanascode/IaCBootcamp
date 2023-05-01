## Demo 3
1. In the Demo1 folder, run `terraform destroy` to delete the resources created in the previous demo.
2. Delete the following files:
    - `terraform.tfstate`
    - `terraform.tfstate.backup`
    - `.terraform.lock.hcl`
    -  Any plan files
    - The `.terraform` folder
3. Run `terraform init` to initialize the directory.
4. Take a look inside the `.terraform` folder. What do you see?
5. Take a look inside the `.terraform.lock.hcl` file. What do you see? what version of azurerm was installed? why?
6. Change the version of `azurerm` in the `providers.tf` file to `~> 3`. What happens when you run `terraform init`? did the installed version of azurerm change? why not?
7. Run `terraform init -upgrade` what happened?
### Contributing to Terraform Code

When contributing to the Terraform code in this project, you can validate and test your changes locally using the steps below. However, due to the private networking setup of this project, running `terraform plan` or `terraform apply` locally is not feasible. These commands need to be executed by the GitHub Actions Runner, which has been configured to run within the necessary network environment. This setup ensures secure and controlled access to the private resources.

##### Steps to Contribute

1. **Initialize Terraform (Without Backend):**
   To initialize the Terraform configuration locally without configuring the backend, use the following command:
   ```bash
   terraform -chdir=./terraform/deployment init -backend=false -upgrade
   ```
   This ensures that you can work with the Terraform configuration without connecting to the remote state backend.

2. **Validate Terraform Code:**
   Validate the syntax and structure of your Terraform configuration to ensure it adheres to Terraform standards:
   ```bash
   terraform -chdir=./terraform/deployment validate
   ```

3. **Testing and Execution:**
   Since `terraform plan` and `terraform apply` cannot be executed locally due to private networking, you must rely on the automated GitHub Actions workflow for these operations. This workflow has been set up to:
   - Execute Terraform commands within a secure environment.
   - Apply changes safely to the private infrastructure.

4. **Submitting Changes:**
   - After validating your changes, commit and push them to a feature branch.
   - Open a pull request for review. The GitHub Actions workflow will automatically run `terraform plan` to show the expected changes.

5. **Review the GitHub Actions Output:**
   Once the workflow completes, review the `terraform plan` output in the Actions logs to ensure the changes match your expectations.

By following this process, you can contribute to the Terraform codebase while adhering to the security and networking constraints of the project.

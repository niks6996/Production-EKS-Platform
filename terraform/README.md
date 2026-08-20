# Terraform

- `bootstrap/` will create remote-state resources separately from the platform state.
- `environments/dev/` will compose reusable modules for the development environment.
- `modules/` will hold reusable AWS infrastructure modules.

Do not commit Terraform state files, plan files, credentials or generated provider files.

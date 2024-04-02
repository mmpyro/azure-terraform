plan:
	terraform plan

apply:
	terraform apply --auto-approve

destroy:
	terraform destroy --auto-approve

cleanup:
	ls | grep 'backup$$' | xargs rm -v
	rm terraform.tfstate || true

output:
	terraform output

generate:
	terraform plan -generate-config-out=generated.tf

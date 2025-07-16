package policies.tf_aws_region_restriction

input_type := "tf"
resource_type := "provider"

default deny = false

deny[msg] {
  input.resource_type == resource_type
  input_type == "tf"
  input.name == "aws"
  region := input.config.region
  region != "ca-central-1"

  msg := sprintf("Only 'ca-central-1' is allowed. Found region: '%s'.", [region])
}

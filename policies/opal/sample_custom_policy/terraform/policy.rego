package policies.tf_sample_custom_policy

input_type := "tf"

resource_type := "aws_s3_bucket"

default allow = false

# Add Rego Policy # 
allow {
input.logging[_].target_bucket = "example"
}

# terraform-aws-lambda-auto-package

[![Github Actions](https://github.com/nozaq/terraform-aws-lambda-auto-package/actions/workflows/main.yml/badge.svg)](https://github.com/nozaq/terraform-aws-lambda-auto-package/actions/workflows/main.yml)
[![Releases](https://img.shields.io/github/v/release/nozaq/terraform-aws-lambda-auto-package)](https://github.com/nozaq/terraform-aws-lambda-auto-package/releases/tag/latest)

[Terraform Module Registry](https://registry.terraform.io/modules/nozaq/lambda-auto-package/aws)

A terraform module to define a lambda function which source files are automatically built and packaged for lambda deployment.

## Features

Create a lambda function with the following supports.

- Automatically archive the specified source directory into one zip file for Lambda deployment.
- Invoke a build command before making an archive if specified. This allows installing additional dependencies, for example from requirements.txt, package.json etc.
- Create an IAM role to publish lambda execution logs to CloudWatch Logs.

## Usage

```hcl
module "lambda" {
  source  = "nozaq/lambda-auto-package/aws"

  source_dir  = "${path.module}/source"
  output_path = "${path.module}/source.zip"

  build_triggers = {
    requirements = "${base64sha256(file("${path.module}/source/requirements.txt"))}"
    execute      = "${base64sha256(file("${path.module}/pip.sh"))}"
  }
  build_command = "${path.module}/pip.sh ${path.module}/source"

  iam_role_name_prefix = "example-lambda-role"

  function_name = "example-lambda"
  handler       = "main.handler"
  runtime       = "python3.7"

  environment = {
    variables = {
      EXAMPLE_VAR = "foobar"
    }
  }
}
```

Check [examples](./examples) for non-python examples.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | >= 2.2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.50.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | >= 2.2.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.50.0 |
| <a name="provider_null"></a> [null](#provider\_null) | >= 3.1.0 |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | A unique name for your Lambda Function. | `string` | yes |
| <a name="input_handler"></a> [handler](#input\_handler) | The function entrypoint in your code. | `string` | yes |
| <a name="input_output_path"></a> [output\_path](#input\_output\_path) | A path to which the source directory is archived before uploading to AWS. | `string` | yes |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | The identifier of the function's runtime. | `string` | yes |
| <a name="input_source_dir"></a> [source\_dir](#input\_source\_dir) | A path to the directory which contains source files. | `string` | yes |
| <a name="input_allowed_services"></a> [allowed\_services](#input\_allowed\_services) | A list of AWS Services that are allowed to access this lambda. | `list(string)` | no |
| <a name="input_build_command"></a> [build\_command](#input\_build\_command) | This is the build command to execute. It can be provided as a relative path to the current working directory or as an absolute path. It is evaluated in a shell, and can use environment variables or Terraform variables. | `string` | no |
| <a name="input_build_triggers"></a> [build\_triggers](#input\_build\_triggers) | A map of values which should cause the build command to re-run. Values are meant to be interpolated references to variables or attributes of other resources. | `map(string)` | no |
| <a name="input_dead_letter_config"></a> [dead\_letter\_config](#input\_dead\_letter\_config) | Nested block to configure the function's dead letter queue. | <pre>object({<br>    target_arn = string<br>  })</pre> | no |
| <a name="input_description"></a> [description](#input\_description) | Description of what your Lambda Function does. | `string` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | A map that defines environment variables for the Lambda function. | <pre>object({<br>    variables = map(string)<br>  })</pre> | no |
| <a name="input_exclude_files"></a> [exclude\_files](#input\_exclude\_files) | A list of directories or folders to ignore, e.g.<br>exclude\_files = ["test", "src/**/*.ts"] | `list(string)` | no |
| <a name="input_iam_role_name_prefix"></a> [iam\_role\_name\_prefix](#input\_iam\_role\_name\_prefix) | The prefix string for the name of IAM role for the lambda function. | `string` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN of the KMS Key to use when encrypting log data. | `string` | no |
| <a name="input_lambda_kms_key_arn"></a> [lambda\_kms\_key\_arn](#input\_lambda\_kms\_key\_arn) | The ARN of the KMS Key to use when encrypting environment variables. Ignored unless `environment` is specified. | `string` | no |
| <a name="input_layers"></a> [layers](#input\_layers) | List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function. | `list(string)` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | Amount of memory in MB your Lambda Function can use at runtime. | `number` | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | ARN of the policy that is used to set the permissions boundary for the role. | `string` | no |
| <a name="input_policy_arns"></a> [policy\_arns](#input\_policy\_arns) | A list of IAM policy ARNs attached to the lambda function. | `list(string)` | no |
| <a name="input_publish"></a> [publish](#input\_publish) | Whether to publish creation/change as new Lambda Function Version. | `bool` | no |
| <a name="input_reserved_concurrent_executions"></a> [reserved\_concurrent\_executions](#input\_reserved\_concurrent\_executions) | The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations. | `number` | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | Specifies the number of days you want to retain log events in the specified log group. | `number` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to resources. | `map(string)` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | The maximum number of seconds the lambda function to run until timeout. | `number` | no |
| <a name="input_tracing_config"></a> [tracing\_config](#input\_tracing\_config) | Can be either PassThrough or Active. If PassThrough, Lambda will only trace the request from an upstream service if it contains a tracing header with "sampled=1". If Active, Lambda will respect any tracing header it receives from an upstream service. If no tracing header is received, Lambda will call X-Ray for a tracing decision. | <pre>object({<br>    mode = string<br>  })</pre> | no |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | Provide this to allow your function to access your VPC. | <pre>object({<br>    security_group_ids = list(string)<br>    subnet_ids         = list(string)<br>  })</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_role"></a> [iam\_role](#output\_iam\_role) | The IAM Role which the lambda function is attached. |
| <a name="output_lambda_function"></a> [lambda\_function](#output\_lambda\_function) | The lambda function. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

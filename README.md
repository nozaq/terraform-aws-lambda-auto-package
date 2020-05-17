# terraform-aws-lambda-auto-package

[![Github Actions](https://github.com/nozaq/terraform-aws-lambda-auto-package/workflows/Terraform/badge.svg)](https://github.com/nozaq/terraform-aws-lambda-auto-package/actions?workflow=Terraform)

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

No requirements.

## Providers

| Name    | Version |
| ------- | ------- |
| archive | n/a     |
| aws     | n/a     |
| null    | n/a     |

## Inputs

| Name                             | Description                                                                                                                                                                                                                                                                                                                                 | Type                                                       | Default                                       | Required |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------- | --------------------------------------------- | :------: |
| allowed\_services                | A list of AWS Services that are allowed to access this lambda.                                                                                                                                                                                                                                                                              | `list(string)`                                             | <pre>[<br>  "lambda.amazonaws.com"<br>]</pre> |    no    |
| build\_command                   | This is the build command to execute. It can be provided as a relative path to the current working directory or as an absolute path. It is evaluated in a shell, and can use environment variables or Terraform variables.                                                                                                                  | `string`                                                   | `""`                                          |    no    |
| build\_triggers                  | A map of values which should cause the build command to re-run. Values are meant to be interpolated references to variables or attributes of other resources.                                                                                                                                                                               | `list`                                                     | `[]`                                          |    no    |
| dead\_letter\_config             | Nested block to configure the function's dead letter queue.                                                                                                                                                                                                                                                                                 | <pre>object({<br>    target_arn = string<br>  })</pre>     | `null`                                        |    no    |
| description                      | Description of what your Lambda Function does.                                                                                                                                                                                                                                                                                              | `string`                                                   | `""`                                          |    no    |
| environment                      | A map that defines environment variables for the Lambda function.                                                                                                                                                                                                                                                                           | <pre>object({<br>    variables = map(string)<br>  })</pre> | `null`                                        |    no    |
| exclude\_files                   | A list of directories or folders to ignore, e.g.<br>exclude\_files = ["test", "src/\*\*/\*.ts"]                                                                                                                                                                                                                                             | `list(string)`                                             | `[]`                                          |    no    |
| function\_name                   | A unique name for your Lambda Function.                                                                                                                                                                                                                                                                                                     | `string`                                                   | n/a                                           |   yes    |
| handler                          | The function entrypoint in your code.                                                                                                                                                                                                                                                                                                       | `string`                                                   | n/a                                           |   yes    |
| iam\_role\_name\_prefix          | The prefix string for the name of IAM role for the lambda function.                                                                                                                                                                                                                                                                         | `string`                                                   | `""`                                          |    no    |
| kms\_key\_arn                    | The ARN for the KMS encryption key.                                                                                                                                                                                                                                                                                                         | `string`                                                   | `null`                                        |    no    |
| kms\_key\_id                     | The ARN of the KMS Key to use when encrypting log data.                                                                                                                                                                                                                                                                                     | `string`                                                   | `null`                                        |    no    |
| layers                           | List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function.                                                                                                                                                                                                                                                         | `list(string)`                                             | `[]`                                          |    no    |
| memory\_size                     | Amount of memory in MB your Lambda Function can use at runtime.                                                                                                                                                                                                                                                                             | `number`                                                   | `128`                                         |    no    |
| output\_path                     | A path to which the source directory is archived before uploading to AWS.                                                                                                                                                                                                                                                                   | `string`                                                   | n/a                                           |   yes    |
| policy\_arns                     | A list of IAM policy ARNs attached to the lambda function.                                                                                                                                                                                                                                                                                  | `list(string)`                                             | `[]`                                          |    no    |
| publish                          | Whether to publish creation/change as new Lambda Function Version.                                                                                                                                                                                                                                                                          | `string`                                                   | `false`                                       |    no    |
| reserved\_concurrent\_executions | The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations.                                                                                                                                                                        | `string`                                                   | `-1`                                          |    no    |
| retention\_in\_days              | Specifies the number of days you want to retain log events in the specified log group.                                                                                                                                                                                                                                                      | `number`                                                   | `null`                                        |    no    |
| runtime                          | The identifier of the function's runtime.                                                                                                                                                                                                                                                                                                   | `string`                                                   | n/a                                           |   yes    |
| source\_dir                      | A path to the directory which contains source files.                                                                                                                                                                                                                                                                                        | `string`                                                   | n/a                                           |   yes    |
| tags                             | A mapping of tags to assign to resources.                                                                                                                                                                                                                                                                                                   | `map`                                                      | <pre>{<br>  "Terraform": "true"<br>}</pre>    |    no    |
| timeout                          | The maximum number of seconds the lambda function to run until timeout.                                                                                                                                                                                                                                                                     | `number`                                                   | `3`                                           |    no    |
| tracing\_config                  | Can be either PassThrough or Active. If PassThrough, Lambda will only trace the request from an upstream service if it contains a tracing header with "sampled=1". If Active, Lambda will respect any tracing header it receives from an upstream service. If no tracing header is received, Lambda will call X-Ray for a tracing decision. | <pre>object({<br>    mode = string<br>  })</pre>           | `null`                                        |    no    |
| vpc\_config                      | Provide this to allow your function to access your VPC.                                                                                                                                                                                                                                                                                     | `any`                                                      | `null`                                        |    no    |

## Outputs

| Name             | Description                                         |
| ---------------- | --------------------------------------------------- |
| iam\_role        | The IAM Role which the lambda function is attached. |
| lambda\_function | The lambda function.                                |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

#---------------------------------------------------------------------------------------------------
# General
#---------------------------------------------------------------------------------------------------

variable "tags" {
  description = "A mapping of tags to assign to resources."
  type        = map(string)
  default = {
    Terraform = "true"
  }
}

#---------------------------------------------------------------------------------------------------
# Build arguments
#---------------------------------------------------------------------------------------------------

variable "build_command" {
  description = "This is the build command to execute. It can be provided as a relative path to the current working directory or as an absolute path. It is evaluated in a shell, and can use environment variables or Terraform variables."
  type        = string
  default     = ""
}

variable "build_triggers" {
  description = "A map of values which should cause the build command to re-run. Values are meant to be interpolated references to variables or attributes of other resources."
  type        = map(string)
  default     = {}
}

variable "source_dir" {
  description = "A path to the directory which contains source files to be archived into a deployment package. If set to `null`, then no archive file is created."
  type        = string
  default     = null
}

variable "output_path" {
  description = "A path to the deployment archive which will be uploaded to AWS. If `source_dir` is not `null`, then a file is created at `output_path` containing the archived contents of `source_dir`."
  type        = string
  default     = null
}

variable "s3_bucket" {
  description = "An existing S3 bucket, containing the function's deployment package. If `output_path` is also specified, the archive will be uploaded here."
  type        = string
  default     = null
}

variable "s3_key" {
  description = "S3 key of an object containing the function's deployment package. If `output_path` is also specified, the archive will be uploaded here."
  type        = string
  default     = null
}

variable "s3_object_version" {
  description = "S3 object version containing the function's deployment package."
  type        = string
  default     = null
}

variable "exclude_files" {
  description = <<DESC
A list of source directories or folders to ignore when creating the archive, e.g.
exclude_files = ["test", "src/**/*.ts"]
DESC
  type        = list(string)
  default     = []
}

#---------------------------------------------------------------------------------------------------
# IAM Role arguments
#---------------------------------------------------------------------------------------------------

variable "iam_role_name_prefix" {
  description = "The prefix string for the name of IAM role for the lambda function."
  type        = string
  default     = ""
}

variable "policy_arns" {
  description = "A list of IAM policy ARNs attached to the lambda function."
  type        = list(string)
  default     = []
}

variable "permissions_boundary" {
  description = "ARN of the policy that is used to set the permissions boundary for the role."
  type        = string
  default     = null
}

#---------------------------------------------------------------------------------------------------
# CloudWatch Log Group arguments
#---------------------------------------------------------------------------------------------------

variable "retention_in_days" {
  description = "Specifies the number of days you want to retain log events in the specified log group."
  type        = number
  default     = null
}

variable "kms_key_id" {
  description = "The ARN of the KMS Key to use when encrypting log data."
  type        = string
  default     = null
}

#---------------------------------------------------------------------------------------------------
# Lambda arguments
#---------------------------------------------------------------------------------------------------

variable "function_name" {
  description = "A unique name for your Lambda Function."
  type        = string
}

variable "runtime" {
  type        = string
  description = "The identifier of the function's runtime."
}

variable "handler" {
  type        = string
  description = "The function entrypoint in your code."
}

variable "memory_size" {
  type        = number
  description = "Amount of memory in MB your Lambda Function can use at runtime."
  default     = 128
}

variable "timeout" {
  type        = number
  description = "The maximum number of seconds the lambda function to run until timeout."
  default     = 3
}

variable "environment" {
  description = "A map that defines environment variables for the Lambda function."
  type = object({
    variables = map(string)
  })
  default = null
}

variable "dead_letter_config" {
  description = "Nested block to configure the function's dead letter queue."
  type = object({
    target_arn = string
  })
  default = null
}

variable "description" {
  description = "Description of what your Lambda Function does."
  type        = string
  default     = ""
}

variable "layers" {
  description = "List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function."
  type        = list(string)
  default     = []
}

variable "reserved_concurrent_executions" {
  description = "The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations."
  type        = number
  default     = -1
}

variable "publish" {
  description = "Whether to publish creation/change as new Lambda Function Version."
  type        = bool
  default     = false
}

variable "tracing_config" {
  description = "Can be either PassThrough or Active. If PassThrough, Lambda will only trace the request from an upstream service if it contains a tracing header with \"sampled=1\". If Active, Lambda will respect any tracing header it receives from an upstream service. If no tracing header is received, Lambda will call X-Ray for a tracing decision."
  type = object({
    mode = string
  })
  default = null
}

variable "vpc_config" {
  description = "Provide this to allow your function to access your VPC."
  type = object({
    security_group_ids = list(string)
    subnet_ids         = list(string)
  })

  default = null
}

variable "allowed_services" {
  description = "A list of AWS Services that are allowed to access this lambda."
  type        = list(string)
  default     = ["lambda.amazonaws.com"]
}

variable "lambda_kms_key_arn" {
  description = "The ARN of the KMS Key to use when encrypting environment variables. Ignored unless `environment` is specified."
  type        = string
  default     = null
}

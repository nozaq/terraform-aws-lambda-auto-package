provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

module "lambda" {
  source = "../../"

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

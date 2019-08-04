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
    requirements = "${base64sha256(file("${path.module}/source/package-lock.json"))}"
    execute      = "${base64sha256(file("${path.module}/npm.sh"))}"
  }
  build_command = "${path.module}/npm.sh ${path.module}/source"

  iam_role_name_prefix = "example-lambda-role"

  function_name = "example-lambda"
  handler       = "index.handler"
  runtime       = "nodejs10.x"

  environment = {
    variables = {
      EXAMPLE_VAR = "foobar"
    }
  }
}

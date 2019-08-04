output "lambda_function" {
  description = "The lambda function."
  value       = aws_lambda_function.this
}

output "iam_role" {
  description = "The IAM Role which the lambda function is attached."
  value       = aws_iam_role.this
}

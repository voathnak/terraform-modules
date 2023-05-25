output "function" {
  description = "function object"

  value = {
    function_name = aws_lambda_function.this_lambda_function.function_name
    invoke_arn    = aws_lambda_function.this_lambda_function.invoke_arn
  }
}

output "function_name" {
  description = "function_name"

  value = aws_lambda_function.this_lambda_function.function_name
}


output "arn" {
  description = "hello-world-function-arn"

  value = aws_lambda_function.this_lambda_function.arn
}

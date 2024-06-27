data "archive_file" "python_src" {
  type        = "zip"
  source_dir  = "${path.module}/../../../src/"
  output_path = "${path.module}/../../../sample-lambda.zip"
}
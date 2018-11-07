output "remote-state" {
  value = "${aws_s3_bucket.remote-state.arn}"
  description = "ARN of the bucket"
}

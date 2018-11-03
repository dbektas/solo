output "remote-state" {
  value = "${aws_s3_bucket.remote-state.arn}"
}

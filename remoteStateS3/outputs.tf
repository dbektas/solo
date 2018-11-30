output "bucket-name" {
  value = "${aws_s3_bucket.remote-state.id}"
  description = "Name of the bucket"
}

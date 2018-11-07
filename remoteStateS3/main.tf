## bucket for holding tf state
resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket" "remote-state" {
  depends_on = ["aws_kms_key.mykey"]
  bucket = "tfstate-${data.aws_caller_identity.current.account_id}"
  region = "${var.region == "" ? data.aws_region.current.name : var.region}"
  acl    = "private"

  versioning {
    enabled = "${var.versioning}"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${aws_kms_key.mykey.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags {
    Terraform = "true"
    Environment = "dev"
  }
}

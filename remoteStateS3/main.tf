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
    enabled = true
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

data "aws_iam_policy_document" "s3-full-access" {
  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:ListBucketMultipartUploads",
    ]

    principals {
      type        = "AWS"
      identifiers = ["${compact(var.principals)}"]
    }

    resources = ["arn:${data.aws_partition.current.partition}:s3:::${aws_s3_bucket.remote-state.id}"]
  }

  statement {
    effect = "Allow"

    # find an authoritative list of valid Actions for a AWS bucket policy,
    # I haven't been able to locate one, and the two commented out are invalid
    actions = [
      #     "s3:ListObjects",
      "s3:PutObject",

      "s3:GetObject",
      "s3:DeleteObject",

      #     "s3:CreateMultipartUpload",
      "s3:ListMultipartUploadParts",

      "s3:AbortMultipartUpload",
    ]

    principals {
      type        = "AWS"
      identifiers = ["${compact(var.principals)}"]
    }

    resources = ["arn:${data.aws_partition.current.partition}:s3:::${aws_s3_bucket.remote-state.id}/*"]
  }
}

resource "aws_s3_bucket_policy" "s3-full-access" {
  bucket = "${aws_s3_bucket.remote-state.id}"
  policy = "${data.aws_iam_policy_document.s3-full-access.json}"
}

data "aws_iam_policy_document" "bucket-full-access" {
  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:ListBucketMultipartUploads",
    ]

    resources = ["arn:${data.aws_partition.current.partition}:s3:::${aws_s3_bucket.remote-state.id}"]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:ListMultipartUploadParts",
      "s3:AbortMultipartUpload",
    ]

    resources = ["arn:${data.aws_partition.current.partition}:s3:::${aws_s3_bucket.remote-state.id}/*"]
  }
}

resource "aws_iam_policy" "bucket-full-access" {
  name   = "s3-remote-state-full-access"
  policy = "${data.aws_iam_policy_document.bucket-full-access.json}"
}

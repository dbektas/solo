variable "principals" {
  default     = []
  description = "list of user/role ARNs to get full access to the bucket"
}

variable "versioning" {
  default     = "true"
  description = "enables versioning for objects in the S3 bucket"
}

variable "region" {
  default     = ""
  description = "Region where the S3 bucket will be created"
  type        = "string"
}

variable "instance_type" {
    type = "string"
    description = "Instance type to make the Bastion host from"
}

variable "max_size" {
    type = "string"
    description = "Maximum number of bastion instances that can be run simultaneously"
}

variable "min_size" {
    type = "string"
    description = "Minimum number of bastion instances that can be run simultaneously"
}

variable "cooldown" {
    type = "string"
    description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start."
}

variable "health_check_grace_period" {
    type = "string"
    description = "Time, in seconds, after instance comes into service before checking health."
}

variable "desired_capacity" {
    type = "string"
    description = "The number of bastion instances that should be running in the group."
}

variable "scale_up_min_size" {
    type = "string"
    description = "The minimum size for the Auto Scaling group. Default 0. Set to -1 if you don't want to change the minimum size at the scheduled time."
}

variable "scale_up_max_size" {
    type = "string"
    description = "The maximum size for the Auto Scaling group. Default 0. Set to -1 if you don't want to change the maximum size at the scheduled time."
}

variable "scale_up_desired_capacity" {
    type = "string"
    description = "The number of EC2 instances that should be running in the group. Default 0. Set to -1 if you don't want to change the desired capacity at the scheduled time."
}

variable "scale_down_desired_capacity" {
    type = "string"
    description = "The number of bastion instances that should be running when scaling down."
}

variable "scale_down_min_size" {
    type = "string"
    description = "Minimum number of bastion instances that can be running when scaling down"
}

variable "scale_down_max_size" {
  type = "string"
  description = "Maximum number of bastion instances that can be running when scaling down"
}

variable "scale_up_cron" {
    type = "string"
    description = "In UTC, when to scale up the bastion servers"
}

variable "scale_down_cron" {
    type = "string"
    description = "In UTC, when to scale down the bastion servers"
}

variable "public_ssh_key" {
    type = "string"
    description = "Public half of the SSH key to import into AWS"
}

variable "security_group_ids" {
    type = "list"
    description = "List of security groups to apply to the instances"
}

variable "subnet_ids" {
    type = "list"
    description = "List of subnets to create the instances in"
}

variable "enable_autoscaling" {
    default = false
    description = "Switch to enable autoscaling for bastion host. Default to false, option to switch in invoking script to true."
}

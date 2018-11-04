resource "aws_key_pair" "bastion" {
    key_name_prefix = "bastion-${data.aws_caller_identity.current.account_id}"
    public_key      = "${var.public_ssh_key}"
}

resource "aws_launch_configuration" "bastion" {
    name_prefix                 = "bastion-"
    image_id                    = "${data.aws_ami.amazon_linux_ami.id}"
    instance_type               = "${var.instance_type}"
    key_name                    = "${aws_key_pair.bastion.key_name}"
    security_groups             = ["${var.security_group_ids}"]
    iam_instance_profile        = "${aws_iam_instance_profile.bastion_instance_profile.name}"
    user_data                   = "${element(data.template_file.user_data.*.rendered,0)}"

    ebs_block_device {
      device_name = "/dev/xvdcz"
      volume_type = "gp2"
      volume_size = "22"
      delete_on_termination = "true"
    }

    associate_public_ip_address = true
    enable_monitoring           = true
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_iam_instance_profile" "bastion_instance_profile" {
  name_prefix = "ec2_bastion-"
  role = "${aws_iam_role.bastion_instance.name}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role" "bastion_instance" {
  name_prefix = "ec2_bastion-"
  assume_role_policy = "${data.aws_iam_policy_document.bastion_instance.json}"

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "bastion_instance" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com"
      ]
    }
  }
}

resource "aws_autoscaling_group" "bastion" {
    name_prefix               = "Bastion-"
    max_size                  = "${var.max_size}"
    min_size                  = "${var.min_size}"
    default_cooldown          = "${var.cooldown}"
    launch_configuration      = "${aws_launch_configuration.bastion.name}"
    health_check_grace_period = "${var.health_check_grace_period}"
    health_check_type         = "EC2"
    desired_capacity          = "${var.desired_capacity}"
    vpc_zone_identifier       = ["${var.subnet_ids}"]
    termination_policies      = ["ClosestToNextInstanceHour", "OldestInstance", "Default"]
    enabled_metrics           = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_schedule" "scale_up" {
    count                  = "${var.enable_autoscaling ? 1 : 0}"
    autoscaling_group_name = "${aws_autoscaling_group.bastion.name}"
    scheduled_action_name  = "Scale Up"
    recurrence             = "${var.scale_up_cron}"
    min_size               = "${var.scale_up_min_size}"
    max_size               = "${var.scale_up_max_size}"
    desired_capacity       = "${var.scale_up_desired_capacity}"
}

resource "aws_autoscaling_schedule" "scale_down" {
    count                  = "${var.enable_autoscaling ? 1 : 0}"
    autoscaling_group_name = "${aws_autoscaling_group.bastion.name}"
    scheduled_action_name  = "Scale Down"
    recurrence             = "${var.scale_down_cron}"
    min_size               = "${var.scale_down_min_size}"
    max_size               = "${var.scale_down_max_size}"
    desired_capacity       = "${var.scale_down_desired_capacity}"
}

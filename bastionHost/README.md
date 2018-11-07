## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cooldown | The amount of time, in seconds, after a scaling activity completes before another scaling activity can start. | string | - | yes |
| desired\_capacity | The number of bastion instances that should be running in the group. | string | - | yes |
| enable\_autoscaling | Switch to enable autoscaling for bastion host. Default to false, option to switch in invoking script to true. | string | `false` | no |
| health\_check\_grace\_period | Time, in seconds, after instance comes into service before checking health. | string | - | yes |
| instance\_type | Instance type to make the Bastion host from | string | - | yes |
| max\_size | Maximum number of bastion instances that can be run simultaneously | string | - | yes |
| min\_size | Minimum number of bastion instances that can be run simultaneously | string | - | yes |
| public\_ssh\_key | Public half of the SSH key to import into AWS | string | - | yes |
| scale\_down\_cron | In UTC, when to scale down the bastion servers | string | - | yes |
| scale\_down\_desired\_capacity | The number of bastion instances that should be running when scaling down. | string | - | yes |
| scale\_down\_max\_size | Maximum number of bastion instances that can be running when scaling down | string | - | yes |
| scale\_down\_min\_size | Minimum number of bastion instances that can be running when scaling down | string | - | yes |
| scale\_up\_cron | In UTC, when to scale up the bastion servers | string | - | yes |
| scale\_up\_desired\_capacity | The number of EC2 instances that should be running in the group. Default 0. Set to -1 if you don't want to change the desired capacity at the scheduled time. | string | - | yes |
| scale\_up\_max\_size | The maximum size for the Auto Scaling group. Default 0. Set to -1 if you don't want to change the maximum size at the scheduled time. | string | - | yes |
| scale\_up\_min\_size | The minimum size for the Auto Scaling group. Default 0. Set to -1 if you don't want to change the minimum size at the scheduled time. | string | - | yes |
| security\_group\_ids | List of security groups to apply to the instances | list | - | yes |
| subnet\_ids | List of subnets to create the instances in | list | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| ami\_id | ID of the selected AMI |
| auto\_scaling\_group\_id | ID of the Bastion's auto scaling group |
| auto\_scaling\_group\_name | Name of the Bastion's auto scaling group |
| launch\_configuration\_id | ID of the Bastion's launch configuration |
| launch\_configuration\_name | Name of the Bastion's launch configuration |
| ssh\_key\_name | Name of the Bastion's SSH key |

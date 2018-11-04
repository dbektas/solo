variable "region" {
  default = ""
}

variable "region_west" {
  default = ""
}

variable "vpc_cidr" {
  default = ""
}

variable "vpc_cidr_west" {
  default = ""
}

variable "vpc_private_subnets_cidr" {
  default = []
}

variable "vpc_public_subnets_cidr" {
  default = []
}

variable "vpc_private_subnets_cidr_west" {
  default = []
}

variable "vpc_public_subnets_cidr_west" {
  default = []
}

variable "vpc_name" {
  default = ""
}

variable "public_ssh_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCjvMNL+6gfRgEbhIjZi1SFIoW9hPr6+C4q09QvmkQ8tgJMfq8fTQEDSXcv8PBCQSF11B2L4PGycJ2o8EEltnJ3cQeQUHtCIdZi/WmnDwpmqc6zK4X9gl1+nY1Tgt1K7HEA6SKUOkLkuTBWttksHibgEv5/AVhhxOAVHm1V/mmHeCAYhjNzgly7rP54U0qZJ4VmLcYHmXh1Aahbo1QfPud+iwrSzt+gyPFDEADg0U7YiP96H1Cw71sAE1Tm3/mXE3uai6Xn2jTOIFTYPLshgjWNy9/D3s97FHLrc+IPNl2oeEorpdlkhmm5TJy+ZcoPurox053nE5Fel7DJBDE6Ilqh meanmachine@dinobeks"
}

variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "model_endpoint" {
  type    = string
  default = "jumpstart-dft-dft-llama2-pocsss"
}

variable "project_name" {
  type    = string
  default = "llama2-poc"
}

variable "log_retention" {
  type    = number
  default = 5
}
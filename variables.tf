variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "model_endpoint" {
  type    = string
  default = "jumpstart-dft-llama-demo"
}

variable "project_name" {
  type    = string
  default = "llama2-demo"
}

variable "log_retention" {
  type    = number
  default = 5
}
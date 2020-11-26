variable "region" {
  type    = string
  default = "southamerica-east1"
}

variable "project" {
  type    = string
  default = "personal-00"
}

variable "port" {
  type    = number
  default = 5432
}

variable "dbname" {
  type    = string
  default = "vgteams"
}

variable "username" {
  type    = string
  default = "postgres"
}

variable "password" {
  type    = string
  default = "admin"
}

variable "ssh_key" {
  default = {
    user   = "jhordycg"
    public = "~/.ssh/gcp-personal-00.pub"
  }
}


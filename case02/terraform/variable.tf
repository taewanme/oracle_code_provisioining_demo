variable user {
  type    = "string"
  default = "taewanme@google.com"
}

variable password {
  type    = "string"
  default = "@test12K@"
}

variable domain {
  type    = "string"
  default = "a514682"
}

variable endpoint {
  type    = "string"
  default = "https://compute.uscom-central-1.oraclecloud.com/"
}

variable ssh_public_key_file {
  description = "ssh public key"
  default     = "../../id_rsa.pub"
}

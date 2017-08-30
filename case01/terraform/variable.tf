variable user {
  type    = "string"
  default = "taewanme@google.net"
}

variable password {
  type    = "string"
  default = "@Test123M@"
}

variable domain {
  type    = "string"
  default = "a514683"
}

variable endpoint {
  type    = "string"
  default = "https://compute.uscom-central-1.oraclecloud.com/"
}

variable ssh_public_key_file {
  description = "ssh public key"
  default     = "../../id_rsa.pub"
}

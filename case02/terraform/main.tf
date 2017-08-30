provider "opc" {
  user            = "${var.user}"
  password        = "${var.password}"
  identity_domain = "${var.domain}"
  endpoint        = "${var.endpoint}"
}

resource "opc_compute_ip_reservation" "ipreser_lb1" {
  parent_pool = "/oracle/public/ippool"
  permanent   = true
}

resource "opc_compute_instance" "lb1" {
  name       = "lbserver"
  label      = "lbserver"
  shape      = "oc3"
  image_list = "/oracle/public/OL_6.7_UEKR3_x86_64"
  ssh_keys   = ["${opc_compute_ssh_key.sshkey01.name}"]

  networking_info {
    index          = 0
    shared_network = true
    nat            = ["${opc_compute_ip_reservation.ipreser_lb1.name}"]
    sec_lists      = ["${opc_compute_security_list.oc_list.name}"]
  }
}



resource "opc_compute_instance" "web1" {
  name       = "web1"
  label      = "web1"
  shape      = "oc3"
  image_list = "/oracle/public/OL_6.7_UEKR3_x86_64"
  ssh_keys   = ["${opc_compute_ssh_key.sshkey01.name}"]

  networking_info {
    index          = 0
    shared_network = true
    nat            = ["${opc_compute_ip_reservation.ipreser_web1.name}"]
    sec_lists      = ["${opc_compute_security_list.oc_list.name}"]
  }
}

resource "opc_compute_ip_reservation" "ipreser_web1" {
  parent_pool = "/oracle/public/ippool"
  permanent   = true
}

resource "opc_compute_instance" "web2" {
  name       = "web2"
  label      = "web2"
  shape      = "oc3"
  image_list = "/oracle/public/OL_6.7_UEKR3_x86_64"
  ssh_keys   = ["${opc_compute_ssh_key.sshkey01.name}"]

  networking_info {
    index          = 0
    shared_network = true
    nat            = ["${opc_compute_ip_reservation.ipreser_web2.name}"]
    sec_lists      = ["${opc_compute_security_list.oc_list.name}"]
  }
}

resource "opc_compute_ip_reservation" "ipreser_web2" {
  parent_pool = "/oracle/public/ippool"
  permanent   = true
}


resource "opc_compute_instance" "db1" {
  name       = "db1"
  label      = "db1"
  shape      = "oc3"
  image_list = "/oracle/public/OL_6.7_UEKR3_x86_64"
  ssh_keys   = ["${opc_compute_ssh_key.sshkey01.name}"]

  networking_info {
    index          = 0
    shared_network = true
    nat            = ["${opc_compute_ip_reservation.ipreser_db1.name}"]
    sec_lists      = ["${opc_compute_security_list.oc_list.name}"]
  }
}

resource "opc_compute_ip_reservation" "ipreser_db1" {
  parent_pool = "/oracle/public/ippool"
  permanent   = true
}

resource "opc_compute_instance" "nagios" {
  name       = "nagios"
  label      = "nagios"
  shape      = "oc3"
  image_list = "/oracle/public/OL_6.7_UEKR3_x86_64"
  ssh_keys   = ["${opc_compute_ssh_key.sshkey01.name}"]

  networking_info {
    index          = 0
    shared_network = true
    nat            = ["${opc_compute_ip_reservation.ipreser_nagios.name}"]
    sec_lists      = ["${opc_compute_security_list.oc_list.name}"]
  }
}

resource "opc_compute_ip_reservation" "ipreser_nagios" {
  parent_pool = "/oracle/public/ippool"
  permanent   = true
}

resource "opc_compute_security_list" "oc_list" {
  name                 = "oc_list"
  policy               = "DENY"
  outbound_cidr_policy = "PERMIT"
}

resource "opc_compute_sec_rule" "oc-http" {
  name             = "Allow-Demo-http-access"
  source_list      = "seciplist:/oracle/public/public-internet"
  destination_list = "seclist:${opc_compute_security_list.oc_list.name}"
  action           = "permit"
  application      = "/oracle/public/http"
  disabled         = false
}

resource "opc_compute_sec_rule" "oc-ssh" {
  name             = "Allow-Demo-ssh-access"
  source_list      = "seciplist:/oracle/public/public-internet"
  destination_list = "seclist:${opc_compute_security_list.oc_list.name}"
  action           = "permit"
  application      = "/oracle/public/ssh"
  disabled         = false
}

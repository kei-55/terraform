variable username {}
variable public_key {}
variable cores {}
variable memory {}
variable disk_size {}
variable ip_address {}
variable pm_api_token_id {}
variable pm_api_token_secret {}
variable pm_api_url {}

terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.13"
    }
  }
}

provider "proxmox" {
  pm_api_token_id = "${var.pm_api_token_id}"
  pm_api_token_secret = "${var.pm_api_token_secret}"
  pm_api_url = "${var.pm_api_url}"
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "intern-vm" {
  name = "ubuntu-${var.username}"
  target_node = "pve"
  clone = "ubuntu-22.04.2"
  os_type = "ubuntu"
  boot = "order=virtio0"
  cores   = "${var.cores}"
  memory  = "${var.memory}"
  disk {
    storage = "local-lvm"
    type = "virtio"
    size = "${var.disk_size}G"
  }
  network {
    model = "virtio"
    bridge = "vmbr0"
    macaddr = "auto"
    firewall = false
  }
  ipconfig0 = "ip=${var.ip_address}/24,gw=192.168.0.1"
  ciuser = "${var.username}"
  sshkeys = <<EOF
${var.public_key}
EOF

}
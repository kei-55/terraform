resorce "proxmox_instanse" "ubuntu" {
  name = "ubuntu"
  node = "pve"
  os_type = "ubuntu"
  cores = 2
  memory = 2048
  disk {
    size = 20
    storage = "local"
  }
  network {
    bridge = "vmbr0"
  }
  clone {
    full = true
    pool = "ubuntu"
  }
}
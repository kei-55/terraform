resorce "proxmox_instanse" "ubuntu" {

  name = "ubuntu"
  #node名
  node = "pve"
  #vmid
  vmid = 100 ~ 200
  #OSの種類
  os_type = "ubuntu"
  #cpuのコア数
  cores = 2
  #メモリのサイズ
  memory = 2048
  disk {
    size = 50
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
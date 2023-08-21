job "nodejs" {
  datacenters = ["dc1"]
  group "echo" {
    count = 1
    task "server" {
      driver = "docker"
      config {
        image = "jabadrian/nodejs-demo:latest"

        auth {
          username = "jabadrian"
          password = "dckr_pat_FOoJeoC8nuj_ZiPlcXTf5ifY0Pk"
          server_address = "hub.docker.com"
        }
        port_map {
          http = 3000
        }
      }
      resources {
        network {
          mbits = 10
          port "http" {
            static = 3000
          }
        }
      }
    }
  }
}
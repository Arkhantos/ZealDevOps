job "redis-nodejs" {
  datacenters = ["dc1"]
  type        = "service"

  group "app" {
    count = 1

    network {
      mode = "host"
      port "app" {
        to     = 8081
        static = 8081
      }
      port "redis" {
        to     = 6379
        static = 6379
      }
    }

    task "redis-server" {
      driver = "docker"

      config {
        network_mode = "host"
        image        = "redis:7"
        ports        = ["redis"]
      }

      resources {
        cores  = 1
        memory = 256
      }
    }


    task "app" {
      driver = "docker"
      env {
        DEMO_REDIS_ADDR = "${NOMAD_ADDR_redis}"
      }

      config {
        network_mode = "host"
        image        = "jabadrian/nodejs-redis:latest"
		auth {
          username = "jabadrian"
          password = "dckr_pat_FOoJeoC8nuj_ZiPlcXTf5ifY0Pk"
          server_address = "hub.docker.com"
        }
        ports        = ["app"]
      }

      resources {
        cores  = 1
        memory = 512
      }
    }
  }
}
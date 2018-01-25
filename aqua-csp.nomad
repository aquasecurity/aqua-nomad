job "aqua-csp" {
  datacenters = ["dc1"]
  type = "service"

  update {
    max_parallel = 1
    min_healthy_time = "10s"
    healthy_deadline = "3m"
    auto_revert = false
    canary = 0
  }

  group "aqua" {
    count = 1
    restart {
      attempts = 10
      interval = "5m"
      delay = "25s"
      mode = "delay"
    }

    ephemeral_disk {
      size = 300
    }
    task "csp" {
      driver = "docker"
      config {
        volumes = [
          "/var/run/docker.sock:/var/run/docker.sock"
        ]
        image = "aquasec/csp:2.6"
        port_map {
          web = 8080
          gw = 3622
        }
        auth {
            username = "your-dockerhub-user"
            password = "your-dockerhub-pass"
        }
      }
      resources {
        cpu    = 500 # 500 MHz
        memory = 256 # 256MB
        network {
          mbits = 10
          port "web" {
            static = 8080
          }
          port "gw" {
            static = 3622
          }          
        }
      }
      service {
        name = "global-aqua-check"
        tags = ["global", "csp"]
        port = "web"
        check {
          name     = "alive"
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }

    }
  }
}

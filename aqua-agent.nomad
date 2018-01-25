job "aqua-agent" {
  datacenters = ["dc1"]
  type = "service"

  update {
    max_parallel = 1
    min_healthy_time = "10s"
    healthy_deadline = "3m"
    auto_revert = false
    canary = 0
  }

  group "aqua-agent" {
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
    task "aqua-agent" {
      driver = "docker"
      config {
        privileged = true
        pid_mode = "host"
        volumes = [
          "/var/run:/var/run",
          "/dev:/dev",
          "/opt/aquasec:/host/opt/aquasec",
          "/opt/aquasec/tmp:/opt/aquasec/tmp",
          "/opt/aquasec/audit:/opt/aquasec/audit",
          "/proc:/host/proc",
          "/sys:/host/sys",
          "/etc:/host/etc"
        ]
        image = "aquasec/agent:2.6"
        auth {
            username = "your-dockerhub-user"
            password = "your-dockerhub-pass"
        }
      }
      env {
        "SILENT" = "yes"
        "AQUA_TOKEN" = "token"
        "AQUA_SERVER" = "GATEWAY_IP_ADDR:3622"
        "AQUA_NETWORK_CONTROL" = "0"
        "RESTART_CONTAINERS" = "no"
      } 
    }
  }
}

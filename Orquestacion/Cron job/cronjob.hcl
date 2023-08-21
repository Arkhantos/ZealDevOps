job "cronjob-hourly" {
  periodic {
    cron = "@hourly"
    prohibit_overlap = true
  }
  datacenters = ["dc1"]
  type = "batch"
  group "main" {
    task "cron" {
      driver = "raw_exec"
      config {
        command = "echo 'hello world'"
      }
    }
  }
}
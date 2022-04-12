module "email" {
  source = "../../modules/gcp_monitoring_notification_email_channel"
  display_name = "Selvam M"
  email_address = "selvam194@gmail.com"
}

module "cpu" {
  source = "../../modules/gcp_monitoring_alert_policy"
  display_name = "CPU utilization"
  cond_display_name = "Cloud SQL Database - CPU utilization [MEAN]"
  filter = "metric.type=\"cloudsql.googleapis.com/database/cpu/utilization\" resource.type=\"cloudsql_database\""
  comparison = "COMPARISON_GT"
  duration   = "300s"
  threshold_value = "0.8"
  cross_series_reducer = "REDUCE_MEAN"
  series_aligner = "ALIGN_MEAN"
  notification_channels = [module.email.channel_id]
}

module "memory" {
  source = "../../modules/gcp_monitoring_alert_policy"
  display_name = "Memory utilization"
  cond_display_name = "Cloud SQL Database - Memory utilization [MEAN]"
  filter = "metric.type=\"cloudsql.googleapis.com/database/memory/utilization\" resource.type=\"cloudsql_database\""
  comparison = "COMPARISON_GT"
  duration   = "300s"
  threshold_value = "0.8"
  cross_series_reducer = "REDUCE_MEAN"
  series_aligner = "ALIGN_MEAN"
  notification_channels = [module.email.channel_id]
}

module "disk" {
  source = "../../modules/gcp_monitoring_alert_policy"
  display_name = "Disk utilization"
  cond_display_name = "Cloud SQL Database - Disk utilization [MEAN]"
  filter = "metric.type=\"cloudsql.googleapis.com/database/disk/utilization\" resource.type=\"cloudsql_database\""
  comparison = "COMPARISON_GT"
  duration   = "300s"
  threshold_value = "0.9"
  cross_series_reducer = "REDUCE_MEAN"
  series_aligner = "ALIGN_MEAN"
  notification_channels = [module.email.channel_id]
}

module "connection" {
  source = "../../modules/gcp_monitoring_alert_policy"
  display_name = "Cloud SQL Connections"
  cond_display_name = "Cloud SQL Database - Cloud SQL Connections [MEAN]"
  filter = "metric.type=\"cloudsql.googleapis.com/database/network/connections\" resource.type=\"cloudsql_database\""
  comparison = "COMPARISON_GT"
  duration   = "300s"
  threshold_value = "1000"
  cross_series_reducer = "REDUCE_MEAN"
  series_aligner = "ALIGN_MEAN"
  notification_channels = [module.email.channel_id]
}

module "replication" {
  source = "../../modules/gcp_monitoring_alert_policy"
  display_name = "Replication lag"
  cond_display_name = "Cloud SQL Database - Replication lag [MAX]"
  filter = "metric.type=\"cloudsql.googleapis.com/database/mysql/replication/seconds_behind_master\" resource.type=\"cloudsql_database\""
  comparison = "COMPARISON_GT"
  duration   = "300s"
  threshold_value = "900"
  cross_series_reducer = "REDUCE_MEAN"
  series_aligner = "ALIGN_MEAN"
  notification_channels = [module.email.channel_id]
}

module "uptime" {
  source = "../../modules/gcp_monitoring_alert_policy"
  display_name = "Uptime"
  cond_display_name = "Cloud SQL Database - Uptime [MIN]"
  filter = "metric.type=\"cloudsql.googleapis.com/database/uptime\" resource.type=\"cloudsql_database\""
  comparison = "COMPARISON_LT"
  duration = "120s"
  threshold_value = "1"
  cross_series_reducer = "REDUCE_MIN"
  series_aligner = "ALIGN_RATE"
  notification_channels = [module.email.channel_id]
}
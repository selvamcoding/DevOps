resource "google_monitoring_alert_policy" "alert_policy" {
  combiner     = "OR"
  display_name = var.display_name

  conditions {
    display_name = var.cond_display_name
    condition_threshold {
      filter = var.filter
      comparison = var.comparison
      duration   = var.duration
      threshold_value = var.threshold_value
      aggregations {
        alignment_period = "60s"
        cross_series_reducer = var.cross_series_reducer
        per_series_aligner = var.series_aligner
        group_by_fields = ["resource.label.database_id"]
      }
    }
  }

  notification_channels = var.notification_channels

  documentation {
    mime_type = "text/markdown"
    content = "Google Cloud Alerting"
  }
}
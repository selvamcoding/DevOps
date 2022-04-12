resource "google_monitoring_notification_channel" "basic" {
  type = "email"
  display_name = var.display_name
  labels = {
    email_address = var.email_address
  }
}
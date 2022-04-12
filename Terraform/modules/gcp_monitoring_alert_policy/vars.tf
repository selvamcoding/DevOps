variable "display_name" {}

variable "cond_display_name" {}

variable "filter" {}

variable "comparison" {}

variable "duration" {}

variable "threshold_value" {}

variable "series_aligner" {}

variable "cross_series_reducer" {}

variable "notification_channels" {
  type = list(string)
}

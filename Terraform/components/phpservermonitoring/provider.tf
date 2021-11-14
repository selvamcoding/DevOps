provider "google" {
  region = var.region
  credentials = file(var.credentials)
}

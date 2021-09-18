// Configure the Google Cloud provider
provider "google" {
 credentials = file("<path_to_your_service_account.json")
 project     = "##Project Name #####"
 region      = var.region
}
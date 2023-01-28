variable "env" {
    type = string
    default = "dev"
}

variable "loc" {
    type = list(string)
    default = ["eastus2"]
}
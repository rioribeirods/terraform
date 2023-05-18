variable "amis" {
    type = map

    default = {
        "us-east-1" = "ami-007855ac798b5175e"
        "us-east-2" = "ami-08333bccc35d71140"
    }
}

variable "cdirs_remote_access" {
    type = list(string)

    default = ["your external ip address"]
}
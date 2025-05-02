#######################################################
# kubernetes
#######################################################
variable "project" {
    type        = string
    description = "Project or application name." 
}

variable "namespaces" {
    type        = list(string)
    description = "Namespaces being created by this module"
}

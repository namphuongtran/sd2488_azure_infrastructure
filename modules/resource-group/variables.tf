variable "name" {
  type = string
  description = "the name for the group"
}

variable "location" {
  type = string
  description = "the location of the resource"
}

variable "default_tags" {
  type = map(string)
  description = "the default tags name"
}
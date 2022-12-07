variable "name" {
	type = string
}

variable "channel_config" {
  type = list(map(string))
}
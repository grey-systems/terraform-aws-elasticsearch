/**
* List of Ips allowed to access AWS EL domain
*/
variable "ips_allowed" {
  type = "list"
}

/**
* Description of the logical environment to which this EL domain will belong to
*/
variable "environment" {
  type = "string"
}

/**
* Name of the EL domain. Note that for configuration simplicity , we always prefix
* the name with the environment's name. That way it's much easier to manage different
* logical environments inside the same AWS Account  and/or region.
*/
variable "name" {
  type = "string"
}

/**
* Number of instances of the cluster
*/
variable "number_instances" {
  default = "2"
}

/**
* Size of every cluster's instance
*/
variable "instance_ebs_size" {
  default = "30"
}

/**
* AWS EL instance type. Check https://aws.amazon.com/es/elasticsearch-service/pricing/ for more info
*/
variable "instance_type" {
  type    = "string"
  default = "t2.small.elasticsearch"
}

/**
* Route 53 Zone Id.
*/
variable "route53_zone_id" {
  type = "string"
}

/**
  * EBS volume type
*/
variable "ebs_volume_type" {
  type    = "string"
  default = "gp2"
}

/**
* Headquarters public IP. Useful if you want to keep all of your EL's domain
* accesible from a single point in your terraform's configuration
*/
variable "hq_default_ip" {
  type = "string"
}

/**
* Determines if the EL's cluster instances must be distributed across several Availability Zones.
*/
variable "zone_awareness_enabled" {
  type    = "string"
  default = "true"
}

/**
* Automatedx Snapshot time (expresses as an hour)
*/
variable "automated_snapshot_start_hour" {
  type    = "string"
  default = "23"
}

variable "version" {
  type    = "string"
  default = "5.1"
}

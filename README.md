# terraform-elasticsearch

This repo contains a [Terraform](https://terraform.io/) modules for
provisioning an [AWS Elastic Search](https://aws.amazon.com/es/elasticsearch-service/) domain, with the following features by default:

* Zone Aware -> check this link for more info. [AWS repo](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-managedomains.html#es-managedomains-zoneawareness)
* Environment-based name: The name of the domain will be composed by "${var.environment}-${var.name}"
* EBS-type volumes used.
* 30 GB per instance.

AWS provider is not configured in this module directly, so it's responsibility of the developer to set it up in some of the upper terraform configuration files that use this module. This approach will give the developer the freedom to define its infrastructure (single-region based, multi-region) depending on his needs.

Module usage:

      provider "aws" {
        access_key = "${var.access_key}"
        secret_key = "${var.secret_key}"
        region     = "${var.region}"
      }

     module "foo" {
       source = "github.com/grey-systems/terraform-elasticsearch.git?ref=master"
       module "elasticsearch" {
       source          = "git::ssh://hg@bitbucket.org/greysystems/terraform-elasticsearch.git?ref=1.0.0"
        name            = "${var.domain_name}"
       environment     = "${var.environment}"
       route53_zone_id = "${var.route53_zone_id}"
       ips_allowed     = ["${var.your_ips_allowed_to_access_el}"]
     }



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| automated_snapshot_start_hour |  Automatedx Snapshot time (expresses as an hour) | string | `23` | no |
| ebs_volume_type | /**   * EBS volume type | string | `gp2` | no |
| environment |  Description of the logical environment to which this EL domain will belong to | string | - | yes |
| hq_default_ip |  Headquarters public IP. Useful if you want to keep all of your EL's domain * accesible from a single point in your terraform's configuration | string | `84.127.228.166/32` | no |
| instance_ebs_size |  Size of every cluster's instance | string | `30` | no |
| instance_type |  AWS EL instance type. Check https://aws.amazon.com/es/elasticsearch-service/pricing/ for more info | string | `t2.small.elasticsearch` | no |
| ips_allowed |  List of Ips allowed to access AWS EL domain | list | - | yes |
| name |  Name of the EL domain. Note that for configuration simplicity , we always prefix the name with the environment's name. That way it's much easier to manage different  logical environments inside the same AWS Account  and/or region. | string | - | yes |
| number_instances |  Number of instances of the cluster | string | `2` | no |
| route53_zone_id |  Route 53 Zone Id. | string | - | yes |
| zone_awareness_enabled |  Determines if the EL's cluster instances must be distributed across several Availability Zones. | string | `true` | no |

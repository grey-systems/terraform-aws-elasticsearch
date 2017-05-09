# terraform-elasticsearch

This repo contains a [Terraform](https://terraform.io/) module for
provisioning an [AWS Elastic Search](https://aws.amazon.com/es/elasticsearch-service/) domain, with the following features by default:

* Zone Aware -> check this link for more info. [AWS repo](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-managedomains.html#es-managedomains-zoneawareness)
* Environment-based name: The name of the domain will be composed by "${var.environment}-${var.name}"
* EBS-type volumes used.
* 30 GB per instance.

The terraform's AWS provider is not configured in this module directly, so it's responsibility of the developer to set it up in some of the upper lever terraform configuration files that want to use this module. This approach will give us the ability to define the topology of the infrastructure (single-region based, multi-region) depending on our needs.

Module usage:

      provider "aws" {
        access_key = "${var.access_key}"
        secret_key = "${var.secret_key}"
        region     = "${var.region}"
      }

     module "domain-elasticsearch" {
       source = "github.com/grey-systems/terraform-elasticsearch.git?ref=master"       
       name            = "${var.domain_name}"
       environment     = "${var.environment}"
       route53_zone_id = "${var.route53_zone_id}"
       ips_allowed     = ["${var.your_ips_allowed_to_access_el}"]
       hq_default_ip   = "${var.your_hq_public_ip}"
     }



Inputs
---------

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| automated_snapshot_start_hour |  Automatedx Snapshot time (expresses as an hour) | string | `23` | no |
| ebs_volume_type | EBS volume type | string | `gp2` | no |
| environment |  Description of the logical environment to which this EL domain will belong to | string | - | yes |
| hq_default_ip |  Headquarters public IP. Useful if you want to keep all of your EL's domains accesible from a single point in your terraform's configuration | string |  | yes |
| instance_ebs_size |  EBS volume size of every cluster's instance (in GB) | string | `30` | no |
| instance_type |  AWS EL instance type. Check https://aws.amazon.com/es/elasticsearch-service/pricing/ for more info about the different instance types | string | `t2.small.elasticsearch` | no |
| ips_allowed |  List of Ips allowed to access AWS EL domain | list | - | yes |
| name |  Name of the EL domain. Note that for configuration simplicity , we always prefix the name with the environment's name. That way it's much easier to manage different  logical environments inside the same AWS Account  and/or region. | string | - | yes |
| number_instances |  Number of instances of the cluster | string | `2` | no |
| route53_zone_id |  Route 53 Zone Id. | string | - | yes |
| zone_awareness_enabled |  Determines if the EL's cluster instances must be distributed across several Availability Zones. | string | `true` | no |

Contributing
------------
Everybody is welcome to contribute. Please, see [`CONTRIBUTING`][contrib] for further information.

[contrib]: CONTRIBUTING.md

Bug Reports
-----------

Bug reports can be sent directly to authors and/or using github's issues.


-------

Copyright (c) 2017 Grey Systems ([www.greysystems.eu](http://www.greysystems.eu))

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

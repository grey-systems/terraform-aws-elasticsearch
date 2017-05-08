/**
 * Module usage:
 *
 *      module "foo" {
 *        source = "github.com/grey-systems/terraform-elasticsearch.git?ref=master"
 *        module "elasticsearch" {
 *        source          = "git::ssh://hg@bitbucket.org/greysystems/terraform-elasticsearch.git?ref=1.0.0"
*         name            = "${var.domain_name}"
 *        environment     = "${var.environment}"
 *        route53_zone_id = "${var.route53_zone_id}"
 *        ips_allowed     = ["${var.your_ips_allowed_to_access_el}"]
 *      }
 *
 */

resource "aws_elasticsearch_domain" "es" {
  domain_name           = "${var.environment}-${var.name}"
  elasticsearch_version = "5.1"

  advanced_options {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  # Temporal workaround to avoid repeated modifyings over this resource
  lifecycle {
    ignore_changes = ["access_policies"]
  }

  access_policies = <<CONFIG
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Condition": {
                "IpAddress": {"aws:SourceIp": ["${var.hq_default_ip}",${join(",",formatlist("\"%s/32\"",var.ips_allowed))}]}
            }
        }
    ]
}
CONFIG

  ebs_options {
    ebs_enabled = true
    volume_type = "gp2"
    volume_size = "${var.instance_ebs_size}"
  }

  cluster_config {
    instance_type          = "${var.instance_type}"
    instance_count         = "${var.number_instances}"
    zone_awareness_enabled = "${var.zone_awareness_enabled}"
  }

  snapshot_options {
    automated_snapshot_start_hour = "${var.automated_snapshot_start_hour}"
  }

  tags {
    Domain = "${var.name}-domain"
  }
}

resource "aws_route53_record" "dns" {
  name    = "${var.name}"
  records = ["${aws_elasticsearch_domain.es.endpoint}"]
  zone_id = "${var.route53_zone_id}"
  ttl     = "300"
  type    = "CNAME"
}

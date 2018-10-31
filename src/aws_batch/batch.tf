resource "aws_batch_compute_environment" "sample_batch" {
  compute_environment_name = "sample_batch_env"
  service_role = "${aws_iam_role.aws_batch_service_role.arn}"
  type = "MANAGED"

  compute_resources {
    instance_role = "${aws_iam_instance_profile.ecs_instance_role.arn}"
    instance_type = [ "c4.large", "c4.xlarge", "c4.2xlarge" ]
    max_vcpus = 4
    min_vcpus = 0
    desired_vcpus= 2
    security_group_ids = [ "${aws_security_group.private.id}" ]
    subnets = [ "${aws_subnet.private-a.id}", "${aws_subnet.private-c.id}" ]
    type = "EC2"
    tags { 
      Name = "sample_batch"
    }
  }
}

resource "aws_batch_job_queue" "sample_batch" {
  name = "sample_batch_jq"
  state = "ENABLED"
  priority = 1
  compute_environments = [ "${aws_batch_compute_environment.sample_batch.arn}" ]
}

resource "aws_batch_job_definition" "sample_batch" {
  name = "sample_batch"
  type = "container"
  container_properties = "${file("job_definition.json")}"
}


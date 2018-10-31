resource "aws_cloudwatch_event_rule" "sample_batch_fire_policy" {
  name        = "sample_batch_fire_policy"
  description = "sample_batch"
  schedule_expression = "cron(0 23 * * ? *)"
}

resource "aws_cloudwatch_event_target" "batch" {
  rule         = "${aws_cloudwatch_event_rule.sample_batch_fire_policy.name}"
  role_arn     = "${aws_iam_role.cloudwatch_event_role.arn}"
  arn          = "${aws_batch_job_queue.sample_batch.arn}"

  batch_target {
    job_definition = "${aws_batch_job_definition.sample_batch.name}:${aws_batch_job_definition.sample_batch.revision}"
    job_name       = "sample_batch"
  }
}



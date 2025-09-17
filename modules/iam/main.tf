resource "aws_iam_user" "developer" {
  name = "bedrock-developer"
}

resource "aws_iam_access_key" "developer_key" {
  user = aws_iam_user.developer.name
}

resource "aws_iam_policy" "read_only" {
  name        = "bedrock-developer-readonly-policy"
  description = "Read-only access for grading"
  policy      = file("${path.module}/readonly-policy.json")
}

resource "aws_iam_user_policy_attachment" "attach" {
  user       = aws_iam_user.developer.name
  policy_arn = aws_iam_policy.read_only.arn
}

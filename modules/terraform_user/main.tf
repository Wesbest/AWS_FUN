resource "aws_iam_user" "user" {
  name = "LeastPrivilegedWes"
}

data "aws_iam_policy_document" "terraform_policy" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = ["${aws_iam_user.user.arn}"]
    }
  }
}

resource "aws_iam_role" "terraform_role" {
  name = "terraform_role"
  assume_role_policy = data.aws_iam_policy_document.terraform_policy.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonEC2FullAccess", "arn:aws:iam::aws:policy/AmazonVPCFullAccess"]
}

resource "aws_iam_access_key" "LeastPrivilegedWes" {
  user = aws_iam_user.user.name
}
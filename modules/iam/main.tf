resource "aws_iam_policy" "s3_read_policy" {
    name = "s3_read_policy"
    description= "allow ec2 to read the s3 bucket objects"
    policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Effect = "Allow",
                Action = "s3:GetObject",
                Resource = "arn:aws:s3:::${var.bucket_name}/${var.key_file}"
            }
        ]
    })
}

resource "aws_iam_role" "ec2_role" {
    name = "ec2_s3_access_role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Effect = "Allow",
                Principal = {
                    Service = "ec2.amazonaws.com"
                },
                Action = "sts:AssumeRole"
            }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_read_policy.arn
}

resource "aws_iam_instance_profile" "ec2_instance" {
    name = "ec2-s3-instance-profile"
    role = aws_iam_role.ec2_role.name
}
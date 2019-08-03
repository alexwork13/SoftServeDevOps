resource "aws_s3_bucket" "test-palach-devops" {
  bucket = "test-palach-devops13"
  acl = "private"

  tags = {
    Name        = "file-resource-devops-day13"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "object" {
  bucket = "test-palach-devops13"
  key    = "index.html"
  source = "./index.html"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("./index.html")
}
resource "aws_key_pair" "my-test-key" {
  key_name   = "ubuntu1"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDTX6JKLZwjbRKsN4LrjlBVXXEMuhVpzObfo/LssxSyAp+8AuEp1w8+gVTqo8ekLs6QfnsUyuxCiQ0gBlVO39bzKT4RvIb3ME8jJ9cHT0sSFUajwCWPsrNjdupM9FDOg7KJKJGrKnKTYrcrhVB8vOY9GkwdgzgYFTvQbETDAQns94+Xq8jO8vUFeKAJGYpCcOBOJ7Oqn+K7HAXzn0utlWfgTMDWNIYfsxn4BLaCp84ovQ/Dk/lrPJLyEgO9ENCBHIvmpvYr7oyTKdYWEXn7I6/DPzSVTzDOQIhzv6w8SKjDpICf19DGGb9fvMbZN83owTLWkoZzat33Ygnjj0K5cGFH alex@HP"
}



resource "aws_instance" "my_webserver" {
  ami                    = "ami-0bbc25e23a7640b9b"
  instance_type          = "t2.micro"
  iam_instance_profile   = "${aws_iam_instance_profile.instance_profile.id}"
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  user_data              = file("user_data.sh")
  subnet_id              = "${aws_subnet.public1.id}"
  key_name               = "${aws_key_pair.my-test-key.key_name}"

  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "Alexander Palazchenko"
  }
  depends_on = [aws_s3_bucket_object.object, aws_iam_role.s3fullaccess]
}


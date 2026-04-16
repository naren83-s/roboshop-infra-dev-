resource "aws_instance" "mongod" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id = local.database_subnet_id
  vpc_security_group_ids = [local.mongod_sg_id]
  iam_instance_profile = aws_iam_instance_profile.mongod.name

  tags = merge(
    {
        Name = "${var.project}-${var.environment}-mongod"
    },
    local.common_tags
  )
}


resource "terraform_data" "bootstrap" {
  triggers_replace = [
    aws_instance.mongod.id
  ]
   connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mongod.private_ip
  }
    provisioner "file" {
    source      = "boostrap.sh"    # Path on local machine
    destination = "/tmp/boostrap.sh"   # Path on remote machine
  }


  provisioner "remote-exec" {
    inline = [ 
        "chmod +x /tmp/boostrap.sh",
        "sudo sh /tmp/boostrap.sh"
     ]
  }
}
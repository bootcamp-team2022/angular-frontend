resource "aws_vpc" "bc22_main_vpc" {
    cidr_block = var.bc22_vpc_cidr

    enable_dns_hostnames = "true"
    enable_dns_support = "true"

    tags = {
        Name = "bc22VPC01-${var.environment}"
        Description = "Manage by Terraform for ${var.environment} environment."
    }
}

resource "aws_subnet" "bc22_priv_subnet_a" {
    vpc_id = aws_vpc.bc22_main_vpc.id

    cidr_block = var.bc22_subnet_cidr["dbsn1"]

    availability_zone = var.bc22_az["az_a"]

    tags = {
        Name = "bc22VPC01-dbsnA-${var.environment}"
        Description = "Manage by Terraform for ${var.environment} environment."
    }    
}

resource "aws_subnet" "bc22_priv_subnet_b" {
    vpc_id = aws_vpc.bc22_main_vpc.id

    cidr_block = var.bc22_subnet_cidr["dbsn2"]

    availability_zone = var.bc22_az["az_b"]

    tags = {
        Name = "bc22VPC01-dbsnB-${var.environment}"
        Description = "Manage by Terraform for ${var.environment} environment."
    }
}

resource "aws_network_acl" "bc22_nacl_sna" {
    vpc_id = aws_vpc.bc22_main_vpc.id
    subnet_ids = [aws_subnet.bc22_priv_subnet_a.id,aws_subnet.bc22_priv_subnet_b.id]

    ingress {
        rule_no = 100
        action = "allow"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_block = "0.0.0.0/0"

    }

    egress {
        rule_no = 200
        action = "allow"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_block = "0.0.0.0/0"
    }

    tags = {
        Name = "bc22_db"
        Description = "Manage by Terraform for ${var.environment} environment."
    }

}


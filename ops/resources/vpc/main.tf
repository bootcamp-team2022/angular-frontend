resource "aws_vpc" "bc22_main_vpc" {
    cidr_block = var.bc22_vpc_cidr

    tags = {
        Description = "Manage by Terraform for ${var.environment} environment."
    }
}

resource "aws_subnet" "bc22_priv_subnet_a" {
    vpc_id = aws_vpc.bc22_main_vpc.id

    cidr_block = var.bc22_subnet_cidr["dbsn1"]

    availability_zone = var.bc22_az["az_a"]
    
}

resource "aws_subnet" "bc22_priv_subnet_b" {
    vpc_id = aws_vpc.bc22_main_vpc.id

    cidr_block = var.bc22_subnet_cidr["dbsn2"]

    availability_zone = var.bc22_az["az_b"]
}


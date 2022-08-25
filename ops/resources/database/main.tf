resource "aws_db_instance" "bc2022-db-free" {
  allocated_storage = 20
  #    max_allocated_storage = 20
  engine              = "mysql"
  engine_version      = "8.0.28"
  instance_class      = "db.t3.micro"
  identifier          = "bc22db01-${var.environment}"
  username            = var.db_user
  password            = var.db_pass
  skip_final_snapshot = true

  multi_az = false

  db_subnet_group_name = var.subnetgroup

  tags = {
    Description = "Managed by Terraform."
    Environment = var.environment
  }
}
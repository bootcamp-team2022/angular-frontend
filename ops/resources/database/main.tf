resource "aws_db_isntance" "bc2020-db-free" {
    allocated_storage = 20
    max_allocated_storage = 20
    engine = "mysql"
    engine_version = "8.0.28"
    instance_class = "db.t3.micro"
    name = "bc22DB01-${var.environment}"
}
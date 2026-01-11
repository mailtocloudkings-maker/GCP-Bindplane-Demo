output "db_host" {
  description = "Cloud SQL public IP address"
  value       = google_sql_database_instance.postgres.public_ip_address
}

output "db_port" {
  description = "PostgreSQL port"
  value       = 5432
}

output "db_name" {
  description = "BindPlane database name"
  value       = google_sql_database.bindplane.name
}

output "db_user" {
  description = "BindPlane database user"
  value       = google_sql_user.bindplane.name
}

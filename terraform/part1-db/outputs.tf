output "db_host" {
  description = "Cloud SQL private/public IP"
  value       = google_sql_database_instance.postgres.ip_address[0].ip_address
}

output "db_port" {
  value = 5432
}

output "db_name" {
  value = google_sql_database.bindplane.name
}

output "db_user" {
  value = google_sql_user.bindplane.name
}

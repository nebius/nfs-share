output "nfs_server_internal_ip" {
  description = "The internal IP address to access the NFS server"
  value       = nebius_compute_instance.nfs_server.network_interface.0.ip_address
}
output "minecraft_server_ip" {
  description = "Public IP address of the Minecraft server"
  value       = aws_instance.minecraft_server.public_ip
}

output "minecraft_server_dns" {
  description = "Public DNS name of the Minecraft server"
  value       = aws_instance.minecraft_server.public_dns
}
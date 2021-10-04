output "external_ip_address_app" {
  value = module.app.external_ip_address_app
}
output "external_ip_address_db" {
  value = module.db.external_ip_address_db
}
output "local_ip_address_db" {
  value = module.db.local_ip_address_db
}
/*
output "lb_app_ip_address" {
  value = yandex_lb_network_load_balancer.app_lb.listener.*.external_address_spec[0].*.address[0]
}
*/


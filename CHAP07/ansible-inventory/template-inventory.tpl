[vm-web]
%{ for host, ip in vm_dnshost ~}
${host} ansible_host=${ip}
%{ endfor ~}
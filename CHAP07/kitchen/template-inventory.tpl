[vm-web]
%{ for index, vm in vm_dns ~}
${vm} ansible_host=${vm_ip[index]}
%{ endfor ~}
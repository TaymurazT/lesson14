[webservers]
%{ for addr in ip_addrs ~}
${addr}
%{ endfor ~}
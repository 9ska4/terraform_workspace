#!/bin/bash
echo "Hello! Message from simple webserv" > index.html
nohup busybox httpd -f -p 8080 &

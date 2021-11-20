#!/bin/bash
rm -rf nohup.out
rm -rf index.html
ps -ef | grep "nohup busybox httpd -f -p 8080 &" | awk '{print $2}' | head -1 | xargs -r kill

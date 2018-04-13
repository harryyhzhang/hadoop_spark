docker-machine rm -y node-1
docker-machine create -d virtualbox --engine-env HTTP_PROXY=http://10.100.33.50:8080 --engine-env HTTPS_PROXY=https://10.100.33.50:8080  --virtualbox-cpu-count "4" --virtualbox-memory "8192" node-1 

# schema-registry-ui-nginx


Docker file with NGINX webserver to host https://github.com/lensesio/schema-registry-ui (by default caddy webserver is used). 

A proxy is used to access the schema registry. The 'SCHEMA_URL' is redirected to 'SCHEMAREGISTRY_URL'



**Build docker image (local)**

`docker build -t schema-registry-ui-nginx .`

**Run docker container (local)**

`docker run -p "5555:80" -e "SCHEMAREGISTRY_URL=http://localhost:3502" -d schema-registry-ui-nginx`

***Push docker***

docker tag schema-registry-ui-nginx drivereu/schema-registry-ui-nginx:latest
docker push drivereu/schema-registry-ui-nginx:latest



**Environment** 

| Name               | Description                                                  |
| ------------------ | ------------------------------------------------------------ |
| SCHEMAREGISTRY_URL | Link to KAFKA schema registry (a proxy is used, so this server can run local (not accesable from internet)) |
| ALLOW_GLOBAL       | See https://github.com/lensesio/schema-registry-ui           |
| ALLOW_TRANSITIVE   | See https://github.com/lensesio/schema-registry-ui           |
| ALLOW_DELETION     | See https://github.com/lensesio/schema-registry-ui           |
| READONLY_MODE      | See https://github.com/lensesio/schema-registry-ui           |
| SCHEMA_URL         | Relative path used to get to proxy                           |
|                    |                                                              |


#!/bin/bash -e
# docker pull swaggerapi/swagger-ui
docker run -p 8080:8080 -e SWAGGER_YAML=api.yaml -v api.yaml:api.yaml swaggerapi/swagger-ui

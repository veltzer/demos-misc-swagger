#!/bin/bash -e
# docker pull swaggerapi/swagger-ui
docker run -p 8080:8080 -e SWAGGER_YAML=/api/api//api.yaml -v "${PWD}:/api" swaggerapi/swagger-ui

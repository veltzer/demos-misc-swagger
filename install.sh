#!/bin/bash -e
# This does not work because of libx11 dependency not being installable
# brew install swagger-codegen
VERSION="2.4.32"
mkdir downloads
wget "https://oss.sonatype.org/content/repositories/releases/io/swagger/swagger-codegen-cli/${VERSION}/swagger-codegen-cli-${VERSION}.jar" -O "downloads/swagger-codegen-cli.jar"

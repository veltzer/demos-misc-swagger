# TOFIX

Findings from a code scan on 2026-10-04.

## High

- `api.yaml:1` - the document has no `openapi:` version field (it was dropped when the Petstore spec replaced the original file in commit 6e924e3), so it is not a valid OpenAPI document and Swagger UI / codegen reject it. Restore `openapi: 3.0.3` (the Petstore 1.0.11 spec is 3.0.x) as the first key.
- `run_docker.sh:3` - the container is told to load `SWAGGER_YAML=/api/api//api.yaml`: `SWAGGER_YAML` is not a variable the `swaggerapi/swagger-ui` image reads (it reads `SWAGGER_JSON` for a file path, or `URL`), and the path is wrong anyway - with `-v "${PWD}:/api"` the file is `/api/api.yaml`. Use `-e SWAGGER_JSON=/api/api.yaml`, so the UI actually shows the repo's spec instead of the default Petstore.

## Medium

- `my.yaml:5`, `my.json` - `info.version` is the number `0.1`; OpenAPI requires a string. Quote it (`version: "0.1"`) and regenerate `my.json`.
- `install.sh:4-6` - downloads `swagger-codegen-cli` 2.4.32, which only understands Swagger/OpenAPI 2.0, while both specs in the repo are OpenAPI 3.0; and it fetches from `oss.sonatype.org/content/repositories/releases`, the OSSRH host Sonatype has retired. Download swagger-codegen 3.x (`io/swagger/codegen/v3/swagger-codegen-cli`) from `https://repo1.maven.org/maven2/`.
- `convert.sh:4` - `my.json` is a committed generated file produced by an undeclared external `yaml2json` binary, run by hand. Use rsconstruct's native `[processor.yaml2json]` over `my.yaml` so the JSON is a build output (and drop `my.json` from git and from `[processor.ijsonlint]`), or at least declare the tool.

## Low

- `brew_packages.txt:1` - lists `swagger-codegen`, but `install.sh:2-3` records that the brew install does not work and downloads the jar instead; nothing reads this file. Delete it.
- `convert.sh:6` - the trailing `# java -jar downloads.gi/swagger-codegen-cli.jar` note has nothing to do with converting YAML to JSON; move a real codegen invocation into its own script (e.g. `generate.sh`) or drop it.
- `my.json` - no trailing newline (fleet `.editorconfig` has `insert_final_newline = true`).
- `README.md` - generated from the fleet template with no `tera.snippets/main.md.tera`, so it says nothing about the scripts (`install.sh`, `convert.sh`, `run_docker.sh`) or the two specs; add the snippet rather than editing the template.

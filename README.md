To generate the site run `make html` and the site will be generated in the `output` directory.

If running within a CI/CD pipeline, use Docker- `make build` which in turn then runs `docker-compose run --rm python make html` per 3muskteers.io.
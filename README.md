# GitLab Serverless Runner

Powered by [Jets](https://github.com/tongueroo/jets)

## Features

- Register free runner for your project.
- Running jobs on AWS lambda.

## How to login to GitLab Serverless Runner

1. Access to the website
1. Login as GitLab user account

## How to setup serverless runner for your GitLab project

1. Login to GitLab Serverless Runner
1. Click "Create a new runner"
1. Enter the gitlab instance URL (e.g. https://gitlab.com)
1. Enter [a registration token](https://docs.gitlab.com/ee/ci/runners/#registering-a-specific-runner-with-a-project-registration-token)
1. Enter a description for the runner
1. Enter [runner tags](https://docs.gitlab.com/ee/ci/runners/#using-tags)
1. Choose Lambda Runtime (See https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html)

And your runner will automatically start requesting jobs.

## Serverles Runner Endpoints

- `GET /` ... Login page
- `POST /` ... Login
- `GET /runners` ... Show all runners
- `GET /runners/new` ... Runner creation page
- `POST /runners` ... Create a new runner
- `GET /runners/:runner_id` ... Show a runner detail
- `GET /runners/:runner_id/edit` ... Runner edit page
- `PUT /runners/:runner_id` ... Update a existing runner

## Runner Registration Endpoints (GitLab Rails side)

- `POST api/v4/runners` ... Registers a new Runner (requires: token)
- `DELETE api/v4/runners` ... Deletes a registered Runner (requires: token)

## Runner Job Fetch Endpoints (GitLab Rails side)

- `POST api/v4/jobs/request` ... Request a job (requires: token)
- `PUT api/v4/jobs/:id` ... Updates a job (requires: token, id)
- `PATCH api/v4/jobs/:id/trace` ... Appends a patch to the job trace (requires: id)
- `POST api/v4/jobs/:id/artifacts/authorize` ... Authorize artifacts uploading for job (requires: id)
- `POST api/v4/jobs/:id/artifacts` ... Upload artifacts for job (requires: id)
- `GET api/v4/jobs/:id/artifacts` ... Download the artifacts file for job (requires: id)

## Configuration

- MAX_REGISTABLE_RUNNER_COUNT ... The maximum registable runner counts per user

## Development

`docker run --rm --name gsr-postgres -p 5432:5432 -e POSTGRES_PASSWORD=mysecretpassword -v /tmp/gsr-postgres:/var/lib/postgresql/data postgres`

## Others

This README would normally document whatever steps are necessary to get the application up and running.

Things you might want to cover:

* Dependencies
* Configuration
* Database setup
* How to run the test suite
* Deployment instructions

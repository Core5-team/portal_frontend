# README

## Explore Hub – Static Portal Website (GCP)

This repository contains the static “Explore Hub” portal website and its deployment pipeline for Google Cloud Platform.
The site is hosted on Cloud Run, built through Cloud Build and packaged using a lightweight Nginx-based Docker image.

The Portal provides two external links to existing AWS-hosted environments.

### Project Overview

The application is a static HTML page served through Nginx. Deployment is automated using Cloud Build, which builds a Docker image and updates the Cloud Run service.

##### This repository includes:

- index.html – the static website
- Dockerfile – Nginx configuration with dynamic port injection for Cloud Run
- cloudbuild.yaml – CI/CD pipeline for building and deploying the container

### How Deployment Works

1. Cloud Build builds the Docker image.
2. The image is pushed to Artifact Registry.
3. Cloud Build deploys the new version to Cloud Run.
4. Cloud Run serves the static site publicly over HTTPS (via external Load Balancer configured in infra repo).

### Variables to Replace

In index.html, update:

- BIRDWATCHING_URL
- DOOR_SHOP_URL

These should point to the two AWS environments required by the project.

### Local Build (Optional)

`docker build -t explore-hub .`
`docker run -p 8080:8080 -e PORT=8080 explore-hub`

### Notes

Infrastructure such as DNS, Load Balancer, IAM, Cloud Run service and Artifact Registry is managed in the [separate IaC repository using Terraform](https://github.com/Core5-team/iac_gcp_portal).

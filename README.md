# Verbose Fortnight

[![CI Pipeline for Docker](https://github.com/juanballone/verbose-fortnight/actions/workflows/docker.yaml/badge.svg)](https://github.com/juanballone/verbose-fortnight/actions/workflows/docker.yaml)[![Terraform Plan and Apply](https://github.com/juanballone/verbose-fortnight/actions/workflows/terraform.yaml/badge.svg?branch=main&event=deployment_status)](https://github.com/juanballone/verbose-fortnight/actions/workflows/terraform.yaml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Overview

**Verbose Fortnight** is a simple DevOps Project. This repository contains the following key components:
 - a simple Hello World Node.js microservice
 - Terraform code to provision cloud resources
 - Kubernetes Manifests for the deployment of the containerised microservice

## Table of Contents

- [Overview](#overview)
- [Getting Started](#getting-started)
- [Features](#features)
- [Directory Structure](#directory-structure)
- [Contributing](#contributing)
- [License](#license)

## Getting Started

Follow these steps to set up the project locally:

### Prerequisites

To contribute to this project these are the minimum tools required:

- [Terraform](https://www.terraform.io/downloads.html) version `>= 1.9.5`
- Node.js version `>= v20.4.0`
- Docker version `27.3.1`
- [Cloud Prerequisites for Azure Deployment.md](docs/Cloud%20Prerequisites%20for%20Azure%20Deployment.md)
- pre-commit `3.8.0`

## Directory Structure

```plaintext
verbose-fortnight/
├── .github/                # GitHub-specific configurations
│   ├── workflows/          # CI/CD workflows
│   └── CODEOWNERS          # Code owners file
├── clusters                #
│   └── manifests           # Flux Path
│       └── application     # Microservice application deployment files
├── docs/                   # Further Documentation
├── terraform/              # Terraform configurations
├── src/                    # Application source code
├── .pre-commit-config.yaml # Pre-commit hooks configuration
├── README.md               # Project documentation
└── LICENSE                 # License information
```

## Directory Descriptions

This repository is organized into the following key directories. Each directory contains its own README.md file with detailed information:

src Directory:
Contains the source code for the application, including the main logic and configuration files. See the [README.md](src/README.md) file for detailed information about the code structure and components.

terraform Directory:
Houses the Terraform configuration files used to provision and manage infrastructure resources. Refer to the [README.md](terraform/README.md) file for instructions on setting up and using the Terraform configurations.

clusters Directory:
Includes Kubernetes manifests and configuration files for managing application deployments within the cluster.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

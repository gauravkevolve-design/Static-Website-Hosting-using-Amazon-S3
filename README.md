# Static Website Hosting using Amazon S3

A complete AWS static website hosting project using **Amazon S3, Amazon CloudFront, Terraform, and GitHub Actions**.

## Architecture

```text
Users
  |
  v
Amazon CloudFront
  |
  v
Amazon S3 Static Website
  |
  +--> index.html
  +--> error.html
```

## AWS services

- Amazon S3 — static website origin and object storage
- Amazon CloudFront — CDN and HTTPS viewer redirection
- AWS IAM — access control through the S3 bucket policy
- Terraform — Infrastructure as Code
- GitHub Actions — Terraform formatting and validation

## Features

- S3 static website hosting
- `index.html` and `error.html` configuration
- Public `s3:GetObject` access for the website origin
- CloudFront distribution in front of the S3 website endpoint
- HTTP-to-HTTPS redirection at CloudFront
- Parameterized AWS region and globally unique bucket name
- Terraform outputs for the CloudFront URL
- Git-safe project structure with state and local variables excluded

## Project structure

```text
.
├── .github/
│   └── workflows/
│       └── terraform.yml
├── website/
│   ├── index.html
│   └── error.html
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
├── versions.tf
├── terraform.tfvars.example
├── .gitignore
├── ATTRIBUTION.md
└── LICENSE
```

## Prerequisites

- AWS account
- AWS CLI configured with credentials
- Terraform >= 1.6
- A globally unique S3 bucket name

## Deploy

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

After deployment:

```bash
terraform output -raw cloudfront_url
```

Open the returned CloudFront domain in a browser.

## Uploading website files

Infrastructure provisioning and website-content deployment are kept separate. After the bucket is created, upload the files with AWS CLI using the bucket name from your configuration:

```bash
aws s3 sync ./website s3://YOUR_BUCKET_NAME --delete
```

Then refresh the CloudFront distribution as needed after content changes.

## Destroy

```bash
terraform destroy
```

## Security notes

- Never commit `terraform.tfstate`, `.terraform/`, or `terraform.tfvars`.
- The example uses the S3 **website endpoint** as the CloudFront origin because this project demonstrates S3 static website hosting.
- For a production private-origin architecture, use CloudFront Origin Access Control with the S3 REST endpoint rather than the website endpoint.
- Do not place AWS access keys or secrets in Terraform files.

## Production extensions

Possible next improvements include Route 53 custom DNS, ACM certificates, CloudFront response headers policies, versioning, access logging, S3 lifecycle rules, CI/CD deployment of website content, and private S3 origin access through CloudFront.

## Attribution

This repository was built using public S3 static website hosting projects as reference material. See `ATTRIBUTION.md` for the referenced public repository and license details.

## Author

Gaurav Kumar — AWS / Cloud / DevOps portfolio project.

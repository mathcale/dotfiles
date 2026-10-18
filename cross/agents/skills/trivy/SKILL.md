---
name: trivy
description: "Container image and filesystem vulnerability scanning with Trivy. Use when: container security, Docker image scan, filesystem scan, misconfiguration detection, Dockerfile audit, image vulnerabilities, SBOM, license compliance"
---

# Container & Filesystem Vulnerability Scanning with Trivy

Run `trivy` to scan Docker images, project filesystem, and IaC configurations for vulnerabilities and misconfigurations.

## When to Use

- Scanning Docker images for OS/library vulnerabilities
- Auditing Dockerfiles for misconfigurations
- Filesystem scan for secrets, licenses, or vulnerable libraries
- Checking IaC (Docker Compose) for security issues
- Generating SBOM (Software Bill of Materials)

## Prerequisites

```bash
which trivy || echo "Install trivy: apt install trivy / brew install trivy"
```

## Procedure

### 1. Scan the Docker Image

Build and scan the production image:

```bash
docker build -f Dockerfile -t app:audit .
trivy image --severity HIGH,CRITICAL app:audit
```

For full detail (all severities + JSON output):

```bash
trivy image --format json --output /tmp/trivy-image.json app:audit
```

### 2. Scan the Project Filesystem

Check for vulnerabilities in Go dependencies without building:

```bash
trivy fs --severity HIGH,CRITICAL .
```

This scans `go.mod` / `go.sum` and reports known CVEs — complementary to `govulncheck` since Trivy uses a broader vulnerability database.

### 3. Dockerfile Misconfiguration Check

```bash
trivy config --severity HIGH,CRITICAL .
```

Key checks:
- Running as root inside container
- Using `latest` tag for base images
- Missing `HEALTHCHECK`
- Exposed unnecessary ports
- Secrets in build args or environment
- Missing `USER` directive

### 4. Scan Docker Compose Configuration

```bash
trivy config --file-patterns "docker-compose*" .
```

### 5. Secret Detection

Scan for accidentally committed secrets:

```bash
trivy fs --scanners secret .
```

Looks for: API keys, tokens, passwords, private keys, cloud credentials.

### 6. Generate SBOM (optional)

```bash
trivy image --format spdx-json --output /tmp/sbom.json app:audit
```

## Analysis Checklist

| Check | Expected | Severity if Failed |
|-------|----------|-------------------|
| No CRITICAL CVEs in base image | Yes | CRITICAL |
| No HIGH CVEs in Go deps | Yes | HIGH |
| Container runs as non-root | Yes | HIGH |
| No secrets in image layers | Yes | CRITICAL |
| Base image pinned (not `latest`) | Yes | MEDIUM |
| Multi-stage build (no build tools in final) | Yes | MEDIUM |
| `HEALTHCHECK` defined | Yes | LOW |
| No unnecessary packages in final image | Yes | LOW |

## Common Findings for Go Projects

- **Alpine CVEs**: Base image has unpatched OS-level vulnerabilities → update base image
- **Running as root**: Missing `USER` directive in Dockerfile → add non-root user
- **Build tools in production image**: Single-stage build includes Go compiler → use multi-stage
- **go.sum mismatches**: Dependencies with known vulnerabilities → `go get -u`

## Cleanup

```bash
rm -f /tmp/trivy-image.json /tmp/sbom.json
docker rmi app:audit 2>/dev/null
```

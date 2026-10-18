---
name: govulncheck
description: "Scan Go dependencies for known vulnerabilities using govulncheck. Use when: dependency audit, CVE check, go.mod security, vulnerable packages, supply chain security, dependency vulnerabilities"
---

# Go Dependency Vulnerability Scan

Scan the project's Go dependencies for known vulnerabilities using `govulncheck` (official Go vulnerability database).

## When to Use

- Checking dependencies for known CVEs
- Auditing `go.mod` / `go.sum` for vulnerable packages
- Supply-chain security review
- Before deploying a new release

## Prerequisites

Install if not present:

```bash
go install golang.org/x/vuln/cmd/govulncheck@latest
```

## Procedure

1. **Verify installation**: Run `which govulncheck || go install golang.org/x/vuln/cmd/govulncheck@latest`
2. **Run source-level analysis** (most accurate — traces call paths):
   ```bash
   govulncheck ./...
   ```
3. **Run binary analysis** if a compiled binary exists:
   ```bash
   govulncheck -mode=binary ./bin/api
   ```
4. **Parse output** and classify findings by severity
5. **For each vulnerability found**:
   - Note the CVE ID and affected package/version
   - Check if the vulnerable function is actually called (govulncheck does this automatically)
   - Determine if an upgrade is available
   - Assess impact on PHI/patient data handling

## Output Interpretation

- **Called**: The vulnerable symbol is reachable from the code → **action required**
- **Imported**: Package is imported but vulnerable symbol not called → **review recommended**
- **Module**: Module is in `go.mod` but package not imported → **low priority**

## Remediation

For each finding, recommend:
1. The minimum version that fixes the vulnerability
2. Whether `go get -u <package>@<version>` is safe (check for breaking changes)
3. Any workarounds if upgrade isn't immediately possible

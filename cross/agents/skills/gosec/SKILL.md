---
name: gosec
description: "Static analysis security scanner for Go code using gosec. Use when: static analysis, code scan, security linting, hardcoded credentials, insecure crypto, SQL injection detection, XSS, path traversal, Go security patterns"
---

# Go Static Security Analysis with gosec

Run `gosec` (Go Security Checker) for static analysis of Go source code to find security vulnerabilities.

## When to Use

- Static code analysis for security flaws
- Checking for hardcoded credentials, weak crypto, SQL injection patterns
- Pre-commit or pre-deploy security gate
- Reviewing specific files or packages for vulnerabilities

## Prerequisites

Install if not present:

```bash
go install github.com/securego/gosec/v2/cmd/gosec@latest
```

## Procedure

1. **Verify installation**: Run `which gosec || go install github.com/securego/gosec/v2/cmd/gosec@latest`
2. **Full project scan**:
   ```bash
   gosec -fmt=json -out=gosec-results.json ./...
   ```
3. **Scan specific packages** (for targeted review):
   ```bash
   gosec ./internal/infra/web/...
   gosec ./internal/infra/database/...
   ```
4. **Human-readable output** for quick review:
   ```bash
   gosec -fmt=text ./...
   ```
5. **Parse results** and map to OWASP categories

## Key Rules to Watch

| Rule | Description | OWASP |
|------|-------------|-------|
| G101 | Hardcoded credentials | A02 |
| G201 | SQL string formatting | A03 |
| G202 | SQL string concatenation | A03 |
| G301-G307 | File permission issues | A01 |
| G401-G405 | Weak crypto (DES, MD5, SHA1) | A02 |
| G501-G505 | Blocklisted imports (crypto/md5, etc.) | A02 |
| G601 | Implicit memory aliasing in loops | Code quality |

## Filtering

- **Exclude rules**: `gosec -exclude=G104 ./...` (skip unchecked errors if noisy)
- **Exclude test files**: `gosec -exclude-dir=tests ./...`
- **Severity filter**: `gosec -severity=medium ./...`
- **Confidence filter**: `gosec -confidence=high ./...`

## Output Interpretation

Each finding has:
- **Severity**: HIGH / MEDIUM / LOW
- **Confidence**: HIGH / MEDIUM / LOW
- **CWE**: Common Weakness Enumeration ID
- **Location**: File and line number

Focus on HIGH severity + HIGH confidence findings first. Cross-reference with actual data flow to filter false positives.

## Cleanup

Remove generated report when done:

```bash
rm -f gosec-results.json
```

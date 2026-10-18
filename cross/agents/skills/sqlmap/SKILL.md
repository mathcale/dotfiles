---
name: sqlmap
description: "SQL injection testing with sqlmap against local dev environment. Use when: SQL injection testing, database exploitation, parameter tampering, blind SQL injection, UNION injection, authentication bypass testing"
---

# SQL Injection Testing with sqlmap

Run `sqlmap` to test API endpoints for SQL injection vulnerabilities against the **local development environment only**.

## When to Use

- Testing specific endpoints for SQL injection
- Validating that parameterized queries are properly implemented
- Verifying ORM-generated queries are injection-safe
- Testing authentication bypass via SQL injection

## Safety Rules

- **ONLY target `localhost:8080`** — never run against staging, production, or third-party systems
- **Ensure the local dev environment is running** (`make run` or `docker-compose up`)
- **Use `--batch` flag** to avoid interactive prompts that stall the agent
- **Use `--level=3 --risk=2`** as maximum — never use `--risk=3` (may corrupt data with UPDATE/DELETE)
- **Always use `--technique=BEUSTQ`** to test all injection types

## Prerequisites

Verify sqlmap is installed:

```bash
which sqlmap || echo "Install sqlmap: apt install sqlmap / brew install sqlmap"
```

## Procedure

### 1. Identify Target Endpoints

Read the route definitions to find endpoints that accept user input:

```bash
grep -rn "router\.\|Handle\|HandleFunc\|GET\|POST\|PUT\|DELETE\|PATCH" internal/infra/web/
```

### 2. Get a Valid Auth Token

If endpoints require authentication, obtain a JWT token first by calling the login endpoint:

```bash
curl -s -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@test.com","password":"test123"}' | jq -r '.token'
```

### 3. Test Endpoints

**GET endpoint with query parameters:**

```bash
sqlmap -u "http://localhost:8080/api/patients?id=1" \
  --headers="Authorization: Bearer <TOKEN>" \
  --batch --level=3 --risk=2 --technique=BEUSTQ \
  --dbms=PostgreSQL --threads=4 \
  --output-dir=/tmp/sqlmap-results
```

**POST endpoint with JSON body:**

```bash
sqlmap -u "http://localhost:8080/api/patients" \
  --method=POST \
  --headers="Authorization: Bearer <TOKEN>\nContent-Type: application/json" \
  --data='{"name":"test","email":"test@test.com"}' \
  --batch --level=3 --risk=2 --technique=BEUSTQ \
  --dbms=PostgreSQL --threads=4 \
  --output-dir=/tmp/sqlmap-results
```

**Test specific parameter:**

```bash
sqlmap -u "http://localhost:8080/api/patients?id=1" \
  -p "id" \
  --headers="Authorization: Bearer <TOKEN>" \
  --batch --level=3 --risk=2 \
  --dbms=PostgreSQL \
  --output-dir=/tmp/sqlmap-results
```

### 4. Analyze Results

- Check sqlmap output for discovered injection points
- For each finding: trace the parameter from handler → use case → repository to understand why it's vulnerable
- Verify: is it a true positive or false positive?

### 5. Targeted Deep Test

If a vulnerability is found, escalate testing:

```bash
sqlmap -u "http://localhost:8080/api/vulnerable-endpoint?param=1" \
  --headers="Authorization: Bearer <TOKEN>" \
  --batch --level=5 --risk=2 \
  --dbms=PostgreSQL \
  --tables --dump-all \
  --output-dir=/tmp/sqlmap-results
```

## Cleanup

```bash
rm -rf /tmp/sqlmap-results
```

## Output Interpretation

| sqlmap Result | Meaning | Severity |
|---------------|---------|----------|
| `Parameter 'X' is vulnerable` | Confirmed SQL injection | CRITICAL |
| `heuristic (basic) test shows parameter might be injectable` | Possible, needs manual review | HIGH |
| `all tested parameters do not appear to be injectable` | Likely safe (but check with --level=5) | INFO |

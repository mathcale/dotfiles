---
name: nmap
description: "Network scanning and service enumeration with nmap against local dev environment. Use when: port scanning, service discovery, network reconnaissance, open ports, TLS/SSL audit, service version detection, network security assessment"
---

# Network Scanning with nmap

Run `nmap` to discover open ports, service versions, and potential network-level vulnerabilities in the **local development environment only**.

## When to Use

- Discovering what ports/services are exposed by the application and its dependencies
- Auditing TLS/SSL configuration
- Checking for unnecessary exposed services (DB ports, debug endpoints)
- Verifying Docker network isolation

## Safety Rules

- **ONLY target `localhost` / `127.0.0.1`** — never scan external hosts, staging, or production
- **Use reasonable scan speeds** — `-T3` or `-T4` max
- **Do not use aggressive OS fingerprinting** against non-local targets

## Prerequisites

```bash
which nmap || echo "Install nmap: apt install nmap / brew install nmap"
```

## Procedure

### 1. Quick Service Discovery

Find all open ports on localhost:

```bash
nmap -sT -p- --min-rate=1000 -T4 localhost
```

### 2. Service Version Detection

Identify service versions on discovered ports:

```bash
nmap -sV -p 8080,5432 localhost
```

### 3. Check Docker-Exposed Ports

Verify which container ports are bound to the host:

```bash
docker ps --format "table {{.Names}}\t{{.Ports}}" 2>/dev/null
nmap -sT -p 5432,8080,6379 localhost
```

### 4. TLS/SSL Audit (if HTTPS is configured)

```bash
nmap --script ssl-enum-ciphers -p 443,8443 localhost
```

Key checks:
- No SSLv2/SSLv3/TLS 1.0/1.1
- No weak cipher suites (RC4, DES, 3DES)
- Forward secrecy support (ECDHE)

### 5. HTTP-Specific Scripts

```bash
nmap --script http-methods,http-headers,http-title -p 8080 localhost
```

Checks:
- Allowed HTTP methods (look for PUT, DELETE, TRACE if unexpected)
- Security headers (X-Frame-Options, Content-Security-Policy, etc.)
- Server banner information leakage

### 6. Database Port Exposure Check

Verify PostgreSQL isn't exposed beyond localhost:

```bash
nmap -sT -p 5432 localhost
nmap -sT -p 5432 0.0.0.0
```

If port 5432 is accessible on 0.0.0.0, the DB is exposed on all interfaces — flag as **HIGH** severity.

## Analysis Checklist

| Check | Expected | Severity if Failed |
|-------|----------|-------------------|
| App port (8080) open | Yes | — |
| DB port (5432) only on localhost | Yes | HIGH |
| No unexpected ports open | Yes | MEDIUM |
| TLS 1.2+ only (if HTTPS) | Yes | HIGH |
| No weak ciphers | Yes | MEDIUM |
| Security headers present | Yes | MEDIUM |
| Server version not leaked | Yes | LOW |
| Debug ports closed (pprof, etc.) | Yes | HIGH |

## Common Findings

- **PostgreSQL on 0.0.0.0**: Docker Compose `ports: "5432:5432"` exposes DB on all interfaces. Fix: use `"127.0.0.1:5432:5432"`
- **pprof / debug endpoints**: Go's `net/http/pprof` exposed in production
- **Missing security headers**: No HSTS, CSP, X-Frame-Options
- **Server banner leakage**: Response includes Go version or framework name

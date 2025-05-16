# Lacework FortiCNAPP – Demos & Use Cases

## 🧪 Demos & Use Cases

### Dashboard overview and search

### ☁️ Demo 1: Cloud Integration Setup
- Navigate to: `Settings → Cloud Accounts`
- Click **Add Cloud Account**
- Enable:
  - Agentless Workload Scanning
  - Configuration & Compliance Checks
  - CloudTrail-based Threat Detection
- Supports AWS, Azure, GCP — no agents required

### 🐳 Demo 2: Container Vulnerability Detection
- Navigate to: `Vulnerabilities → Containers`
- Click **Select All Images**, group by **Repo**
- Filter and analyze:
  - Critical CVEs
  - Unpatched packages
  - Runtime vs. build-time vulnerabilities
- CI/CD Integration:
  - GitHub Actions, GitLab, Jenkins, Azure DevOps, CircleCI, Bitbucket, etc.
  - Inline scanner auto-fails builds on critical CVEs
  - Enables “shift-left” security in development pipelines

### 📜 Demo 3: GenAI for Alert Triage
- Ask: _"What does this alert mean?"_
- Returns:
  - 🔍 Plain-language alert explanation
  - 🛠️ Recommended remediation
  - 📄 Summary ready for reporting or audit  

### ⚙️ Demo 4: Workload Runtime Threat Detection
- Navigate to: `Investigate → Workloads`
- Detect:
  - Suspicious runtime behavior
  - Lateral movement
  - Privilege escalation attempts
- Automatically correlated with Polygraph for high-confidence alerts

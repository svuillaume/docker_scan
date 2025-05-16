# Lacework FortiCNAPP – Demos & Use Cases

## 🧪 Demos & Use Cases

### 📜 Demo 1: Dashboard and Threat investigation Search (CWPP use case)

### ☁️ Demo 2: Cloud Integration Setup (CSPM use case)
- Navigate to: `Settings → Cloud Accounts`
- Click **Add Cloud Account**
- Enable:
  - Agentless Workload Scanning
  - Configuration & Compliance Checks
  - CloudTrail-based Threat Detection
- Supports AWS, Azure, GCP — no agents required

### 🐳 Demo 3: Container Vulnerability Detection (CSPM with vulnerability sanning)
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

### 📜 Demo 4: GenAI for Alert Triage
- Ask: _"What does this alert mean?"_
- Returns:
  - 🔍 Plain-language alert explanation
  - 🛠️ Recommended remediation
  - 📄 Summary ready for reporting or audit  


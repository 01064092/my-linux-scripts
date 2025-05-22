# 🐳 Docker & cURL Checker & Installer Script

This Bash script automates the process of:

- Detecting the system's package manager (`apt`, `dnf`, or `pacman`)
- Checking if `curl` and `docker` are available in your repositories
- Installing `curl` if missing
- Checking if Docker is installed and if the Docker **service is running**
- Installing Docker via the official Docker install script if not already installed

---

## 📁 Script File

- `docker_check.sh`

---

## 🚀 Usage

### 1. Make it executable
```bash
chmod +x docker_check.sh

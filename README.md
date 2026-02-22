# 🚀 Modular Dev-Ops Workspaces

This project provides a containerized, isolated development environment. Using Docker Profiles, you can launch a private browser, a VS Code IDE, or specific programming runtimes (Python/Go) individually or together.

**Privacy First:** You can now optionally route your workspace internet traffic through a containerized Tor proxy for enhanced anonymity, censorship circumvention, and IP masking. 


## 🛠 Prerequisites

Before starting, create a `.env` file in the root directory to store your credentials and system IDs. 

```bash
# Get these by running 'id' in your terminal
PUID="1000"
PGID="1000"
TZ="Europe/London"

# VS Code Security
VSCODE_PASSWORD="your_secure_password"
VSCODE_SUDO_PASSWORD="your_sudo_password"
VSCODE_DEFAULT_WORKSPACE="/config/workspace"
VSCODE_PWA_APPNAME="MyDevWorkstation"

# --- TOR PROXY SETTINGS ---
# To use Tor, leave these active. 
# To use standard direct internet, comment these out with a '#'
TOR_URL="http://172.20.0.5:8118"
TOR_SOCKS_URL="socks5://172.20.0.5:9050"

```

---

## 🏗 Available Workspaces

| Workspace | Profile Name | Access URL | Port |
| --- | --- | --- | --- |
| Tor Proxy | `torproxy` | Background Service | 8118 / 9050 |
| Firefox | `firefox` | http://127.0.0.1:3000 | 3000 |
| VS Code | `vscode` | http://127.0.0.1:8443 | 8443 |
| Python | `python` | http://127.0.0.1:5000 | 5000 |
| Go | `go` | http://127.0.0.1:5500 | 5500 |

---

## 🚀 How to Use

### 1. Standard Mode (Direct Internet)

If you want standard, un-proxied internet access, ensure the `TOR_URL` variables in your `.env` file are **commented out or empty**. Then, start your workspaces normally:

```bash
docker compose --profile vscode --profile firefox up -d

```

### 2. Privacy Mode (Routed Through Tor)

To mask your traffic, ensure the `TOR_URL` variables in your `.env` file are **active** (uncommented).

When starting your environment, you **must** include the `torproxy` profile so the network can establish a connection:

```bash
docker compose --profile torproxy --profile vscode --profile firefox up -d

```

*(Note: If you leave the variables active in your `.env` but forget to start the `torproxy` profile, your workspaces will not have internet access!)*

### 3. Stop a Workspace

This stops the container but keeps your data safe:

```bash
docker compose --profile go stop

```

### 4. Enter a Workspace Terminal

If you need to run commands inside the Python or Go containers:

```bash
docker exec -it python-workspace /bin/bash

```

---

## 📂 Shared Storage Strategy

All containers share the `./workspaces/download` directory.

* **Workflow Example:** Download a dataset or a `.go` file in the Firefox container, and it instantly appears in the `/downloads` folder of your VS Code and Go workspaces.

---

## 🌟 Benefits of this Setup

1. **Isolation:** Keep your host machine clean. No need to install Go, Python, or Java locally.
2. **Resource Management:** Using `deploy.resources.limits`, we ensure no single workspace can crash your entire computer by leaking memory.
3. **Consistency:** Your dev environment is exactly the same whether you are on Windows, Mac, or Linux.
4. **Security:** The `127.0.0.1` binding in the ports section ensures these services are only accessible from your local machine, not the open internet.
5. **Anonymity:** Built-in Tor routing protects your metadata and physical location during research or scraping tasks.

---

## ⚙️ Setup Git inside VS Code

Open the VS Code terminal inside the container and run:

```bash
# Setup git user and email
git config --global --add safe.directory /config/workspace/project_name
git config --global user.email "git-email@gmail.com"
git config --global user.name "Git User Name"

# Generate a New SSH Key
ssh-keygen -t ed25519 -C "your_email@example.com"
ls -al ~/.ssh

# Add Your SSH Key to the ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Add the Key to Your GitHub Account
cat ~/.ssh/id_ed25519.pub
# Add this key into your github ssh keys

# Test Your Connection
ssh -T git@github.com

```

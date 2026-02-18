# 🚀 Modular Dev-Ops Workspaces

This project provides a containerized, isolated development environment. Using Docker Profiles, you can launch a private browser, a VS Code IDE, or specific programming runtimes (Python/Go) individually or together.

## 🛠 Prerequisites

Before starting, create a `.env` file in the root directory to store your credentials and system IDs:

```bash
# Get these by running 'id' in your terminal
PUID=1000
PGID=1000
TZ=Europe/London

# VS Code Security
VSCODE_PASSWORD=your_secure_password
VSCODE_SUDO_PASSWORD=your_sudo_password
VSCODE_DEFAULT_WORKSPACE=/config/workspace
VSCODE_PWA_APPNAME=MyDevWorkstation
```

---

## 🏗 Available Workspaces

| Workspace | Profile Name | Access URL | Port |
| :--- | :--- | :--- | :--- |
| Firefox | firefox | http://127.0.0.1:3000 | 3000 |
| VS Code | vscode | http://127.0.0.1:8443 | 8443 |
| Python | python | http://127.0.0.1:5000 | 5000 |
| Go | go | http://127.0.0.1:5500 | 5000 |

---

## 🚀 How to Use

### 1. Start a Specific Workspace

To start only the Firefox browser:

```bash
docker compose --profile firefox up -d
```

To start your coding environment (VS Code + Python):

```bash
docker compose --profile vscode --profile python up -d
```

### 2. Stop a Workspace

This stops the container but keeps your data safe:

```bash
docker compose --profile go stop
```

### 3. Enter a Workspace Terminal

If you need to run commands inside the Python or Go containers:

```bash
docker exec -it python-workspace /bin/bash
```

---

## 📂 Shared Storage Strategy

All containers share the `./workspaces/download` directory.

* <b>Workflow Example:</b> Download a dataset or a `.go` file in the Firefox container, and it instantly appears in the `/downloads` folder of your VS Code and Go workspaces.

---

## 🌟 Benefits of this Setup

1. <b>Isolation:</b> Keep your host machine clean. No need to install Go, Python, or Java locally.

2. <b>Resource Management:</b> Using deploy.resources.limits, we ensure no single workspace can crash your entire computer by leaking memory.

3. <b>Consistency:</b> Your dev environment is exactly the same whether you are on Windows, Mac, or Linux.

4. <b>Security:</b> The 127.0.0.1 binding in the ports section ensures these services are only accessible from your local machine, not the open internet.

---

# Setup git inside vscode

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
# Add this key into your github sshkeys

# Test Your Connection
ssh -T git@github.com
```

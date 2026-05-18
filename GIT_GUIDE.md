# 🎮 CSAGame Git Collaboration Guide

Welcome to the **CSAGame** repository! This guide is designed to help team members collaborate smoothly using Git and GitHub. Following these practices will keep our codebase clean, prevent lost work, and minimize merge conflicts.

---

## 🛠️ 1. Prerequisites & Initial Setup

Before contributing, make sure you have Git installed and configured on your machine.

### Installing Git
- **Windows**: Download and install [Git for Windows](https://gitforwindows.org/) (includes Git Bash).
- **macOS**: Install via Homebrew (`brew install git`) or run `git --version` in terminal to install Xcode Command Line Tools.
- **Linux**: Run `sudo apt install git` (Ubuntu/Debian) or `sudo dnf install git` (Fedora).

### Configuring Your Identity
Open your terminal or Git Bash and set your name and email (this appears on your commits):
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

> [!TIP]
> Make sure the email matches your GitHub account email so your commits are correctly linked to your profile!

---

## 🚀 2. Getting Started: Cloning the Repository

To get a local copy of the code on your computer, clone the repository:

```bash
# Using SSH (Recommended if you have SSH keys set up)
git clone git@github.com:samuellance73/CSAGame.git

# Or using HTTPS
git clone https://github.com/samuellance73/CSAGame.git
```

Once cloned, navigate into the project folder:
```bash
cd CSAGame
```

---

## 🔄 3. The Team Workflow (Feature Branching)

> [!IMPORTANT]  
> **Never commit directly to the `main` branch!** Always work on a dedicated branch for your specific feature, bug fix, or task. This ensures `main` always contains working, stable code.

### Step 1: Ensure your local `main` is up to date
Before starting new work, always pull the latest changes from GitHub:
```bash
git checkout main
git pull origin main
```

### Step 2: Create a new branch for your feature
Give your branch a descriptive name so teammates know what you're working on:
```bash
git checkout -b feature/player-movement
```
*(Common prefixes: `feature/`, `bugfix/`, `docs/`, `refactor/`)*

### Step 3: Make changes & test locally
Write your code, add assets, or update documentation. Make sure to run and test the project locally to confirm everything works properly.

### Step 4: Check status & stage your changes
To see which files you've modified:
```bash
git status
```

Stage the files you want to include in your commit:
```bash
# To stage specific files:
git add src/Player.java

# To stage all modified files:
git add .
```

### Step 5: Commit your changes
Write a clear, concise commit message describing what you changed:
```bash
git commit -m "Add WASD movement controls to Player class"
```

> [!NOTE]  
> Keep commits relatively small and focused. If you worked on two completely different features, make separate commits for each!

### Step 6: Push your branch to GitHub
When you're ready to share your work or get feedback, push your branch to the remote repository:
```bash
# The '-u' flag links your local branch to the remote branch on GitHub
git push -u origin feature/player-movement
```
For future pushes on this branch, you can simply run `git push`.

### Step 7: Open a Pull Request (PR)
1. Go to the [CSAGame GitHub Repository](https://github.com/samuellance73/CSAGame).
2. You'll see a yellow banner prompt: "Compare & pull request". Click it!
3. Give your PR a title and brief description of the changes.
4. Request a review from your teammates. Once approved, click **Merge pull request** to combine your changes into `main`.

---

## ⚡ 4. Handling Merge Conflicts & Syncing

### Keeping Your Branch Updated
If other teammates have merged changes into `main` while you were working on your branch, update your branch to avoid conflicts later:
```bash
git fetch origin
git merge origin/main
```

### Resolving Merge Conflicts
If Git tells you there is a merge conflict, don't panic! It just means two people edited the exact same lines of code.

1. Open the conflicting file in your code editor (like VS Code or IntelliJ).
2. Look for conflict markers:
```text
<<<<<<< HEAD
int playerSpeed = 10;
=======
int playerSpeed = 15;
>>>>>>> origin/main
```
3. Decide which code to keep, delete the markers (`<<<<<<<`, `=======`, `>>>>>>>`), and save the file.
4. Stage and commit the resolved files:
```bash
git add .
git commit -m "Resolve merge conflicts in Player.java"
```

---

## 📋 5. Git Cheat Sheet

| Command | What it does |
| :--- | :--- |
| `git status` | Shows current branch and modified/staged files |
| `git pull origin main` | Downloads and merges the latest changes from GitHub's main branch |
| `git branch` | Lists all local branches (highlighting your active branch) |
| `git checkout -b <name>` | Creates a new branch and instantly switches to it |
| `git checkout <branch>` | Switches to an existing branch |
| `git add .` | Stages all modified and new files for the next commit |
| `git commit -m "<msg>"` | Saves staged changes locally with a descriptive message |
| `git push` | Uploads your local commits to GitHub |
| `git log --oneline` | Displays a compact history of recent commits |

# GitHub Setup Guide - Togetzr Support

## Current Status
✅ Git installed (PortableGit)  
✅ Git configured (Togetzr / fkassab@togetzr.com)  
❌ Repository not initialized  
❌ No GitHub remote configured  

## Step-by-Step Setup

### Step 1: Create GitHub Repository

1. Go to https://github.com/new
2. Repository name: `togetzr-support` (or any name you prefer)
3. Description: "Togetzr Support - Custom RustDesk Build"
4. Visibility: **Public** (required for free GitHub Actions)
5. **DO NOT** initialize with README, .gitignore, or license
6. Click "Create repository"

### Step 2: Copy Repository URL
After creating, GitHub will show you the URL. It will look like:
```
https://github.com/YOUR_USERNAME/togetzr-support.git
```
**Copy this URL** - you'll need it in Step 4.

### Step 3: Initialize Local Repository

Run these commands in PowerShell (from `rustdesk-master` directory):

```powershell
cd C:\Users\kassa\OneDrive\Desktop\AI\rustdesk-master
$env:PATH = "C:\PortableGit\app\bin;" + $env:PATH

# Initialize git repository
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: Togetzr Support rebranding with MSI support"
```

### Step 4: Connect to GitHub

Replace `YOUR_REPO_URL` with the URL from Step 2:

```powershell
# Add GitHub remote (replace with your actual URL)
git remote add origin https://github.com/YOUR_USERNAME/togetzr-support.git

# Verify remote
git remote -v
```

### Step 5: Push to GitHub

```powershell
# Push to GitHub (will prompt for credentials)
git branch -M main
git push -u origin main
```

**Authentication Options:**

**Option A: Personal Access Token (Recommended)**
1. Go to https://github.com/settings/tokens
2. Click "Generate new token" → "Generate new token (classic)"
3. Name: "Togetzr Support Build"
4. Expiration: 90 days (or No expiration)
5. Scopes: Check `repo` (full control)
6. Click "Generate token"
7. **Copy the token** (you won't see it again!)
8. When `git push` asks for password, paste the token instead

**Option B: GitHub Desktop**
- Download GitHub Desktop: https://desktop.github.com/
- Sign in with your GitHub account
- Add repository → Existing repository → Select `rustdesk-master`
- Click "Publish repository"

### Step 6: Verify GitHub Actions

After pushing:
1. Go to your GitHub repository
2. Click "Actions" tab
3. You should see "Build the flutter version of the RustDesk" workflow
4. Click "Run workflow" → Select "main" branch → "Run workflow"
5. Monitor the build progress (~45 minutes)

## Quick Command Reference

```powershell
# Set PATH for this session
$env:PATH = "C:\PortableGit\app\bin;" + $env:PATH

# Navigate to project
cd C:\Users\kassa\OneDrive\Desktop\AI\rustdesk-master

# Initialize and push (after creating GitHub repo)
git init
git add .
git commit -m "Initial commit: Togetzr Support"
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
git branch -M main
git push -u origin main
```

## Troubleshooting

**"Repository not found"**
- Check repository URL is correct
- Verify repository is public (or you have access)

**"Authentication failed"**
- Use Personal Access Token instead of password
- Token must have `repo` scope

**"Git not found"**
- Add PortableGit to PATH: `$env:PATH = "C:\PortableGit\app\bin;" + $env:PATH`

## After Successful Push

✅ Repository will be on GitHub  
✅ GitHub Actions will be available  
✅ MSI build will trigger automatically  
✅ Download MSI from Actions artifacts after build completes  


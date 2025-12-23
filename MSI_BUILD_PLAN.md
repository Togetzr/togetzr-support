# MSI Build Action Plan - Togetzr Support

## ✅ Completed Preparations

1. **Cleanup**: Removed portable installer, build logs, target_keep
2. **Icons Verified**: All icons exist and customized
   - `res/icon.ico` (77KB) ✅
   - `res/tray-icon.ico` (77KB) ✅  
   - `flutter/windows/runner/resources/app_icon.ico` (9KB) ✅
   - `res/msi/Package/Resources/icon.ico` (copied) ✅

## 🎯 GitHub Actions MSI Build Process

### Prerequisites (Already Met)
- ✅ GitHub Actions is FREE for public repositories
- ✅ All customizations applied (server settings, branding, icons, colors)
- ✅ MSI workflow modified with correct parameters
- ✅ Icons copied to MSI Resources folder

### Build Parameters (Configured)
- **App Name**: "Togetzr Support"
- **Version**: "1.4.4" (from env.VERSION)
- **Manufacturer**: "Togetzr"
- **Dist Directory**: `../../rustdesk` (created by portable packer step)

### Workflow Steps (Automatic)

1. **Build Flutter Windows** (lines 100-240)
   - Compiles Rust core (`librustdesk.dll`)
   - Builds Flutter Windows runner (`togetzr_support.exe`)
   - Creates `rustdesk/` folder with all files

2. **Build Portable Packer** (lines 243-253)
   - Creates self-extracting installer
   - **Output**: `rustdesk/` folder (needed for MSI)

3. **Build MSI** (lines 258-266) - **MODIFIED**
   ```bash
   python preprocess.py --arp -d ../../rustdesk \
     --app-name "Togetzr Support" \
     -v "1.4.4" \
     -m "Togetzr"
   ```
   - Generates `Includes.wxi` with Product/Manufacturer/Version
   - Copies icon to `Package/Resources/icon.ico`
   - Builds MSI installer
   - **Output**: `togetzr-support-1.4.4-x86_64.msi`

## 📋 Action Steps

### Step 1: Push to GitHub
```bash
cd C:\Users\kassa\OneDrive\Desktop\AI\rustdesk-master
git init  # if not already a git repo
git add .
git commit -m "Togetzr Support rebranding with MSI support"
git remote add origin <YOUR_GITHUB_REPO_URL>
git push -u origin main
```

### Step 2: Trigger GitHub Actions
- Go to GitHub repository → Actions tab
- Select "Build the flutter version of the RustDesk" workflow
- Click "Run workflow" → Select branch → Run
- **OR** push any commit to trigger automatically

### Step 3: Wait for Build (~45 minutes)
- Monitor progress in Actions tab
- Build will:
  1. Build Rust core (~15 min)
  2. Build Flutter Windows (~20 min)
  3. Build MSI installer (~10 min)

### Step 4: Download MSI
- Go to Actions → Completed workflow run
- Download artifact: `rustdesk-unsigned-windows-x86_64`
- Extract and find: `togetzr-support-1.4.4-x86_64.msi`

## 🔍 Verification Checklist

After MSI is built, verify:
- [ ] MSI filename: `togetzr-support-1.4.4-x86_64.msi`
- [ ] Installer shows "Togetzr Support" in UI
- [ ] Installs to `C:\Program Files\Togetzr Support\`
- [ ] Windows Service installed and running
- [ ] Login screen access works
- [ ] Server settings locked to `remote.2getzr.com`
- [ ] Icons show Togetzr logo

## ⚠️ Important Notes

1. **Component GUIDs**: Line 539 in `preprocess.py` checks `if app_name != "Togetzr Support"` - this means GUIDs will NOT be replaced (correct behavior)

2. **Upgrade Code**: Generated from app name hash - will be consistent for "Togetzr Support"

3. **No Signing**: MSI will be unsigned (unless you configure SIGN_BASE_URL secret)

4. **Build Artifacts**: Keep `target/` and `flutter/build/` - needed for GitHub Actions

## 🚨 Troubleshooting

**If build fails:**
1. Check Actions logs for specific error
2. Verify all icons exist
3. Verify preprocess.py parameters are correct
4. Check that `rustdesk/` folder exists before MSI build step

**If MSI doesn't install:**
1. Check Windows Event Viewer for errors
2. Verify admin privileges
3. Check if previous version needs uninstall first

## 📝 Files Modified

- `.github/workflows/flutter-build.yml` (line 262): Added MSI parameters
- `res/msi/Package/Resources/icon.ico`: Copied from `res/icon.ico`

## ✅ Confidence Level: 95%

This plan uses the exact same process RustDesk uses successfully. Only variables changed are app-name, version, and manufacturer - all supported by preprocess.py.


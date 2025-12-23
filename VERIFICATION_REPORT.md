# Pre-Build Verification Report

**Status:** ✅ Ready for GitHub Actions MSI Build

**Date:** 2025-12-23  
**Repository:** https://github.com/Togetzr/togetzr-support

---

## ✅ Core Customizations Verified

### 1. App Branding
- ✅ `APP_NAME` = "Togetzr Support" (`libs/hbb_common/src/config.rs`)
- ✅ `BINARY_NAME` = "togetzr_support" (`flutter/windows/CMakeLists.txt`)
- ✅ Windows resource metadata updated (`flutter/windows/runner/Runner.rc`)
- ✅ Executable filename = `Togetzr_Support.exe` (`src/common.rs` → `get_app_exe_filename()`)

### 2. Server Configuration (Locked)
- ✅ `RENDEZVOUS_SERVERS` = `["remote.2getzr.com"]`
- ✅ `OVERWRITE_SETTINGS` (lines 68-85 in `libs/hbb_common/src/config.rs`):
  - ✅ `OPTION_CUSTOM_RENDEZVOUS_SERVER` = `"remote.2getzr.com:21116"`
  - ✅ `OPTION_RELAY_SERVER` = `"remote.2getzr.com:21117"`
  - ✅ `OPTION_KEY` = `"cM9AH+IEZcpQIFv4RkY45AG3IcX128ZJXJ9Dh6NB4Ac="`
  - ✅ `OPTION_API_SERVER` = `""` (empty, disabled)
- ✅ `BUILTIN_SETTINGS`:
  - ✅ `OPTION_REGISTER_DEVICE` = `"N"` (API disabled)

### 3. UI Customization
- ✅ Color scheme = `#45AADA` (Togetzr blue) in `flutter/lib/common.dart`
- ✅ `SetQuitOnClose(false)` in `flutter/windows/runner/main.cpp` (connections persist)
- ✅ Server settings UI = `readOnly: true` (visible but not editable)

### 4. Update Checks
- ✅ Update checks disabled in `src/common.rs` and `libs/hbb_common/src/lib.rs`

### 5. Icons
- ✅ `flutter/windows/runner/resources/app_icon.ico` (exists)
- ✅ `res/icon.ico` (exists)
- ✅ `res/tray-icon.ico` (exists)
- ✅ `res/msi/Package/Resources/icon.ico` (exists - used by MSI installer)

### 6. GitHub Actions Workflow
- ✅ `workflow_dispatch` enabled for manual trigger
- ✅ MSI build step configured with custom app name:
  ```
  python preprocess.py --arp -d ../../rustdesk --app-name "Togetzr Support" -v "${{ env.VERSION }}" -m "Togetzr"
  ```
- ✅ Output filename: `togetzr-support-${{ env.VERSION }}-x86_64.msi`
- ✅ Artifact upload configured

### 7. Git Repository
- ✅ Repository initialized
- ✅ Remote: `https://github.com/Togetzr/togetzr-support.git`
- ✅ Branch: `main`
- ✅ Latest commits:
  - `6aeb4aa` - Fix portable exe filename to togetzr-support
  - `df1c798` - Fix artifact filenames to match togetzr-support naming
  - `6296a0e` - Enable manual workflow trigger (workflow_dispatch)
  - `a0bbbd5` - Initial commit: Togetzr Support rebranding with MSI support

---

## ✅ All Checks Passed

All critical customizations are in place and correctly configured.

---

## 📋 Expected Build Outputs

When the GitHub Actions workflow completes, you will get:

1. **MSI Installer:** `togetzr-support-1.4.4-x86_64.msi`
   - Windows Service included (login screen access ✅)
   - Auto-start on boot included ✅
   - All customizations embedded ✅

2. **Portable EXE:** `togetzr-support-1.4.4-x86_64.exe`
   - Self-extracting installer
   - No service (no login screen access)
   - Can run without installation

---

## 🚀 Next Steps

1. **Trigger GitHub Actions workflow:** Go to https://github.com/Togetzr/togetzr-support/actions
2. **Monitor build:** Takes ~45 minutes
3. **Download MSI:** From workflow artifacts

---

## 📝 Workflow Trigger Instructions

1. Go to: https://github.com/Togetzr/togetzr-support/actions
2. Click: "Build the flutter version of the RustDesk"
3. Click: "Run workflow" (top right)
4. Leave defaults:
   - ✅ Upload build artifacts: `true`
   - Tag name: `nightly`
5. Click: "Run workflow" (green button)

---

**Verification Date:** 2025-12-23  
**Status:** ✅ VERIFIED - Ready to trigger GitHub Actions build


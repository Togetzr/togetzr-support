# Deep Review: Windows MSI Build Failure Analysis

## Root Cause Identified

### Issue 1: Executable Name Mismatch (CRITICAL) ✅ FIXED
**Location:** Line 265 in `.github/workflows/flutter-build.yml`

**Problem:**
- Portable packer references: `../../rustdesk/rustdesk.exe`
- Actual executable built: `togetzr_support.exe` (from CMakeLists.txt)
- **Status:** ✅ Fixed in commit `0d5d683`

### Issue 2: MSI Preprocess Script Executable Detection (POTENTIAL ISSUE)
**Location:** `res/msi/preprocess.py` lines 120, 456

**Problem:**
- MSI script receives `--app-name "Togetzr Support"` (with space)
- Script looks for: `Togetzr Support.exe` (line 456: `dist_app = dist_dir.joinpath(app_name + ".exe")`)
- Actual executable: `togetzr_support.exe` (with underscore, no space)
- Script skips main executable in component list (line 120-121)

**Impact:**
- MSI build may fail when trying to read version from `Togetzr Support.exe` (doesn't exist)
- Main executable may not be included in MSI package

**Solution Options:**
1. **Option A:** Rename executable after build to match app-name
2. **Option B:** Modify MSI script to find executable by pattern (find first .exe)
3. **Option C:** Use underscore in app-name parameter: `--app-name "Togetzr_Support"`

**Recommended:** Option A - Add rename step before MSI build

---

## Workflow Configuration Review

### ✅ Correctly Configured:
1. **Environment Variables:**
   - `UPLOAD_ARTIFACT` uses `inputs.upload-artifact || 'true'` ✅
   - `TAG_NAME` uses `inputs.upload-tag || 'nightly'` ✅

2. **Job-level Conditions:**
   - All use `inputs.upload-artifact != false` ✅
   - Step-level conditions use `env.UPLOAD_ARTIFACT == 'true'` ✅

3. **MSI Build Step:**
   - Correct app-name: `"Togetzr Support"` ✅
   - Correct manufacturer: `"Togetzr"` ✅
   - Correct output filename: `togetzr-support-*.msi` ✅

### ⚠️ Potential Issues:

1. **Executable Name Mismatch in MSI Script:**
   - MSI script expects `Togetzr Support.exe`
   - Actual file is `togetzr_support.exe`
   - **Action Required:** Add rename step or modify script

2. **Portable Packer Executable Reference:**
   - ✅ Fixed: Now references `togetzr_support.exe`

---

## Recommended Fix

Add a step before MSI build to rename the executable:

```yaml
- name: Rename executable for MSI
  if: env.UPLOAD_ARTIFACT == 'true'
  run: |
    if (Test-Path ./rustdesk/togetzr_support.exe) {
      Copy-Item ./rustdesk/togetzr_support.exe ./rustdesk/"Togetzr Support.exe"
    }
```

**OR** modify the MSI preprocess script to find the executable dynamically.

---

## Next Steps

1. ✅ Fix portable packer executable reference (DONE)
2. ⚠️ Fix MSI executable name mismatch (REQUIRED)
3. Test workflow run
4. Verify MSI contains correct executable

---

**Review Date:** 2025-12-23  
**Status:** Critical issue identified, fix required before next build


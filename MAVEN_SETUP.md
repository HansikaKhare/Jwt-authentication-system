# 🛠️ Maven Setup Guide - Quick Instructions

## Step 1: Extract Maven

You've downloaded Maven, now you need to extract it:

### If you downloaded a ZIP file:
1. Find the downloaded file (usually in Downloads folder)
   - File name: `apache-maven-3.9.x-bin.zip`

2. **Extract** the ZIP file to one of these locations:
   - **Recommended:** `C:\Program Files\Apache\maven`
   - **Alternative:** `C:\apache-maven`
   - **Or:** Your user folder `C:\Users\91983\apache-maven`

3. After extraction, you should have a folder with:
   ```
   apache-maven-3.9.x/
   ├── bin/
   │   ├── mvn.cmd
   │   ├── mvn.bat
   │   └── ...
   ├── boot/
   ├── conf/
   ├── lib/
   └── ...
   ```

## Step 2: Add Maven to PATH

### Method 1: Using System Settings (Recommended)

1. **Open Environment Variables:**
   - Press `Windows + R`
   - Type: `sysdm.cpl`
   - Click "Advanced" tab
   - Click "Environment Variables..." button

   **OR**
   
   - Search "environment variables" in Windows search
   - Select "Edit the system environment variables"

2. **Add to PATH:**
   - Under "System variables" (bottom section)
   - Find and select the `Path` variable
   - Click "Edit..."
   - Click "New"
   - Add: `C:\Program Files\Apache\maven\bin`
     (or wherever you extracted Maven)
   - Click "OK" on all windows

3. **Restart PowerShell/Terminal:**
   - Close ALL open terminal windows
   - Open a NEW terminal window
   - The PATH change will take effect

### Method 2: Quick Command (Administrator Required)

Run PowerShell as Administrator and execute:

```powershell
$MavenPath = "C:\Program Files\Apache\maven\bin"
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$MavenPath", "Machine")
```

Then restart your terminal.

## Step 3: Verify Installation

Open a **NEW** terminal window and run:

```bash
mvn -version
```

Expected output:
```
Apache Maven 3.9.x (...)
Maven home: C:\Program Files\Apache\maven
Java version: 24.0.2
```

## Step 4: Start the Backend

Once Maven is working:

```bash
cd "c:\Users\91983\OneDrive\Desktop\Fullstack task\backend"
mvn spring-boot:run
```

Wait for: `Started JwtAuthApplication in X seconds`

---

## Alternative: Use Full Path (Temporary Solution)

If you don't want to add to PATH, use the full path each time:

```bash
cd "c:\Users\91983\OneDrive\Desktop\Fullstack task\backend"
C:\Path\To\Maven\bin\mvn.cmd spring-boot:run
```

Replace `C:\Path\To\Maven` with your actual Maven installation path.

---

## Troubleshooting

### Issue: Still says "mvn not recognized"

**Solutions:**
1. Make sure you opened a NEW terminal after adding to PATH
2. Verify the path is correct:
   ```bash
   Test-Path "C:\Program Files\Apache\maven\bin\mvn.cmd"
   ```
   Should return: `True`

3. Check current PATH:
   ```bash
   echo $env:Path
   ```
   Look for your Maven bin folder

### Issue: Maven extracts but won't run

**Try:**
1. Make sure Java is installed (you have Java 24 ✅)
2. Check if files exist:
   ```bash
   Get-ChildItem "C:\Program Files\Apache\maven\bin"
   ```
3. Try running directly:
   ```bash
   & "C:\Program Files\Apache\maven\bin\mvn.cmd" -version
   ```

### Issue: Permission denied

**Solution:**
- Extract to your user folder instead:
  ```
  C:\Users\91983\apache-maven
  ```
- Then add that path to PATH

---

## Quick Reference

### Common Maven Commands:

```bash
# Check version
mvn -version

# Build project
mvn clean install

# Run Spring Boot
mvn spring-boot:run

# Compile only
mvn compile

# Package as JAR
mvn clean package
```

---

## Need Help?

1. **Where did I download Maven?**
   - Check: `C:\Users\91983\Downloads`
   - Look for: `apache-maven-*-bin.zip`

2. **What's my Maven version?**
   - Any 3.8.x or 3.9.x works fine
   - Version number doesn't matter much for this project

3. **Can I use a different location?**
   - Yes! Just remember to add the correct path to PATH

---

## Next Steps After Setup

Once `mvn -version` works:

1. Navigate to backend:
   ```bash
   cd "c:\Users\91983\OneDrive\Desktop\Fullstack task\backend"
   ```

2. First build (downloads dependencies):
   ```bash
   mvn clean install
   ```
   This may take 5-10 minutes first time

3. Run the application:
   ```bash
   mvn spring-boot:run
   ```

4. Wait for success message:
   ```
   Started JwtAuthApplication in X seconds
   ```

5. Refresh your browser where login.html is open
6. Try registering a user!

---

**You're almost there! Just extract Maven and add it to PATH!** 🚀

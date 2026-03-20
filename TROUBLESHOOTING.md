# 🔧 Troubleshooting Guide - Registration/Login Issues

## ✅ Backend is Running
Your Spring Boot server is confirmed running on **http://localhost:8080**

---

## 🚨 Common Issues & Solutions

### Issue 1: "Cannot connect to backend server"

**Symptom:** Error message says backend is not running

**Solution:**
1. Verify backend is running:
   - Check terminal where Maven is running
   - Look for: "Started JwtAuthApplication"
   
2. Test backend directly:
   ```bash
   # PowerShell
   Invoke-RestMethod http://localhost:8080/api/auth/login -Method POST -ContentType "application/json" -Body '{"usernameOrEmail":"test","password":"test"}'
   ```

3. Check port 8080:
   ```bash
   netstat -ano | findstr :8080
   ```

---

### Issue 2: Page opened via file:// protocol

**Symptom:** Registration form doesn't submit, console shows CORS errors

**Why:** Modern browsers block certain JavaScript features when opening HTML files directly

**Solutions:**

#### Option A: Use Python HTTP Server (Recommended)
```bash
cd "c:\Users\91983\OneDrive\Desktop\Fullstack task\frontend"
python -m http.server 8081
```
Then open: http://localhost:8081/register.html

#### Option B: Use VS Code Live Server Extension
1. Install "Live Server" extension in VS Code
2. Right-click register.html → "Open with Live Server"

#### Option C: Use Chrome Web Server Extension
- Install "Web Server for Chrome" from Chrome Web Store
- Point it to the frontend folder

#### Option D: Direct File Access (May Work)
- Simply double-click the HTML file
- Some browsers allow limited functionality

---

### Issue 3: JavaScript not loading

**Symptom:** Page loads but buttons don't work, no error messages

**Check:**
1. Open browser DevTools (F12)
2. Go to Console tab
3. Look for errors like:
   - "Failed to load resource"
   - "auth.js not found"
   - "register.js not found"

**Solution:**
- Ensure all JS files are in `frontend/js/` folder
- Check file paths in HTML are correct:
  ```html
  <script src="js/auth.js"></script>
  <script src="js/register.js"></script>
  ```

---

### Issue 4: Form validation errors

**Symptom:** Can't submit form, browser shows validation messages

**Requirements:**
- Username: Minimum 3 characters
- Email: Valid email format (must contain @)
- Password: Minimum 6 characters

**Test Credentials:**
```
Username: testuser
Email: test@example.com
Password: password123
```

---

### Issue 5: User already exists

**Symptom:** Error "Username is already taken" or "Email is already registered"

**Solution:**
1. Use different username/email
2. Or login with existing credentials
3. Or clear database:
   - Stop backend (Ctrl+C)
   - Restart backend (creates fresh database)

---

## 🧪 Testing Steps

### Step 1: Verify Backend
```bash
# PowerShell - Test backend endpoint
$body = @{ username = "newuser"; email = "new@example.com"; password = "pass123" } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:8080/api/auth/register" -Method POST -Body $body -ContentType "application/json"
```

Expected: Returns JWT token

### Step 2: Open Registration Page
Navigate to: `c:\Users\91983\OneDrive\Desktop\Fullstack task\frontend\register.html`

### Step 3: Fill Form
```
Username: uniqueuser123
Email: unique123@example.com
Password: securepass123
```

### Step 4: Submit
- Click "Register" button
- Should see: "Registration successful! Redirecting to profile..."
- Redirects to profile.html automatically

---

## 🔍 Browser Console Debugging

Press F12 to open DevTools, then check:

### Console Tab
Look for:
- ✅ "Backend is responding correctly"
- ❌ "Backend not accessible"
- ❌ "CORS policy blocked"

### Network Tab
Watch for:
- POST request to `/api/auth/register`
- Status should be 200 (success)
- Response should contain JWT token

### Application Tab
After successful registration:
- Local Storage → `jwt_token` should exist
- Token value starts with "eyJhbGciOiJIUzI1NiJ9..."

---

## 📝 Quick Fix Script

Run this to test everything:

```bash
# 1. Check if backend is running
Write-Host "Checking backend..."
try {
    $response = Invoke-RestMethod http://localhost:8080/api/auth/login -Method POST -ContentType "application/json" -Body '{"usernameOrEmail":"test","password":"test"}' -ErrorAction Stop
    Write-Host "✅ Backend is RUNNING" -ForegroundColor Green
} catch {
    Write-Host "❌ Backend NOT responding" -ForegroundColor Red
    Write-Host "Start the backend with: cd backend; mvn spring-boot:run"
}

# 2. Open registration page
Write-Host "`nOpening registration page..."
start "c:\Users\91983\OneDrive\Desktop\Fullstack task\frontend\register.html"

# 3. Show test credentials
Write-Host "`nTest Credentials:"
Write-Host "Username: testuser"
Write-Host "Email: test@example.com"
Write-Host "Password: password123"
```

---

## 🎯 What Should Happen

### Successful Registration Flow:
1. Fill registration form
2. Click "Register" button
3. JavaScript validates input
4. POST request sent to backend
5. Backend creates user in database
6. Backend generates JWT token
7. Frontend receives token
8. Token saved to localStorage
9. Success message displayed
10. Auto-redirect to profile page
11. Profile page loads with user data

---

## 🆘 Still Not Working?

### Try These:

1. **Clear Browser Cache**
   - Ctrl+Shift+Delete
   - Clear cached images and files
   
2. **Use Incognito/Private Mode**
   - Opens clean environment
   
3. **Try Different Browser**
   - Chrome, Firefox, Edge
   
4. **Restart Backend**
   ```bash
   # Stop current backend (Ctrl+C)
   cd backend
   mvn spring-boot:run
   ```

5. **Check Firewall**
   - Ensure port 8080 is not blocked
   
6. **Verify Files Exist**
   ```bash
   Test-Path "c:\Users\91983\OneDrive\Desktop\Fullstack task\frontend\js\auth.js"
   Test-Path "c:\Users\91983\OneDrive\Desktop\Fullstack task\frontend\js\register.js"
   ```

---

## ✨ Latest Updates Applied

The following improvements were just made:

1. ✅ **Backend Connection Check** - Automatically verifies if backend is running
2. ✅ **Better Error Messages** - Clear, actionable error messages
3. ✅ **Console Logging** - Errors logged to browser console
4. ✅ **Auto-scroll to Error** - Error messages scroll into view
5. ✅ **Network Error Handling** - Distinguishes between backend down vs validation errors

---

## 📞 Quick Reference

| Component | URL/File | Status |
|-----------|----------|--------|
| Backend API | http://localhost:8080 | ✅ Running |
| Registration | frontend/register.html | Ready |
| Login | frontend/login.html | Ready |
| Profile | frontend/profile.html | Protected |
| H2 Console | http://localhost:8080/h2-console | Available |

---

**If all else fails:** The backend endpoint IS working (verified with PowerShell test). The issue is likely browser security when opening local files. Use an HTTP server (Python, Live Server, etc.) for best results!

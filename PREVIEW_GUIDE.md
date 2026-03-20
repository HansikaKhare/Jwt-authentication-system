# 🎬 Preview Guide - JWT Authentication System

## ✅ What Just Happened

Your login page should now be open in your default browser!

---

## 📍 Current Status

### Frontend: ✅ OPENED
- **Location:** `c:\Users\91983\OneDrive\Desktop\Fullstack task\frontend\login.html`
- **Status:** Opened in your browser

### Backend: ⏸️ NOT RUNNING
- **Required:** Spring Boot backend on port 8080
- **Status:** Needs to be started

---

## 🚀 Next Steps to Fully Preview

### Option 1: Start Backend with Maven (Recommended)

If you have Maven installed:

```bash
cd "c:\Users\91983\OneDrive\Desktop\Fullstack task\backend"
mvn spring-boot:run
```

Wait for message: `Started JwtAuthApplication in X seconds`

### Option 2: Use IntelliJ IDEA or Eclipse

**IntelliJ IDEA:**
1. Open `backend` folder in IDEA
2. Wait for Maven import
3. Run `JwtAuthApplication.java`

**Eclipse:**
1. File → Import → Existing Maven Projects
2. Select `backend` folder
3. Run `JwtAuthApplication.java`

### Option 3: Install Maven First

1. Download: https://maven.apache.org/download.cgi
2. Extract to: `C:\Program Files\Apache\maven`
3. Add to PATH environment variable
4. Restart terminal and run Option 1

---

## 🎨 What You Can See Right Now (Without Backend)

### Login Page Features:
✅ Beautiful purple-to-violet gradient background  
✅ Clean white card design  
✅ Username/Email input field  
✅ Password input field  
✅ Login button  
✅ Link to registration page  
✅ Responsive design  

### Try This:
1. **Click "Register here"** - Navigates to registration page
2. **View the beautiful UI** - Modern gradient design
3. **Test form validation** - Try submitting empty fields
4. **Check responsive design** - Resize browser window

---

## ⚠️ Expected Behavior Without Backend

### What WILL Work:
- ✅ Page loads with beautiful UI
- ✅ Form validation (required fields)
- ✅ Navigation between login/register
- ✅ CSS styling and animations

### What WON'T Work:
- ❌ Form submission (will show error)
- ❌ Actual authentication
- ❌ Profile page access (redirects to login)

**Error you'll see if trying to submit:**
```
Failed to fetch
```
This is normal - backend is not running yet.

---

## 🎯 Full Preview Checklist

To experience the complete system:

### 1. Start Backend ☐
```bash
cd backend
mvn spring-boot:run
```

### 2. Verify Backend Running ☐
Open browser to: http://localhost:8080
Should see: Whitelabel Error Page (this is normal - no root endpoint)

### 3. Test Registration ☐
- Click "Register here"
- Fill in:
  - Username: `testuser`
  - Email: `test@example.com`
  - Password: `password123`
- Click "Register"
- Should auto-login and redirect to profile

### 4. Test Login ☐
- After registration or logout
- Enter credentials
- Click "Login"
- Should see profile page

### 5. View Profile ☐
- See user information:
  - User ID
  - Username
  - Email
  - Role
  - Account Status
- Click "Logout" button

### 6. Inspect JWT Token ☐
- Press F12 (DevTools)
- Application tab → Local Storage
- Find `jwt_token`
- Copy and decode at: https://jwt.io

---

## 🔍 Visual Preview - What Each Page Looks Like

### Login Page
```
╔════════════════════════════════════╗
║  Gradient Background               ║
║  (Purple → Violet)                 ║
║                                    ║
║        ┌──────────────────┐        ║
║        │     Login        │        ║
║        ├──────────────────┤        ║
║        │ Username/Email   │        ║
║        │ [____________]   │        ║
║        │ Password         │        ║
║        │ [____________]   │        ║
║        │  [   Login   ]   │        ║
║        │                  │        ║
║        │ Don't have an    │        ║
║        │ account? Register│        ║
║        └──────────────────┘        ║
╚════════════════════════════════════╝
```

### Registration Page
```
╔════════════════════════════════════╗
║  Same Beautiful Gradient           ║
║                                    ║
║        ┌──────────────────┐        ║
║        │    Register      │        ║
║        ├──────────────────┤        ║
║        │ Username         │        ║
║        │ [____________]   │        ║
║        │ Email            │        ║
║        │ [____________]   │        ║
║        │ Password         │        ║
║        │ [____________]   │        ║
║        │  [  Register ]   │        ║
║        │                  │        ║
║        │ Have an account? │        ║
║        │     Login        │        ║
║        └──────────────────┘        ║
╚════════════════════════════════════╝
```

### Profile Page (Requires Backend)
```
╔════════════════════════════════════╗
║  Gradient Background               ║
║                                    ║
║        ┌──────────────────┐        ║
║        │  User Profile    │        ║
║        ├──────────────────┤        ║
║        │ User ID: 1       │        ║
║        │ Username: testuser        │
║        │ Email: test@example.com   │
║        │ Role: ROLE_USER  │        ║
║        │ Status: Active   │        ║
║        │  [  Logout  ]    │        ║
║        └──────────────────┘        ║
╚════════════════════════════════════╝
```

---

## 🎨 UI Features to Notice

### Design Elements:
- **Modern Gradient:** Purple (#667eea) to Violet (#764ba2)
- **Card Shadows:** Subtle depth with box-shadow
- **Input Animations:** Border color change on focus
- **Button Hover:** Lift effect with transform
- **Responsive:** Works on mobile, tablet, desktop
- **Typography:** Clean 'Segoe UI' font
- **Spacing:** Comfortable padding and margins

### Interactive Elements:
- **Focus States:** Blue border on inputs
- **Hover Effects:** Buttons lift slightly
- **Success Messages:** Green background
- **Error Messages:** Red background
- **Loading States:** Centered text

---

## 🧪 Quick Tests You Can Do

### Test 1: Form Validation
1. Leave fields empty
2. Try to submit
3. Browser should show "Please fill out this field"

### Test 2: Email Validation
1. Go to register page
2. Enter invalid email (e.g., "notanemail")
3. Try to submit
4. Browser should show "Please include '@'"

### Test 3: Password Length
1. Go to register page
2. Enter password less than 6 characters
3. Try to submit
4. Browser should show validation error

### Test 4: Navigation
1. Click "Register here" on login page
2. Should navigate to register.html
3. Click "Login here" on register page
4. Should navigate back to login.html

### Test 5: Responsive Design
1. Resize browser window
2. Card should stay centered
3. Content should remain readable
4. Works down to 320px width

---

## 📊 Browser DevTools Preview

### Console (F12):
You'll see logs like:
```
API Error: TypeError: Failed to fetch
    at api.request (auth.js:XX)
```
This is normal without backend running.

### Network Tab:
When submitting forms:
- Request URL: `http://localhost:8080/api/auth/login`
- Status: `(failed)`
- Error: `ERR_CONNECTION_REFUSED`

### Application Tab:
After successful login (with backend):
- Local Storage → `jwt_token`: `eyJhbGciOiJIUzI1NiJ9...`

---

## 🎬 Complete Demo Flow (With Backend Running)

### Step-by-Step Demo:

1. **Start Backend**
   ```bash
   cd backend
   mvn spring-boot:run
   ```

2. **Open Login Page**
   - Already open! ✅

3. **Register New User**
   - Click "Register here"
   - Fill form:
     - Username: `johndoe`
     - Email: `john@example.com`
     - Password: `securepass123`
   - Click "Register"
   - ✨ Auto-login and redirect to profile

4. **View Profile**
   - See your user information
   - All data from database via JWT auth

5. **Test Logout**
   - Click "Logout"
   - Redirects to login page
   - Token cleared from localStorage

6. **Test Login**
   - Enter credentials
   - Click "Login"
   - ✨ Back to profile page

7. **Inspect Token**
   - F12 → Application → Local Storage
   - Copy `jwt_token` value
   - Visit https://jwt.io
   - Paste and decode to see payload

---

## 🎯 Success Indicators

### Backend Started Successfully:
```
  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/

... (various startup logs)

Started JwtAuthApplication in 5.123 seconds
Process finished with exit code 0
```

### API Available:
- http://localhost:8080/api/auth/register ✅
- http://localhost:8080/api/auth/login ✅
- http://localhost:8080/api/profile ✅
- http://localhost:8080/h2-console ✅

### Frontend Working:
- Login page loads ✅
- Forms submit without errors ✅
- Redirects work ✅
- Profile displays ✅
- Token stored in localStorage ✅

---

## 🆘 If Pages Don't Load

### Issue: Blank page
**Solution:** 
- Check browser console (F12)
- Ensure file path is correct
- Try different browser

### Issue: Styles not loading
**Solution:**
- Check CSS file exists: `css/style.css`
- File structure should be: `frontend/css/style.css`

### Issue: JavaScript errors
**Solution:**
- Check all JS files in `frontend/js/` folder
- Ensure file paths in HTML are correct

---

## 📱 Mobile Preview

The application is fully responsive! Try it on:
- Phone browser
- Tablet
- Small browser window (resize to 320px width)

Features:
- Touch-friendly buttons
- Readable text sizes
- Optimized spacing
- No horizontal scroll

---

## 🎉 Summary

### Currently Available:
✅ Frontend opened in browser  
✅ Beautiful UI ready to view  
✅ Form validation working  
✅ Navigation between pages  

### Need Backend For:
🔲 Actual authentication  
🔲 User registration  
🔲 Profile viewing  
🔲 JWT token generation  
🔲 Protected routes  

---

**Ready to see the full magic? Start the backend and enjoy!** 🚀

For detailed setup instructions, see: `SETUP.md` or `QUICKSTART.md`

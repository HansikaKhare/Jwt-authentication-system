// Login form handler
document.addEventListener('DOMContentLoaded', function() {
    const loginForm = document.getElementById('loginForm');
    const loginMessage = document.getElementById('loginMessage');

    // Check if already logged in
    if (auth.isAuthenticated()) {
        window.location.href = 'profile.html';
    }
    
    // Check backend status
    checkBackendStatus();

    loginForm.addEventListener('submit', async function(e) {
        e.preventDefault();

        const usernameOrEmail = document.getElementById('usernameOrEmail').value;
        const password = document.getElementById('password').value;

        try {
            showMessage('', '');

            const response = await api.login({
                usernameOrEmail,
                password
            });

            // Store JWT token
            auth.setToken(response.token);

            // Show success message
            showMessage('Login successful! Redirecting...', 'success');

            // Redirect to profile page after a short delay
            setTimeout(() => {
                window.location.href = 'profile.html';
            }, 1000);

        } catch (error) {
            console.error('Login error:', error);
            showMessage(error.message || 'Login failed. Please check your credentials.', 'error');
        }
    });

    function showMessage(message, type) {
        loginMessage.textContent = message;
        loginMessage.className = type;
        loginMessage.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }
    
    async function checkBackendStatus() {
        try {
            const backendAvailable = await checkBackendConnection();
            if (!backendAvailable) {
                showMessage('⚠️ Backend server is not running. Please start the Spring Boot application on port 8080.', 'error');
            }
        } catch (error) {
            console.log('Backend check failed:', error);
        }
    }
});

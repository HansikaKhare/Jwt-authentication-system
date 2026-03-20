// Register form handler
document.addEventListener('DOMContentLoaded', function() {
    const registerForm = document.getElementById('registerForm');
    const registerMessage = document.getElementById('registerMessage');

    // Check if already logged in
    if (auth.isAuthenticated()) {
        window.location.href = 'profile.html';
    }

    // Show backend status on page load
    checkBackendStatus();

    registerForm.addEventListener('submit', async function(e) {
        e.preventDefault();

        const username = document.getElementById('username').value;
        const email = document.getElementById('email').value;
        const password = document.getElementById('password').value;

        try {
            showMessage('', '');

            const response = await api.register({
                username,
                email,
                password
            });

            // Store JWT token
            auth.setToken(response.token);

            // Show success message
            showMessage('Registration successful! Redirecting to profile...', 'success');

            // Redirect to profile page after a short delay
            setTimeout(() => {
                window.location.href = 'profile.html';
            }, 1000);

        } catch (error) {
            console.error('Registration error:', error);
            showMessage(error.message || 'Registration failed. Please check your input and try again.', 'error');
        }
    });

    function showMessage(message, type) {
        registerMessage.textContent = message;
        registerMessage.className = type;
        
        // Scroll to message
        registerMessage.scrollIntoView({ behavior: 'smooth', block: 'center' });
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

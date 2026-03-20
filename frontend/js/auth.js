// API Configuration
const API_BASE_URL = 'http://localhost:8080/api';

// Check if backend is accessible
async function checkBackendConnection() {
    try {
        const response = await fetch(`${API_BASE_URL}/auth/login`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ usernameOrEmail: 'test', password: 'test' })
        });
        // If we get any response (even 400/401), backend is reachable
        return true;
    } catch (error) {
        console.error('Backend not accessible:', error);
        return false;
    }
}

// Auth utility functions
const auth = {
    // Store token in localStorage
    setToken: function(token) {
        localStorage.setItem('jwt_token', token);
    },

    // Get token from localStorage
    getToken: function() {
        return localStorage.getItem('jwt_token');
    },

    // Remove token from localStorage
    removeToken: function() {
        localStorage.removeItem('jwt_token');
    },

    // Check if user is authenticated
    isAuthenticated: function() {
        return !!this.getToken();
    },

    // Get headers for authenticated requests
    getAuthHeaders: function() {
        const token = this.getToken();
        return {
            'Content-Type': 'application/json',
            'Authorization': token ? `Bearer ${token}` : ''
        };
    },

    // Redirect to login if not authenticated
    requireAuth: function() {
        if (!this.isAuthenticated()) {
            window.location.href = 'login.html';
            return false;
        }
        return true;
    },

    // Logout user
    logout: function() {
        this.removeToken();
        window.location.href = 'login.html';
    }
};

// API service functions
const api = {
    // Generic request handler
    request: async function(endpoint, options = {}) {
        const url = `${API_BASE_URL}${endpoint}`;
        
        // Check backend connection first
        const backendAvailable = await checkBackendConnection();
        if (!backendAvailable) {
            throw new Error('Cannot connect to backend server at http://localhost:8080. Please ensure the Spring Boot application is running.');
        }
        
        const config = {
            ...options,
            headers: {
                ...auth.getAuthHeaders(),
                ...(options.headers || {})
            }
        };

        try {
            const response = await fetch(url, config);
            const data = await response.json();

            if (!response.ok) {
                throw new Error(data.message || 'Request failed');
            }

            return data;
        } catch (error) {
            console.error('API Error:', error);
            if (error.message.includes('Cannot connect')) {
                throw error;
            }
            throw new Error(error.message || 'Network error. Please try again.');
        }
    },

    // Register user
    register: async function(userData) {
        return await this.request('/auth/register', {
            method: 'POST',
            body: JSON.stringify(userData)
        });
    },

    // Login user
    login: async function(credentials) {
        return await this.request('/auth/login', {
            method: 'POST',
            body: JSON.stringify(credentials)
        });
    },

    // Get user profile
    getProfile: async function() {
        return await this.request('/profile', {
            method: 'GET'
        });
    }
};

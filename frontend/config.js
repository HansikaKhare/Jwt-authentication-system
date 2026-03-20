// Frontend Configuration for Production
// This file will be overwritten during deployment with actual backend URL

window.API_CONFIG = {
    BASE_URL: import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080/api'
};

// Profile page handler
document.addEventListener('DOMContentLoaded', async function() {
    const profileContent = document.getElementById('profileContent');
    const logoutBtn = document.getElementById('logoutBtn');

    // Check if user is authenticated
    if (!auth.requireAuth()) {
        return;
    }

    // Load user profile
    await loadProfile();

    // Logout handler
    logoutBtn.addEventListener('click', function() {
        auth.logout();
    });

    async function loadProfile() {
        try {
            const profile = await api.getProfile();

            // Display profile information
            profileContent.innerHTML = `
                <div class="profile-info">
                    <div class="profile-info-item">
                        <div class="profile-label">User ID</div>
                        <div class="profile-value">${profile.id}</div>
                    </div>
                    <div class="profile-info-item">
                        <div class="profile-label">Username</div>
                        <div class="profile-value">${profile.username}</div>
                    </div>
                    <div class="profile-info-item">
                        <div class="profile-label">Email</div>
                        <div class="profile-value">${profile.email}</div>
                    </div>
                    <div class="profile-info-item">
                        <div class="profile-label">Role</div>
                        <div class="profile-value">${profile.role}</div>
                    </div>
                    <div class="profile-info-item">
                        <div class="profile-label">Account Status</div>
                        <div class="profile-value">${profile.enabled ? 'Active' : 'Disabled'}</div>
                    </div>
                </div>
            `;

        } catch (error) {
            if (error.message.includes('401') || error.message.includes('403')) {
                // Token expired or invalid
                auth.logout();
            } else {
                profileContent.innerHTML = `
                    <div class="message-container">
                        <p class="error">Failed to load profile. ${error.message}</p>
                    </div>
                `;
            }
        }
    }
});

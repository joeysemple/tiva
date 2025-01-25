import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String _userName = 'Joseph Bey';
  final String _userAvatar = 'https://picsum.photos/200/200';
  final String _userBio = 'Digital creator & content enthusiast';
  final int _followers = 1245;
  final int _following = 678;
  
  void _handleEditProfile() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Change Profile Picture'),
              onTap: () {
                // TODO: Implement photo change
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Bio'),
              onTap: () {
                // TODO: Implement bio edit
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showFollowers() {
    // TODO: Implement followers view
  }

  void _showFollowing() {
    // TODO: Implement following view
  }

  void _navigateToWallet() {
    // TODO: Implement wallet navigation
  }

  void _navigateToMyPosts() {
    // TODO: Implement my posts navigation
  }

  void _navigateToSubscriptions() {
    // TODO: Implement subscriptions navigation
  }

  void _navigateToHelpAndFeedback() {
    // TODO: Implement help and feedback navigation
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    int? badgeCount,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            if (badgeCount != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.accentColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badgeCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right,
              color: Colors.white70,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: false,
            title: const Padding(
              padding: EdgeInsets.only(left: 4, top: 12),
              child: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(_userAvatar),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.accentColor,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.edit, color: Colors.white, size: 20),
                          onPressed: _handleEditProfile,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                Text(
                  _userName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                
                Text(
                  _userBio,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[400],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: _showFollowers,
                      child: Column(
                        children: [
                          Text(
                            '$_followers',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Followers',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 32),
                    InkWell(
                      onTap: _showFollowing,
                      child: Column(
                        children: [
                          Text(
                            '$_following',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Following',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _buildProfileOption(
                        icon: Icons.account_balance_wallet_outlined,
                        title: 'Wallet',
                        onTap: _navigateToWallet,
                        badgeCount: 2,
                      ),
                      const Divider(height: 1, color: Colors.grey),
                      _buildProfileOption(
                        icon: Icons.post_add_outlined,
                        title: 'My Posts',
                        onTap: _navigateToMyPosts,
                        badgeCount: 5,
                      ),
                      const Divider(height: 1, color: Colors.grey),
                      _buildProfileOption(
                        icon: Icons.subscriptions_outlined,
                        title: 'My Subscription',
                        onTap: _navigateToSubscriptions,
                      ),
                      const Divider(height: 1, color: Colors.grey),
                      _buildProfileOption(
                        icon: Icons.help_outline_rounded,
                        title: 'Help & Feedback',
                        onTap: _navigateToHelpAndFeedback,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
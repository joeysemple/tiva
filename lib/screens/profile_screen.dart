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
  final int _followers = 1245;
  final int _following = 678;

  void _navigateToWallet() {
    // TODO: Implement wallet navigation
    print('Navigating to Wallet');
  }

  void _navigateToMyPosts() {
    // TODO: Implement my posts navigation
    print('Navigating to My Posts');
  }

  void _navigateToSubscriptions() {
    // TODO: Implement subscriptions navigation
    print('Navigating to Subscriptions');
  }

  void _navigateToHelpAndFeedback() {
    // TODO: Implement help and feedback navigation
    print('Navigating to Help & Feedback');
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
        size: 24,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.white70,
      ),
      onTap: onTap,
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
                // Profile Picture
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(_userAvatar),
                ),
                const SizedBox(height: 16),
                
                // Username
                Text(
                  _userName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Followers and Following
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
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
                    const SizedBox(width: 32),
                    Column(
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
                  ],
                ),
                const SizedBox(height: 32),
                
                // Profile Options
                _buildProfileOption(
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'Wallet',
                  onTap: _navigateToWallet,
                ),
                _buildProfileOption(
                  icon: Icons.post_add_outlined,
                  title: 'My Posts',
                  onTap: _navigateToMyPosts,
                ),
                _buildProfileOption(
                  icon: Icons.subscriptions_outlined,
                  title: 'My Subscription',
                  onTap: _navigateToSubscriptions,
                ),
                _buildProfileOption(
                  icon: Icons.help_outline_rounded,
                  title: 'Help & Feedback',
                  onTap: _navigateToHelpAndFeedback,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
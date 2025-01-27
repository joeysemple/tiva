import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/theme_service.dart';
import '../services/auth_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthService>().currentUser;
    final themeService = context.watch<ThemeService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          _buildSection(
            'Appearance',
            [
              SwitchListTile(
                title: const Text('Dark Mode'),
                subtitle: Text(themeService.isDarkMode ? 'On' : 'Off'),
                value: themeService.isDarkMode,
                onChanged: (value) => themeService.toggleTheme(),
              ),
            ],
          ),
          if (!user!.isAnonymous) ...[
            _buildSection(
              'Account',
              [
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: const Text('Edit Profile'),
                  onTap: () {
                    // TODO: Implement edit profile
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: const Text('Privacy'),
                  onTap: () {
                    // TODO: Implement privacy settings
                  },
                ),
              ],
            ),
          ],
          _buildSection(
            'App Settings',
            [
              ListTile(
                leading: const Icon(Icons.notifications_outlined),
                title: const Text('Notifications'),
                onTap: () {
                  // TODO: Implement notifications settings
                },
              ),
              ListTile(
                leading: const Icon(Icons.data_usage_outlined),
                title: const Text('Data Usage'),
                onTap: () {
                  // TODO: Implement data usage settings
                },
              ),
            ],
          ),
          _buildSection(
            'Support',
            [
              ListTile(
                leading: const Icon(Icons.help_outline),
                title: const Text('Help Center'),
                onTap: () {
                  // TODO: Implement help center
                },
              ),
              ListTile(
                leading: const Icon(Icons.bug_report_outlined),
                title: const Text('Report a Problem'),
                onTap: () {
                  // TODO: Implement report problem
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('About'),
                onTap: () {
                  // TODO: Implement about page
                },
              ),
            ],
          ),
          if (!user.isAnonymous)
            _buildSection(
              'Account Actions',
              [
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text('Logout', style: TextStyle(color: Colors.red)),
                  onTap: () {
                    context.read<AuthService>().signOut();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ),
        ...children,
        const Divider(),
      ],
    );
  }
}

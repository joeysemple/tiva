import 'package:flutter/material.dart';
import 'package:tiva/themes/app_theme.dart';
import 'package:tiva/screens/home_screen.dart';
import 'package:tiva/screens/threads_screen.dart';
import 'package:tiva/screens/live_screen.dart';
import 'package:tiva/screens/inbox_screen.dart';
import 'package:tiva/screens/profile_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tiva',
      theme: AppTheme.darkTheme,
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ThreadsScreen(),
    const LiveScreen(),
    const InboxScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.white.withOpacity(0.1),
              width: 0.5,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          backgroundColor: AppTheme.surfaceColor,
          elevation: 0,
          height: 64,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.grid_view_rounded, size: 24),
              selectedIcon: Icon(Icons.grid_view_rounded, size: 24),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.forum_outlined, size: 24),
              selectedIcon: Icon(Icons.forum_rounded, size: 24),
              label: 'Threads',
            ),
            NavigationDestination(
              icon: Icon(Icons.video_camera_front_outlined, size: 24),
              selectedIcon: Icon(Icons.video_camera_front, size: 24),
              label: 'Live',
            ),
            NavigationDestination(
              icon: Icon(Icons.mail_outline_rounded, size: 24),
              selectedIcon: Icon(Icons.mail_rounded, size: 24),
              label: 'Inbox',
            ),
            NavigationDestination(
              icon: Icon(Icons.account_circle_outlined, size: 24),
              selectedIcon: Icon(Icons.account_circle, size: 24),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../models/thread.dart';
import '../themes/app_theme.dart';

class ThreadsScreen extends StatefulWidget {
  const ThreadsScreen({super.key});

  @override
  State<ThreadsScreen> createState() => _ThreadsScreenState();
}

class _ThreadsScreenState extends State<ThreadsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  
  final List<LinearGradient> _gradients = [
    const LinearGradient(
      colors: [Color(0xFF1A1A1A), Color(0xFF2A2A2A)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Color(0xFF2C3E50), Color(0xFF3498DB)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ];

  final List<Thread> _threads = [
    Thread(
      id: '1',
      userId: 'user1',
      username: 'johndoe',
      userAvatar: 'https://picsum.photos/200',
      text: 'Just streamed for 4 hours! Thanks to everyone who joined 🎮 Had an amazing time playing with viewers',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      vibes: 423,
      waves: 48,
      echoes: 12,
      tags: ['gaming', 'stream', 'community'],
      mood: 'energetic',
      bgColor: '0xFF1A1A1A',
    ),
    Thread(
      id: '2',
      userId: 'user2',
      username: 'sarahsmith',
      userAvatar: 'https://picsum.photos/201',
      text: 'New video dropping tomorrow! Get ready for something special ✨',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      vibes: 892,
      waves: 145,
      echoes: 67,
      tags: ['content', 'creator'],
      mood: 'excited',
      bgColor: '0xFF1A1A1A',
    ),
    Thread(
      id: '3',
      userId: 'user3',
      username: 'alexcreates',
      userAvatar: 'https://picsum.photos/202',
      text: 'Who else is streaming tonight? Let\'s raid each other\'s streams! 🎥',
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      vibes: 245,
      waves: 89,
      echoes: 23,
      tags: ['streaming', 'community'],
      mood: 'social',
      bgColor: '0xFF1A1A1A',
    ),
    Thread(
      id: '4',
      userId: 'user4',
      username: 'gamergirl',
      userAvatar: 'https://picsum.photos/203',
      text: 'Today\'s stream was wild! Managed to get a 20 kill streak in Valorant 🎯 Thanks for all the support fam!',
      media: ['https://picsum.photos/400/301'],
      timestamp: DateTime.now().subtract(const Duration(hours: 6)),
      vibes: 756,
      waves: 234,
      echoes: 89,
      tags: ['gaming', 'valorant'],
      mood: 'hyped',
      bgColor: '0xFF2C3E50',
    ),
    Thread(
      id: '5',
      userId: 'user5',
      username: 'musicproducer',
      userAvatar: 'https://picsum.photos/204',
      text: 'Working on a new beat 🎵 Can\'t wait to showcase it in tonight\'s stream!',
      timestamp: DateTime.now().subtract(const Duration(hours: 8)),
      vibes: 432,
      waves: 67,
      echoes: 21,
      tags: ['music', 'producer'],
      mood: 'creative',
      bgColor: '0xFF1A1A1A',
    ),
    Thread(
      id: '6',
      userId: 'user6',
      username: 'artcreator',
      userAvatar: 'https://picsum.photos/205',
      text: '🎨 Live art session in 2 hours! We\'ll be creating digital portraits together.',
      media: ['https://picsum.photos/400/302'],
      timestamp: DateTime.now().subtract(const Duration(hours: 10)),
      vibes: 543,
      waves: 98,
      echoes: 45,
      tags: ['art', 'digital'],
      mood: 'inspired',
      bgColor: '0xFF2C3E50',
    ),
    Thread(
      id: '7',
      userId: 'user7',
      username: 'cosplayer',
      userAvatar: 'https://picsum.photos/206',
      text: 'Cosplay reveal stream tomorrow! Any guesses which character I\'ll be showing? 👀',
      timestamp: DateTime.now().subtract(const Duration(hours: 12)),
      vibes: 876,
      waves: 345,
      echoes: 123,
      tags: ['cosplay', 'anime'],
      mood: 'excited',
      bgColor: '0xFF1A1A1A',
    ),
    Thread(
      id: '8',
      userId: 'user8',
      username: 'techreview',
      userAvatar: 'https://picsum.photos/207',
      text: 'Live unboxing of the latest gaming gear! Join me to see what\'s inside 📦',
      media: ['https://picsum.photos/400/303'],
      timestamp: DateTime.now().subtract(const Duration(hours: 14)),
      vibes: 654,
      waves: 187,
      echoes: 76,
      tags: ['tech', 'unboxing'],
      mood: 'curious',
      bgColor: '0xFF2C3E50',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              pinned: true,
              snap: false,
              centerTitle: false,
              title: const Padding(
                padding: EdgeInsets.only(left: 4, top: 12),
                child: Text(
                  'Threads',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(42),
                child: Container(
                  height: 42,
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    indicatorSize: TabBarIndicatorSize.label,
                    dividerColor: Colors.transparent,
                    indicatorColor: AppTheme.accentColor,
                    indicatorWeight: 3,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    tabs: const [
                      Tab(text: 'For You'),
                      Tab(text: 'Following'),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            ListView.builder(
              padding: const EdgeInsets.only(top: 8),
              itemCount: _threads.length,
              itemBuilder: (context, index) {
                final thread = _threads[index];
                return _ThreadCard(
                  thread: thread,
                  gradient: _gradients[index % _gradients.length],
                );
              },
            ),
            ListView.builder(
              padding: const EdgeInsets.only(top: 8),
              itemCount: _threads.length,
              itemBuilder: (context, index) {
                final thread = _threads[index];
                return _ThreadCard(
                  thread: thread,
                  gradient: _gradients[index % _gradients.length],
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppTheme.accentColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _ThreadCard extends StatelessWidget {
  final Thread thread;
  final LinearGradient gradient;

  const _ThreadCard({
    required this.thread,
    required this.gradient,
  });

  String _getTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 7) {
      return '${timestamp.day}/${timestamp.month}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(thread.userAvatar),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '@${thread.username}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 4,
                            color: Colors.black45,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      _getTimeAgo(thread.timestamp),
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              thread.text,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
                height: 1.3,
                shadows: [
                  Shadow(
                    blurRadius: 4,
                    color: Colors.black45,
                  ),
                ],
              ),
            ),
            if (thread.media != null) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  thread.media!.first,
                  fit: BoxFit.cover,
                ),
              ),
            ],
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInteractionButton(
                  icon: Icons.favorite,
                  label: thread.vibes.toString(),
                  isActive: thread.hasVibed,
                  color: AppTheme.accentColor,
                ),
                _buildInteractionButton(
                  icon: Icons.chat_bubble_outline,
                  label: thread.waves.toString(),
                ),
                _buildInteractionButton(
                  icon: Icons.repeat,
                  label: thread.echoes.toString(),
                  isActive: thread.hasEchoed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractionButton({
    required IconData icon,
    required String label,
    bool isActive = false,
    Color? color,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: isActive ? (color ?? Colors.white) : Colors.grey[400],
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? (color ?? Colors.white) : Colors.grey[400],
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
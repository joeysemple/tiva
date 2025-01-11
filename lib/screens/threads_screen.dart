import 'package:flutter/material.dart';
import '../models/thread.dart';
import '../themes/app_theme.dart';
import '../screens/post_details_screen.dart';

class ThreadsScreen extends StatefulWidget {
  const ThreadsScreen({super.key});

  @override
  State<ThreadsScreen> createState() => _ThreadsScreenState();
}

class _ThreadsScreenState extends State<ThreadsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _newPostController = TextEditingController();
  Set<String> selectedCategories = {};
  bool _canPost = false;
  
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
      username: 'techexplorer',
      userAvatar: 'https://picsum.photos/200',
      text: 'Just checked out the new AI tools for content creation! 🤖 The possibilities are endless. Who else is excited about the future of AI? #AI #tech #innovation',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      vibes: 423,
      waves: 48,
      echoes: 12,
      tags: ['tech', 'AI', 'future'],
      mood: 'excited',
      bgColor: '0xFF1A1A1A',
    ),
    Thread(
      id: '2',
      userId: 'user2',
      username: 'gamingpro',
      userAvatar: 'https://picsum.photos/201',
      text: 'LIVE NOW: Streaming some competitive matches! Come join and chat 🎮 #gaming #esports',
      media: ['https://picsum.photos/400/300'],
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      vibes: 892,
      waves: 145,
      echoes: 67,
      tags: ['gaming', 'streaming'],
      mood: 'energetic',
      bgColor: '0xFF2C3E50',
    ),
    Thread(
      id: '3',
      userId: 'user3',
      username: 'cryptonews',
      userAvatar: 'https://picsum.photos/202',
      text: 'Market Analysis: Interesting developments in the crypto space today. What are your thoughts on the latest trends? 📊 #crypto #trading #blockchain',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      vibes: 567,
      waves: 89,
      echoes: 34,
      tags: ['crypto', 'finance'],
      mood: 'analytical',
      bgColor: '0xFF1A1A1A',
    ),
    Thread(
      id: '4',
      userId: 'user4',
      username: 'devlife',
      userAvatar: 'https://picsum.photos/203',
      text: 'Finally solved that bug that\'s been haunting me for days! Pro tip: Always check your async/await statements 😅 #coding #development #bugfix',
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      vibes: 756,
      waves: 234,
      echoes: 89,
      tags: ['coding', 'dev'],
      mood: 'accomplished',
      bgColor: '0xFF2C3E50',
    ),
    Thread(
      id: '5',
      userId: 'user5',
      username: 'artcreator',
      userAvatar: 'https://picsum.photos/204',
      text: 'New digital art piece finished! Exploring themes of technology and nature 🎨 What do you think? #digitalart #creativity',
      media: ['https://picsum.photos/400/301'],
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      vibes: 932,
      waves: 167,
      echoes: 78,
      tags: ['art', 'digital'],
      mood: 'creative',
      bgColor: '0xFF1A1A1A',
    ),
    Thread(
      id: '6',
      userId: 'user6',
      username: 'startupfounder',
      userAvatar: 'https://picsum.photos/205',
      text: 'Just launched our beta! Looking for early users to test our new productivity app. DM if interested! 🚀 #startup #entrepreneurship',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      vibes: 445,
      waves: 123,
      echoes: 56,
      tags: ['startup', 'tech'],
      mood: 'excited',
      bgColor: '0xFF2C3E50',
    ),
    Thread(
      id: '7',
      userId: 'user7',
      username: 'cybersec',
      userAvatar: 'https://picsum.photos/206',
      text: 'Important reminder: Update your passwords regularly and use 2FA! Security first 🔒 #cybersecurity #privacy',
      timestamp: DateTime.now().subtract(const Duration(hours: 6)),
      vibes: 678,
      waves: 234,
      echoes: 145,
      tags: ['security', 'tech'],
      mood: 'serious',
      bgColor: '0xFF1A1A1A',
    ),
    Thread(
      id: '8',
      userId: 'user8',
      username: 'aienthusiast',
      userAvatar: 'https://picsum.photos/207',
      text: 'Fascinating developments in machine learning today! The new models are showing incredible potential 🤖 #AI #ML #future',
      media: ['https://picsum.photos/400/302'],
      timestamp: DateTime.now().subtract(const Duration(hours: 7)),
      vibes: 889,
      waves: 345,
      echoes: 234,
      tags: ['AI', 'tech'],
      mood: 'fascinated',
      bgColor: '0xFF2C3E50',
    ),
  ];

  void _addNewPost(String text) {
    if (text.trim().isNotEmpty) {
      setState(() {
        _threads.insert(0, Thread(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          userId: 'current_user',
          username: 'you',
          userAvatar: 'https://picsum.photos/208',
          text: text,
          timestamp: DateTime.now(),
          vibes: 0,
          waves: 0,
          echoes: 0,
          tags: [],
          mood: 'default',
          bgColor: '0xFF1A1A1A',
        ));
      });
    }
  }

  void _showCategoriesDialog() {
    final availableCategories = [
      'Tech', 'Business', 'AI', 'Sports', 'Games', 
      'Art', 'Music', 'Fashion', 'Food', 'Travel'
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.grey[900],
              title: const Text(
                'Select Categories',
                style: TextStyle(color: Colors.white),
              ),
              content: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: availableCategories.map((category) {
                  final isSelected = selectedCategories.contains(category);
                  return FilterChip(
                    selected: isSelected,
                    label: Text(category),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          selectedCategories.add(category);
                        } else {
                          selectedCategories.remove(category);
                        }
                      });
                    },
                    selectedColor: AppTheme.accentColor,
                    checkmarkColor: Colors.white,
                    backgroundColor: Colors.grey[800],
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[300],
                    ),
                  );
                }).toList(),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel', style: TextStyle(color: Colors.grey[400])),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Save', style: TextStyle(color: AppTheme.accentColor)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showNewPostSheet() {
    _newPostController.clear();
    _canPost = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey[800],
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'New Post',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: _canPost
                            ? () {
                                _addNewPost(_newPostController.text);
                                Navigator.pop(context);
                              }
                            : null,
                        child: Text(
                          'Post',
                          style: TextStyle(
                            color: _canPost
                                ? AppTheme.accentColor
                                : Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _newPostController,
                    decoration: const InputDecoration(
                      hintText: 'What\'s on your mind?',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    autofocus: true,
                    onChanged: (text) {
                      setState(() {
                        _canPost = text.trim().isNotEmpty;
                      });
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    border: Border(
                      top: BorderSide(color: Colors.grey[800]!, width: 0.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.image, color: Colors.white),
                        onPressed: () {
                          // Handle image upload
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.tag, color: Colors.white),
                        onPressed: () {
                          // Handle adding tags
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _newPostController.addListener(() {
      setState(() {
        _canPost = _newPostController.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    _newPostController.dispose();
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
              actions: [
                IconButton(
                  icon: const Icon(Icons.category_outlined),
                  onPressed: _showCategoriesDialog,
                ),
                const SizedBox(width: 8),
              ],
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
        onPressed: _showNewPostSheet,
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
    return InkWell(
      onTap: () {
        print("Card tapped!"); // Debug print
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              print("Building PostDetailsScreen"); // Debug print
              return PostDetailsScreen(thread: thread);
            },
          ),
        );
      },
      child: Container(
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
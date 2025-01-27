import 'package:flutter/material.dart';
import '../models/thread.dart';
import '../models/comment.dart';
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

  final List<Thread> _threads = [
    Thread(
      id: '1',
      userId: 'user1',
      username: 'jamalfitness',
      userAvatar: 'https://picsum.photos/200',
      text: '🔥 Just finished an intense workout session! Remember: discipline beats motivation every time. Who\'s hitting the gym today? #fitness #motivation',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      vibes: 423,
      waves: 48,
      echoes: 12,
      tags: ['fitness', 'health', 'motivation'],
      mood: 'energetic',
      bgColor: '0xFF1A1A1A',
      comments: [
        Comment(
          id: 'c1',
          userId: 'user5',
          username: 'fitlife',
          userAvatar: 'https://picsum.photos/211',
          text: 'Great work! What\'s your current split looking like?',
          timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
          likes: 15,
        ),
      ],
    ),
    Thread(
      id: '2',
      userId: 'user2',
      username: 'techstartup',
      userAvatar: 'https://picsum.photos/201',
      text: 'Exciting news! 🚀 Just launched our beta version. Looking for early users to test our new productivity app. DM for early access!',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      vibes: 892,
      waves: 145,
      echoes: 67,
      tags: ['tech', 'startup', 'productivity'],
      mood: 'excited',
      bgColor: '0xFF2C3E50',
      comments: [],
    ),
    Thread(
      id: '3',
      userId: 'user3',
      username: 'travelingchef',
      userAvatar: 'https://picsum.photos/202',
      text: 'Exploring the street food scene in Bangkok! 🥘 The flavors here are absolutely incredible. Stop 1: Pad Thai from a local vendor that\'s been here for 30 years!',
      media: ['https://picsum.photos/400/300'],
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      vibes: 567,
      waves: 89,
      echoes: 34,
      tags: ['food', 'travel', 'thailand'],
      mood: 'happy',
      bgColor: '0xFF1A1A1A',
      comments: [],
    ),
    Thread(
      id: '4',
      userId: 'user4',
      username: 'booklover',
      userAvatar: 'https://picsum.photos/203',
      text: '📚 Current read: "The Psychology of Money" by Morgan Housel. Chapter 3 has some mind-blowing insights about wealth building. Anyone else read it?',
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      vibes: 345,
      waves: 78,
      echoes: 23,
      tags: ['books', 'finance', 'learning'],
      mood: 'thoughtful',
      bgColor: '0xFF2C3E50',
      comments: [],
    ),
    Thread(
      id: '5',
      userId: 'user5',
      username: 'artgallery',
      userAvatar: 'https://picsum.photos/204',
      text: 'New exhibition opening this weekend! 🎨 Featuring contemporary artists exploring themes of urban life and technology. Special preview tonight for members.',
      media: ['https://picsum.photos/400/301'],
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      vibes: 234,
      waves: 45,
      echoes: 12,
      tags: ['art', 'culture', 'exhibition'],
      mood: 'creative',
      bgColor: '0xFF1A1A1A',
      comments: [],
    ),
    Thread(
      id: '6',
      userId: 'user6',
      username: 'techreview',
      userAvatar: 'https://picsum.photos/205',
      text: 'Just got my hands on the new iPhone 15 Pro Max! First impressions: The titanium build is game-changing. Full review coming soon. Any specific features you want me to test?',
      media: ['https://picsum.photos/400/302'],
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      vibes: 789,
      waves: 234,
      echoes: 89,
      tags: ['tech', 'apple', 'review'],
      mood: 'excited',
      bgColor: '0xFF2C3E50',
      comments: [],
    ),
]; void _addNewPost(String text) {
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
          comments: [],
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
                  onPressed: () => Navigator.pop(context),
                  child: Text('Save', style: TextStyle(color: AppTheme.accentColor)),
                ),
              ],
            );
          },
        );
      },
    );
  } void _showNewPostSheet() {
    _newPostController.clear();
    _canPost = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _newPostController,
                  decoration: const InputDecoration(
                    hintText: 'What\'s on your mind?',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  maxLines: 5,
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
    );
  } @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
      backgroundColor: Colors.black,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.black,
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
              padding: EdgeInsets.zero,
              itemCount: _threads.length,
              itemBuilder: (context, index) {
                final thread = _threads[index];
                return _ThreadCard(thread: thread);
              },
            ),
            ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _threads.length,
              itemBuilder: (context, index) {
                final thread = _threads[index];
                return _ThreadCard(thread: thread);
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
} class _ThreadCard extends StatefulWidget {
  final Thread thread;

  const _ThreadCard({required this.thread});

  @override
  State<_ThreadCard> createState() => _ThreadCardState();
}

class _ThreadCardState extends State<_ThreadCard> {
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

  void _handleVibeTap() {
    setState(() {
      if (widget.thread.hasVibed) {
        widget.thread.vibes--;
        widget.thread.hasVibed = false;
      } else {
        widget.thread.vibes++;
        widget.thread.hasVibed = true;
      }
    });
  }

  void _handleShare() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.email, color: Colors.white),
              title: const Text('Email', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.sms, color: Colors.white),
              title: const Text('SMS', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.copy, color: Colors.white),
              title: const Text('Copy Link', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 16),
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
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap ?? () {
        if (icon == Icons.chat_bubble_outline) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostDetailsScreen(thread: widget.thread),
            ),
          );
        } else if (icon == Icons.repeat) {
          _handleShare();
          setState(() {
            if (widget.thread.hasEchoed) {
              widget.thread.echoes--;
              widget.thread.hasEchoed = false;
            } else {
              widget.thread.echoes++;
              widget.thread.hasEchoed = true;
            }
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isActive ? (color ?? Colors.white) : Colors.grey[400],
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isActive ? (color ?? Colors.white) : Colors.grey[400],
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[900],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(widget.thread.userAvatar),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '@${widget.thread.username}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              _getTimeAgo(widget.thread.timestamp),
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.thread.text,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        height: 1.4,
                      ),
                    ),
                    if (widget.thread.media != null) ...[
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          widget.thread.media!.first,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[850]!.withOpacity(0.3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildInteractionButton(
                      icon: Icons.favorite,
                      label: widget.thread.vibes.toString(),
                      isActive: widget.thread.hasVibed,
                      color: AppTheme.accentColor,
                      onTap: _handleVibeTap,
                    ),
                    _buildInteractionButton(
                      icon: Icons.chat_bubble_outline,
                      label: widget.thread.waves.toString(),
                    ),
                    _buildInteractionButton(
                      icon: Icons.repeat,
                      label: widget.thread.echoes.toString(),
                      isActive: widget.thread.hasEchoed,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 8,
          color: Colors.black,
        ),
      ],
    );
  }
}
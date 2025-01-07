import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

class Message {
  final String id;
  final String senderAvatar;
  final String senderName;
  final String messagePreview;
  final DateTime timestamp;
  final bool isRead;

  Message({
    required this.id,
    required this.senderAvatar,
    required this.senderName,
    required this.messagePreview,
    required this.timestamp,
    this.isRead = false,
  });
}

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Message> _messages = [
    Message(
      id: '1',
      senderAvatar: 'https://picsum.photos/200',
      senderName: 'John Doe',
      messagePreview: 'Hey, check out this cool new feature!',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      isRead: false,
    ),
    Message(
      id: '2',
      senderAvatar: 'https://picsum.photos/201',
      senderName: 'Jane Smith',
      messagePreview: 'Thanks for the collaboration request.',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      isRead: true,
    ),
    Message(
      id: '3',
      senderAvatar: 'https://picsum.photos/202',
      senderName: 'Mike Johnson',
      messagePreview: 'Looking forward to our stream tonight!',
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      isRead: false,
    ),
    Message(
      id: '4',
      senderAvatar: 'https://picsum.photos/203',
      senderName: 'Sarah Williams',
      messagePreview: 'The project is coming along great.',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
    ),
    Message(
      id: '5',
      senderAvatar: 'https://picsum.photos/204',
      senderName: 'Alex Brown',
      messagePreview: 'Can we discuss the new design?',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      isRead: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _formatTimestamp(DateTime timestamp) {
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

  List<Message> _getFilteredMessages(String filter) {
    switch (filter) {
      case 'Read':
        return _messages.where((message) => message.isRead).toList();
      case 'Unread':
        return _messages.where((message) => !message.isRead).toList();
      default:
        return _messages;
    }
  }

  Widget _buildMessageList(String filter) {
    final filteredMessages = _getFilteredMessages(filter);

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: filteredMessages.length,
      itemBuilder: (context, index) {
        final message = filteredMessages[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(message.senderAvatar),
              ),
              const SizedBox(width: 12),
              
              // Message details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          message.senderName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          _formatTimestamp(message.timestamp),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      message.messagePreview,
                      style: TextStyle(
                        color: message.isRead ? Colors.grey : Colors.white,
                        fontWeight: message.isRead ? FontWeight.normal : FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
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
                  'Inbox',
                  style: TextStyle(
                    fontSize: 28,
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
                      Tab(text: 'All'),
                      Tab(text: 'Read'),
                      Tab(text: 'Unread'),
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
            _buildMessageList('All'),
            _buildMessageList('Read'),
            _buildMessageList('Unread'),
          ],
        ),
      ),
    );
  }
}
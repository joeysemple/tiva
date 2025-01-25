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

class ChatMessage {
  final String content;
  final DateTime timestamp;
  final bool isSentByMe;

  ChatMessage({
    required this.content,
    required this.timestamp,
    required this.isSentByMe,
  });
}

class MessageViewScreen extends StatefulWidget {
  final Message message;
  
  const MessageViewScreen({super.key, required this.message});

  @override
  State<MessageViewScreen> createState() => _MessageViewScreenState();
}

class _MessageViewScreenState extends State<MessageViewScreen> {
  final TextEditingController _replyController = TextEditingController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _messages.add(ChatMessage(
      content: widget.message.messagePreview,
      timestamp: widget.message.timestamp,
      isSentByMe: false,
    ));
  }

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  void _sendReply() {
    if (_replyController.text.trim().isEmpty) return;
    
    setState(() {
      _messages.add(ChatMessage(
        content: _replyController.text,
        timestamp: DateTime.now(),
        isSentByMe: true,
      ));
    });
    
    _replyController.clear();
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          left: message.isSentByMe ? 64 : 0,
          right: message.isSentByMe ? 0 : 64,
          bottom: 8,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: message.isSentByMe 
            ? AppTheme.accentColor 
            : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.content,
              style: TextStyle(
                color: message.isSentByMe ? Colors.white : null,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatMessageTime(message.timestamp),
              style: TextStyle(
                color: message.isSentByMe 
                  ? Colors.white.withOpacity(0.7) 
                  : Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatMessageTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(widget.message.senderAvatar),
            ),
            const SizedBox(width: 8),
            Text(widget.message.senderName),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(_messages[_messages.length - 1 - index]);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                top: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _replyController,
                    decoration: const InputDecoration(
                      hintText: 'Type your reply...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    maxLines: null,
                    textInputAction: TextInputAction.newline,
                    onSubmitted: (_) => _sendReply(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendReply,
                  color: AppTheme.accentColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
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

  void _openMessage(Message message) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MessageViewScreen(message: message),
      ),
    );
    
    setState(() {
      final index = _messages.indexWhere((m) => m.id == message.id);
      if (index != -1) {
        _messages[index] = Message(
          id: message.id,
          senderAvatar: message.senderAvatar,
          senderName: message.senderName,
          messagePreview: message.messagePreview,
          timestamp: message.timestamp,
          isRead: true,
        );
      }
    });
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
        return InkWell(
          onTap: () => _openMessage(message),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(message.senderAvatar),
                ),
                const SizedBox(width: 12),
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
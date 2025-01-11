import 'package:flutter/material.dart';
import '../models/thread.dart';
import '../themes/app_theme.dart';

class PostDetailsScreen extends StatelessWidget {
  final Thread thread;

  const PostDetailsScreen({Key? key, required this.thread}) : super(key: key);

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
    return Scaffold(
      appBar: AppBar(
        title: Text('@${thread.username}'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // Post Details
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                          ),
                        ),
                        Text(
                          _getTimeAgo(thread.timestamp),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 13,
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
              ],
            ),
          ),
          // Comments Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Comments',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: thread.comments?.length ?? 0,
              itemBuilder: (context, index) {
                final comment = thread.comments![index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(comment.userAvatar),
                  ),
                  title: Text(
                    comment.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    comment.text,
                    style: const TextStyle(color: Colors.white),
                  ),
                  trailing: Text(
                    _getTimeAgo(comment.timestamp),
                    style: TextStyle(color: Colors.white.withOpacity(0.8)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}

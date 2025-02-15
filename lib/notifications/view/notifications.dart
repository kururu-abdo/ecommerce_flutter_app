import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  // Sample notification data
  final List<Map<String, dynamic>> notifications = [
    {
      "title": "Order Shipped",
      "message": "Your order #12345 has been shipped.",
      "time": "2h ago",
      "isRead": false,
    },
    {
      "title": "New Offer!",
      "message": "20% off on your next purchase.",
      "time": "5h ago",
      "isRead": false,
    },
    {
      "title": "Payment Received",
      "message": "We’ve received your payment for order #12344.",
      "time": "1d ago",
      "isRead": true,
    },
  ];

  // Function to mark a notification as read
  void markAsRead(int index) {
    setState(() {
      notifications[index]['isRead'] = true;
    });
  }

  // Function to delete a notification
  void deleteNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Notifications"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () {
              setState(() {
                notifications.clear();
              });
            },
            tooltip: "Clear All Notifications",
          ),
        ],
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text(
                "No notifications",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Card(
                  color: notification['isRead'] ? Colors.grey[200] : Colors.white,
                  child: ListTile(
                    title: Text(
                      notification['title'],
                      style: TextStyle(
                        fontWeight: notification['isRead'] ? FontWeight.normal : FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notification['message']),
                        const SizedBox(height: 4),
                        Text(
                          notification['time'],
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    trailing: PopupMenuButton<String>(
                      color: Colors.white,
                      onSelected: (value) {
                        if (value == 'Mark as Read') markAsRead(index);
                        if (value == 'Delete') deleteNotification(index);
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'Mark as Read',
                          child: Text('Mark as Read'),
                        ),
                        const PopupMenuItem(
                          value: 'Delete',
                          child: Text('Delete'),
                        ),
                      ],
                      icon: const Icon(Icons.more_vert),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

import 'package:firebase_messaging/firebase_messaging.dart';

class FCMHelper {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  // Initialize Firebase Messaging
  Future<void> initialize() async {
    // Request notification permissions (iOS only)
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Subscribe to topics if needed
      // await _messaging.subscribeToTopic('general');

      // Configure message handlers
      FirebaseMessaging.onMessage.listen(_onMessage);
      FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

      // Handle the initial message when the app is launched from a notification
      RemoteMessage? initialMessage = await _messaging.getInitialMessage();
      if (initialMessage != null) {
        _handleNotification(initialMessage);
      }
    } else {
      print('User declined or has not accepted permission');
    }
  }

  // Get FCM Token
  Future<String?> getToken() async {
    try {
      String? token = await _messaging.getToken();
      print('FCM Token: $token');
      return token;
    } catch (e) {
      print('Error getting FCM token: $e');
      return null;
    }
  }

  // Handle foreground messages
  void _onMessage(RemoteMessage message) {
    print('Message received in foreground: ${message.notification?.title}');
    // Handle the message and show a local notification if needed
  }

  // Handle notification clicks
  void _onMessageOpenedApp(RemoteMessage message) {
    print('Notification clicked: ${message.notification?.title}');
    // Navigate to specific screen based on message data
  }

  // Handle the initial notification
  void _handleNotification(RemoteMessage message) {
    print('Initial message: ${message.notification?.title}');
    // Navigate to specific screen based on message data
  }

  // Subscribe to a topic
  Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
    print('Subscribed to topic: $topic');
  }

  // Unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
    print('Unsubscribed from topic: $topic');
  }
}

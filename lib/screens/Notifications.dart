import 'package:flutter/material.dart';

class Notifications {
  final String title;
  final String message;
  final DateTime time;

  Notifications(
      {required this.title, required this.message, required this.time});
}

class NotificationsManager {
  static final NotificationsManager _instance =
      NotificationsManager._internal();

  factory NotificationsManager() {
    return _instance;
  }

  NotificationsManager._internal();

  List<Notifications> getNotificationsFromDatabase() {
    // Fetch notifications from the database and return them
    return [
      Notifications(
          title: 'Notification 1',
          message: 'Congrats you have arrived to 100 sales',
          time: DateTime.now()),
      Notifications(
          title: 'Notification 2',
          message: 'warning warning the stock should be verefied ',
          time: DateTime.now()),
      Notifications(
          title: 'Notification 3',
          message: 'warning warning the total expens is more than income',
          time: DateTime.now()),
    ];
  }

  void deleteNotification(int index) {
    // Delete the notification at the specified index
    // Implement your deletion logic here
  }
}

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final NotificationsManager _notificationsManager = NotificationsManager();
  List<Notifications> _notifications = [];

  @override
  void initState() {
    super.initState();
    _notifications = _notificationsManager.getNotificationsFromDatabase();
  }

  void _deleteNotification(int index) {
    setState(() {
      _notifications.removeAt(index);
    });
  }

  void _showNotificationDetails(Notifications notification) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(notification.title),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Time: ${notification.time.toString()}'),
            SizedBox(height: 10),
            Text('Message: ${notification.message}'),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue, // Set the background color to purple
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Close'),
          ),
        ],
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
        shadowColor: Colors.blue, // Set the shadow color to purple
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/rm222-mind-16.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Colors.grey,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 550),
                    Text(
                      'Notifications',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _notifications.length,
                  itemBuilder: (context, index) {
                    Notifications notification = _notifications[index];

                    return Card(
                      margin:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notification.title,
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              notification.time.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        onTap: () {
                          _showNotificationDetails(notification);
                        },
                        trailing: IconButton(
                          icon: Icon(Icons.close, color: Colors.blueAccent),
                          onPressed: () {
                            _deleteNotification(index);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

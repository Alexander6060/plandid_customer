import 'package:flutter/material.dart';

class NotificationModel {
  final String providerName; // e.g., photographer or videographer name
  final String providerAvatarUrl;
  final String notificationContent;
  final String time;
  final String?
  packageImageUrl; // optional: image or icon representing a package or service

  NotificationModel({
    required this.providerName,
    required this.providerAvatarUrl,
    required this.notificationContent,
    required this.time,
    this.packageImageUrl,
  });
}

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data representing wedding photography/videography notifications
    final notifications = [
      NotificationModel(
        providerName: "Elegance Photography",
        providerAvatarUrl: "https://picsum.photos/id/1011/400/600",
        notificationContent: "has sent you an updated quote for your wedding",
        time: "2h",
        packageImageUrl: "https://picsum.photos/id/1012/400/600",
      ),
      NotificationModel(
        providerName: "Golden Lens Studios",
        providerAvatarUrl: "https://picsum.photos/id/1025/400/600",
        notificationContent: "accepted your booking request for June 12",
        time: "5h",
      ),
      NotificationModel(
        providerName: "Capture the Day",
        providerAvatarUrl: "https://picsum.photos/id/1027/400/600",
        notificationContent: "sent you a message regarding package details",
        time: "1d",
        packageImageUrl: "https://picsum.photos/id/1028/400/600",
      ),
      NotificationModel(
        providerName: "Timeless Memories",
        providerAvatarUrl: "https://picsum.photos/id/1031/400/600",
        notificationContent: "has updated your booking for August 15",
        time: "3h",
        packageImageUrl: "https://picsum.photos/id/1032/400/600",
      ),
      NotificationModel(
        providerName: "Elegance Photography",
        providerAvatarUrl: "https://picsum.photos/id/1011/400/600",
        notificationContent: "sent you a new package recommendation",
        time: "6h",
        packageImageUrl: "https://picsum.photos/id/1013/400/600",
      ),
      NotificationModel(
        providerName: "Golden Lens Studios",
        providerAvatarUrl: "https://picsum.photos/id/1025/400/600",
        notificationContent: "has uploaded your edited wedding photos",
        time: "12h",
        packageImageUrl: "https://picsum.photos/id/1026/400/600",
      ),
      NotificationModel(
        providerName: "Dreamscape Videography",
        providerAvatarUrl: "https://picsum.photos/id/1042/400/600",
        notificationContent: "confirmed your video delivery timeline",
        time: "2d",
      ),
      NotificationModel(
        providerName: "Cherished Moments",
        providerAvatarUrl: "https://picsum.photos/id/1055/400/600",
        notificationContent: "added a new wedding film to their portfolio",
        time: "3d",
        packageImageUrl: "https://picsum.photos/id/1056/400/600",
      ),
      NotificationModel(
        providerName: "Ever After Photography",
        providerAvatarUrl: "https://picsum.photos/id/1067/400/600",
        notificationContent: "is offering a 20% discount on select packages",
        time: "1w",
        packageImageUrl: "https://picsum.photos/id/1068/400/600",
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (BuildContext context, int index) {
          final notification = notifications[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(notification.providerAvatarUrl),
            ),
            title: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: notification.providerName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: " ${notification.notificationContent}"),
                ],
              ),
            ),
            subtitle: Text(notification.time),
            trailing:
                notification.packageImageUrl != null
                    ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        notification.packageImageUrl!,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    )
                    : null,
            onTap: () {
              // TODO: Handle navigation or actions when tapping a notification
            },
          );
        },
      ),
    );
  }
}

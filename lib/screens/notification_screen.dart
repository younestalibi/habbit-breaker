import 'package:flutter/material.dart';
import 'package:habbit_breaker/services/not_test.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isSelected = false;

  @override
  void initState() {
    NotificationServices.askForNotificationPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Flutter Local Notification"),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                NotificationServices.sendInstantNotification(
                  title: "Test title",
                  body: "Test body ",
                  payload: "Test payload",
                );
              },
              child: const Text("Get instant notification"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 2,
                ),
                const Text("Get notification every minute"),
                const Spacer(),
                Switch(
                  value: isSelected,
                  onChanged: (value) {
                    isSelected = !isSelected;
                    if (isSelected) {
                      NotificationServices.sendPeriodicNotification(
                        title: "Test title 2",
                        body: "Test body 2",
                        payload: "Test payload 2",
                      );
                    } else {
                      NotificationServices.cancelPeriodicNotification();
                    }
                    setState(() {});
                  },
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
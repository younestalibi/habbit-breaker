import 'package:flutter/material.dart';

class TrackerScreen extends StatefulWidget {
  @override
  _TrackerScreenState createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'days',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            "124/400",
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          Text(
            "22:12:13",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          )
        ],
      ),
    );
  }
}

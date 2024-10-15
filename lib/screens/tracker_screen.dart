import 'package:flutter/material.dart';
import 'dart:async';

class TrackerScreen extends StatefulWidget {
  @override
  _TrackerScreenState createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  int currentStreak = 124; // Current number of days
  int targetStreak = 200; // Target number of days
  Timer? _timer;
  Duration _duration = Duration(days: 10, hours: 23, minutes: 59, seconds: 40);
  int mistakeCount = 0; // Count of mistakes
  DateTime? lastMistakeDate; // Store the last mistake date

  @override
  void initState() {
    super.initState();
    // Start the timer
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        // Increase the timer by 1 second
        _duration += Duration(seconds: 1);
      });
    });
  }

  void _resetCounter() {
    setState(() {
      currentStreak = 0; // Reset the current streak
      _duration = Duration(days: 0, hours: 0, minutes: 0, seconds: 0); // Reset timer
      mistakeCount = 0; // Reset mistakes
      lastMistakeDate = null; // Reset last mistake date
    });
    _timer?.cancel(); // Cancel the timer
    _startTimer(); // Restart the timer
  }

  void _logMistake() async {
    int mistakesToReduce = await showDialog<int>(
          context: context,
          builder: (BuildContext context) {
            TextEditingController controller = TextEditingController();
            return AlertDialog(
              title: Text('Log a Mistake'),
              content: TextField(
                controller: controller,
                decoration:
                    InputDecoration(hintText: 'Enter number of mistakes'),
                keyboardType: TextInputType.number,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(int.tryParse(controller.text));
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        ) ?? 0;

    if (mistakesToReduce > 0) {
      DateTime now = DateTime.now();
      if (lastMistakeDate == null || !isSameDay(lastMistakeDate!, now)) {
        // If it is a new day, reduce the streak and update the last mistake date
        setState(() {
          currentStreak = (currentStreak - 1).clamp(0, targetStreak); // Reduce streak
          mistakeCount += mistakesToReduce; // Increment mistake count
          lastMistakeDate = now; // Update last mistake date
        });
      } else {
        // If it is the same day, just increase the mistake count
        setState(() {
          mistakeCount += mistakesToReduce; // Increment mistake count
        });
      }
    }
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NoFap Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display current streak
            Text(
              'Current Streak: $currentStreak/$targetStreak',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Display timer
            Text(
              'Time Counter:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '${_duration.inDays}d ${(_duration.inHours % 24)}h ${(_duration.inMinutes % 60)}m ${(_duration.inSeconds % 60)}s',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),

            // Display mistake count
            Text(
              'Mistakes Made: $mistakeCount',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Reset counter button
            ElevatedButton(
              onPressed: _resetCounter,
              child: Text('Reset Counter to 0'),
            ),
            SizedBox(height: 10),

            // Log mistake button
            ElevatedButton(
              onPressed: _logMistake,
              child: Text('Log Mistake'),
            ),
          ],
        ),
      ),
    );
  }
}

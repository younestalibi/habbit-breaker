import 'dart:async';
import 'package:flutter/material.dart';

class TrackerScreen extends StatefulWidget {
  @override
  _TrackerScreenState createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  // Start date of the habit breaker
  DateTime habitStartDate = DateTime(2022, 5, 12, 14, 30, 0);
  DateTime? lastRelapse; // Will track the last time a relapse happened
  Duration timeDifference =
      Duration(); // Will hold the calculated time difference

  // Tracking variables
  int days = 0;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  int relapse = 0;
  int recoveryTime = 0;
  int longest = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        // Calculate the time difference between now and the habit start date
        DateTime now = DateTime.now();
        timeDifference = now.difference(habitStartDate);

        // Update days, hours, minutes, and seconds
        days = timeDifference.inDays;
        hours = timeDifference.inHours.remainder(24);
        minutes = timeDifference.inMinutes.remainder(60);
        seconds = timeDifference.inSeconds.remainder(60);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  bool isSameDay(DateTime? date1, DateTime? date2) {
    if (date1 == null || date2 == null) {
      return false;
    }
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  void _addRelapse() {
    DateTime now = DateTime.now();
    setState(() {
      // Check if the relapse is on the same day
      if (lastRelapse == null || !isSameDay(lastRelapse, now)) {
        relapse++;
        habitStartDate =
            habitStartDate.subtract(Duration(days: 1)); // Update the start date
      } else {
        relapse++; // Increment the relapse count
      }
      lastRelapse = now; // Update last relapse time
    });
  }

  void _resetCounter() {
    setState(() {
      habitStartDate = DateTime.now(); // Reset to the current date
      relapse = 0; // Reset relapse count
      recoveryTime = 0; // Reset recovery time
      longest = 0; // Reset longest streak
      lastRelapse = null; // Reset last relapse time
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/logo.png",
            height: 100,
          ),
          SizedBox(height: 16),
          const Text(
            'Days',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            _formatDays(days),
            style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 61, 224, 66)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _timeLabelColumn(hours, ": hour "),
              _timeLabelColumn(minutes, ": minute "),
              _timeLabelColumn(seconds, ": second "),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _statsCard(relapse, 'Relapse', Icons.sentiment_dissatisfied),
                _statsCard(days, 'Recovery Time', Icons.emoji_events),
                _statsCard(longest, 'Longest', Icons.timer),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () => _showResetConfirmationDialog(context),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.all(15),
                          backgroundColor:
                              const Color.fromARGB(255, 139, 212, 255)),
                      child: Text(
                        'Reset the counter',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                      onPressed: _addRelapse,
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.all(15),
                          backgroundColor:
                              const Color.fromARGB(255, 39, 39, 39)),
                      child: Text(
                        'Add relapse',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showResetConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.info,
                  size: 30.0,
                  color: const Color.fromARGB(255, 57, 166, 255),
                ),
                Text(
                  'Reset Counter',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Are you sure you want to reset the counter?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _resetCounter(); // Reset the counter on confirmation
                        },
                        child: Text("Confirm"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _statsCard(int number, String label, IconData icon) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    number.toString(),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 61, 224, 66),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    icon,
                    size: 30.0,
                    color: const Color.fromARGB(255, 61, 224, 66),
                  ),
                ],
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _timeLabelColumn(int time, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formatTime(time),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  String _formatTime(int time) {
    return time.toString().padLeft(2, '0');
  }

  String _formatDays(int days) {
    if (days >= 500) {
      return "$days/1000";
    } else if (days >= 400) {
      return "$days/500";
    } else if (days >= 300) {
      return "$days/400";
    } else if (days >= 200) {
      return "$days/300";
    } else if (days >= 100) {
      return "$days/200";
    } else {
      return days.toString();
    }
  }
}

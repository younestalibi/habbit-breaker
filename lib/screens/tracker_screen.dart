import 'dart:async';
import 'package:flutter/material.dart';

class TrackerScreen extends StatefulWidget {
  @override
  _TrackerScreenState createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  int hours = 23;
  int minutes = 59;
  int seconds = 55;
  int relapse = 12;
  int recoveryTime = 19;
  int longest = 33;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        seconds++;
        if (seconds >= 60) {
          seconds = 0;
          minutes++;
        }
        if (minutes >= 60) {
          minutes = 0;
          hours++;
        }
        if (hours >= 24) {
          hours = 0;
          minutes = 0;
          seconds = 0;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
          const Text(
            "0/90",
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
                _statsCard(recoveryTime, 'Recovery time', Icons.emoji_events),
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
                      onPressed: () {
                        _showResetConfirmationDialog(context);
                      },
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
                      onPressed: () {
                        print('Button Pressed');
                      },
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
                          setState(() {
                            hours = 0;
                            minutes = 0;
                            seconds = 0;
                            relapse = 0;
                            recoveryTime = 0;
                            longest = 0;
                          });
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
}

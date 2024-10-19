import 'dart:async';
import 'package:flutter/material.dart';
import 'package:habbit_breaker/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class TrackerScreen extends StatefulWidget {
  @override
  _TrackerScreenState createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  static const Color primaryColor = Color.fromARGB(255, 61, 224, 66);
  static const Color resetButtonColor = Color.fromARGB(255, 139, 212, 255);
  static const Color addRelapseButtonColor = Color.fromARGB(255, 39, 39, 39);
  late final AuthProvider authProvider;
  DateTime habitStartDate = DateTime(2022, 5, 12, 4, 30, 30);
  DateTime? lastRelapse;
  Duration timeDifference = Duration();

  int days = 0;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  int relapse = 12;
  int recoveryTime = 19;
  int longest = 33;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _fetchTrackerData();
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
        children: <Widget>[
          Image.asset("assets/logo.png", height: 100),
          SizedBox(height: 16),
          _buildCounterDisplay(),
          lastRelapse != null ? _buildLastRelapseText() : SizedBox.shrink(),
          _buildStatsRow(),
          SizedBox(height: 20),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildCounterDisplay() {
    return Column(
      children: [
        const Text('Days', style: TextStyle(fontSize: 18)),
        Text(
          _formatDays(days),
          style: TextStyle(
              fontSize: 50, fontWeight: FontWeight.bold, color: primaryColor),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _timeLabelColumn(hours, ": hour "),
            _timeLabelColumn(minutes, ": minute "),
            _timeLabelColumn(seconds, ": second "),
          ],
        ),
      ],
    );
  }

  Widget _buildLastRelapseText() {
    return Text(
      'Last relapse on: ${lastRelapse?.toLocal()}',
      style: TextStyle(fontSize: 12),
    );
  }

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _statsCard(relapse, 'Relapse', Icons.sentiment_dissatisfied),
          _statsCard(days, 'Recovery time', Icons.emoji_events),
          _statsCard(longest, 'Longest', Icons.timer),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          _buildElevatedButton('Reset the counter', resetButtonColor,
              _showResetConfirmationDialog),
          SizedBox(width: 8),
          _buildElevatedButton(
              'Add relapse', addRelapseButtonColor, _addRelapse),
        ],
      ),
    );
  }

  Widget _buildElevatedButton(
      String text, Color color, VoidCallback onPressed) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          padding: EdgeInsets.all(15),
          backgroundColor: color,
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  bool isSameDay(DateTime? date1, DateTime? date2) {
    return date1?.year == date2?.year &&
        date1?.month == date2?.month &&
        date1?.day == date2?.day;
  }

  Future<void> _fetchTrackerData() async {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    String userId = authProvider.user?.uid ?? '';

    if (userId.isNotEmpty) {
      final data = await authProvider.getTrackerData(userId);
      if (data != null) {
        setState(() {
          habitStartDate = DateTime.parse(data['habit_start_date']);
          lastRelapse = data['last_relapse'] != null
              ? DateTime.parse(data['last_relapse'])
              : null;
          relapse = data['relapse'] ?? 0;
          recoveryTime = data['recovery_time'] ?? 0;
          longest = data['longest'] ?? 0;
        });
      }
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
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

  void _addRelapse() {
    DateTime now = DateTime.now();
    setState(() {
      if (lastRelapse == null || !isSameDay(lastRelapse, now)) {
        relapse++;
        habitStartDate = habitStartDate.add(Duration(days: 1));
      } else {
        relapse++;
      }
      lastRelapse = now;
    });
    _updateRelapseData();
  }

  void _updateRelapseData() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    String userId = authProvider.user?.uid ?? '';

    if (userId.isNotEmpty) {
      authProvider.addRelapse(
          userId, habitStartDate, lastRelapse, relapse, recoveryTime, longest);
    }
  }

  void _showResetConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            padding: EdgeInsets.all(20),
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.info,
                    size: 30.0, color: const Color.fromARGB(255, 57, 166, 255)),
                Text('Reset Counter',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(
                  'Are you sure you want to reset the counter?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDialogButton("Cancel", Colors.red,
                        () => Navigator.of(context).pop()),
                    _buildDialogButton("Confirm", null, () {
                      Navigator.of(context).pop();
                      _resetCounter();
                    }),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDialogButton(String text, Color? color, VoidCallback onPressed) {
    return Expanded(
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: color ?? Colors.black),
        ),
      ),
    );
  }

  void _resetCounter() {
    setState(() {
      habitStartDate = DateTime.now();
      relapse = 0;
      recoveryTime = 0;
      longest = 0;
      lastRelapse = null;
    });
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    String userId = authProvider.user?.uid ?? '';

    if (userId.isNotEmpty) {
      authProvider.resetCounter(userId);
    }
  }

  Widget _statsCard(int number, String label, IconData icon) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 20),
                  SizedBox(width: 4),
                  Text(label, style: TextStyle(fontSize: 16)),
                ],
              ),
              SizedBox(height: 8),
              Text(number.toString(),
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _timeLabelColumn(int value, String label) {
    return Column(
      children: [
        Text(value.toString(), style: TextStyle(fontSize: 30)),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  String _formatDays(int days) {
    return days.toString().padLeft(2, '0');
  }
}

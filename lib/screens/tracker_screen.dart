import 'dart:async';
import 'package:flutter/material.dart';
import 'package:habbit_breaker/providers/auth_provider.dart';
import 'package:habbit_breaker/providers/tracker_provider.dart';
import 'package:provider/provider.dart';

class TrackerScreen extends StatefulWidget {
  @override
  _TrackerScreenState createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  DateTime? habitStartDate;
  DateTime? lastRelapse;
  Duration timeDifference = Duration();

  int days = 0;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  int relapse = 0;
  int recoveryTime = 0;
  int longest = 0;
  Timer? _timer;
  Future<Map<String, dynamic>>? _data;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _data = _fetch();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<Map<String, dynamic>>(
      future: _data,
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingIndicator();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final data = snapshot.data;
          if (data == null) {
            habitStartDate = DateTime.now();
            lastRelapse = null;
            relapse = 0;
            recoveryTime = 0;
            longest = 0;
          } else {
            habitStartDate = DateTime.parse(data['habit_start_date']);
            lastRelapse = data['last_relapse'] != null
                ? DateTime.parse(data['last_relapse'])
                : null;
            relapse = data['relapse'] ?? 0;
            recoveryTime = data['recovery_time'] ?? 0;
            longest = data['longest'] ?? 0;
          }
          return _buildTrackerContent(context);
        } else {
          return Center(child: Text('No data available'));
        }
      },
    ));
  }

  Widget _buildLoadingIndicator() {
    return CircularProgressIndicator();
  }

  Widget _buildTrackerContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
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
        lastRelapse != null
            ? Text(
                'Last relapse on : ${lastRelapse?.toLocal()}',
                style: TextStyle(fontSize: 12),
              )
            : SizedBox.shrink(),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _statsCard(relapse, 'Relapse', Icons.sentiment_dissatisfied),
              _statsCard(days, 'Recovery time', Icons.emoji_events),
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
                    onPressed: _addRelapse,
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.all(15),
                        backgroundColor: const Color.fromARGB(255, 39, 39, 39)),
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
    );
  }

  bool isSameDay(DateTime? date1, DateTime? date2) {
    if (date1 == null || date2 == null) {
      return false;
    }

    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Future<Map<String, dynamic>> _fetch() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final trackerProvider =
        Provider.of<TrackerProvider>(context, listen: false);
    String userId = authProvider.user?.uid ?? '';
    Map<String, dynamic> data = await trackerProvider.getTrackerData(userId);
    return data;
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      DateTime now = DateTime.now();
      if (habitStartDate != null) {
        setState(() {
          timeDifference = now.difference(habitStartDate!);
          days = timeDifference.inDays;
          hours = timeDifference.inHours.remainder(24);
          minutes = timeDifference.inMinutes.remainder(60);
          seconds = timeDifference.inSeconds.remainder(60);
        });
      }
    });
  }

  void _addRelapse() {
    DateTime now = DateTime.now();
    setState(() {
      if (lastRelapse == null || !isSameDay(lastRelapse, now)) {
        relapse++;
        if (!isSameDay(habitStartDate, now)) {
          habitStartDate = habitStartDate!.add(Duration(days: 1));
        }
      } else {
        relapse++;
      }
      lastRelapse = now;
      _data = _fetch();
    });
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final trackerProvider =
        Provider.of<TrackerProvider>(context, listen: false);

    String userId = authProvider.user?.uid ?? '';

    if (userId.isNotEmpty) {
      trackerProvider.addRelapse(
          userId, habitStartDate!, lastRelapse, relapse, recoveryTime, longest);
    }
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
                            habitStartDate = DateTime.now();
                            relapse = 0;
                            recoveryTime = 0;
                            longest = 0;
                            lastRelapse = null;
                            _data = _fetch();
                          });
                          print(habitStartDate);
                          final authProvider =
                              Provider.of<AuthProvider>(context, listen: false);
                          String userId = authProvider.user?.uid ?? '';
                          final trackerProvider = Provider.of<TrackerProvider>(
                              context,
                              listen: false);

                          if (userId.isNotEmpty) {
                            trackerProvider.resetCounter(userId);
                          }
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

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:habbit_breaker/constants/color_constants.dart';
import 'package:habbit_breaker/constants/image_constants.dart';
import 'package:habbit_breaker/generated/l10n.dart';
import 'package:habbit_breaker/providers/auth_provider.dart';
import 'package:habbit_breaker/providers/tracker_provider.dart';
import 'package:habbit_breaker/utils/dimensions.dart';
import 'package:habbit_breaker/utils/shared_prefs.dart';
import 'package:habbit_breaker/widgets/custom_elevated_button.dart';
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
  Future<Map<String, dynamic>?>? _data;

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
        child: FutureBuilder<Map<String, dynamic>?>(
      future: _data,
      builder: (BuildContext context,
          AsyncSnapshot<Map<String, dynamic>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingIndicator();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          if (data != null) {
            habitStartDate = DateTime.parse(data['habit_start_date']);
            lastRelapse = data['last_relapse'] != null
                ? DateTime.parse(data['last_relapse'])
                : null;
            relapse = data['relapse'] ?? 0;
            recoveryTime = data['recovery_time'] ?? 0;
            longest = data['longest'] ?? 0;
            return _buildTrackerContent(context);
          } else {
            return Text('Something went wrong');
          }
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            ImageConstants.logo,
            height: 100,
          ),
          Dimensions.smHeight,
          Text(
            S.of(context).days,
            style: TextStyle(fontSize: 18),
          ),
          Text(_formatDays(days),
              style: TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.secondary)),
          Dimensions.smHeight,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _timeLabelColumn(hours, "hour"),
              _timeLabelColumn(minutes, "minute"),
              _timeLabelColumn(seconds, "second"),
            ],
          ),
          isAtLeast24HoursApart(lastRelapse, DateTime.now())
              ? Text(S.of(context).you_have_relapsed_today)
              : SizedBox.shrink(),
          Dimensions.smHeight,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _statsCard(relapse, 'Relapse', Icons.sentiment_dissatisfied),
              _statsCard(days, 'Recovery time', Icons.emoji_events),
              _statsCard(longest, 'Longest', Icons.timer),
            ],
          ),
          Dimensions.mdHeight,
          Row(
            children: [
              Expanded(
                  child: CustomElevatedButton(
                backgroundColor: const Color.fromRGBO(105, 250, 238, 1),
                text: S.of(context).reset_counter,
                onPressed: () {
                  _showConfirmationDialog(context, 'reset');
                },
              )),
              SizedBox(width: 8),
              Expanded(
                  child: CustomElevatedButton(
                backgroundColor: Colors.black,
                text: S.of(context).add_relapse,
                onPressed: () {
                  _showConfirmationDialog(context, 'Add relpase');
                },
              ))
            ],
          )
        ],
      ),
    );
  }

  Future<Map<String, dynamic>?> _fetch() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final trackerProvider =
        Provider.of<TrackerProvider>(context, listen: false);
    String userId = authProvider.user?.uid ?? '';
    Map<String, dynamic>? data = await trackerProvider.getTrackerData(userId);
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

  void _showConfirmationDialog(BuildContext context, String type) {
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
                  type == 'reset'
                      ? S.of(context).reset_counter
                      : S.of(context).add_relapse,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  type == 'reset'
                      ? S.of(context).confirm_reset_counter
                      : S.of(context).confirm_add_relapse,
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
                          S.of(context).cancel,
                          style: TextStyle(color: ColorConstants.danger),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          final authProvider =
                              Provider.of<AuthProvider>(context, listen: false);
                          final trackerProvider = Provider.of<TrackerProvider>(
                              context,
                              listen: false);

                          String userId = authProvider.user?.uid ?? '';
                          if (type == 'reset') {
                            setState(() {
                              habitStartDate = DateTime.now();
                              relapse = 0;
                              recoveryTime = 0;
                              longest = 0;
                              lastRelapse = null;
                            });
                            if (userId.isNotEmpty) {
                              trackerProvider.resetCounter(userId);
                            }
                          } else {
                            DateTime now = DateTime.now();
                            setState(() {
                              if (lastRelapse == null ||
                                  isAtLeast24HoursApart(lastRelapse, now)) {
                                relapse++;

                                if (isAtLeast24HoursApart(
                                    habitStartDate, now)) {
                                  habitStartDate =
                                      habitStartDate!.add(Duration(days: 1));
                                }
                              } else {
                                relapse++;
                              }
                              lastRelapse = now;
                            });
                            if (userId.isNotEmpty) {
                              trackerProvider.addRelapse(
                                  userId,
                                  habitStartDate!,
                                  lastRelapse,
                                  relapse,
                                  recoveryTime,
                                  longest);
                            }
                          }
                          setState(() {
                            _data = _fetch();
                          });
                        },
                        child: Text(S.of(context).confirm),
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

  bool isAtLeast24HoursApart(DateTime? firstDate, DateTime? secondDate) {
    if (firstDate == null || secondDate == null) {
      return false;
    }
    Duration difference = secondDate.difference(firstDate);
    return difference.inHours >= 24;
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
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 61, 224, 66),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    icon,
                    size: 20.0,
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
            const SizedBox(width: 2),
            Text(
              _getLocalizedLabel(label),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 4),
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
    } else if (days >= 120) {
      return "$days/200";
    } else if (days >= 90) {
      return "$days/120";
    } else if (days >= 30) {
      return "$days/90";
    } else if (days >= 15) {
      return "$days/30";
    } else if (days >= 7) {
      return "$days/15";
    } else if (days < 7) {
      return "$days/7";
    } else {
      return days.toString();
    }
  }

  String _getLocalizedLabel(String label) {
    switch (label) {
      case 'hour':
        return S.of(context).hour;
      case 'minute':
        return S.of(context).minute;
      case 'second':
        return S.of(context).second;
      default:
        return '';
    }
  }
}

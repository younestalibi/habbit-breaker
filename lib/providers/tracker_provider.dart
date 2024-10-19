import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TrackerProvider with ChangeNotifier {
  final CollectionReference trackerCollection =
      FirebaseFirestore.instance.collection('trackers');

  // Function to add a relapse
  Future<String?> addRelapse(String userId, DateTime habitStartDate,
      DateTime? lastRelapse, int relapse, int recoveryTime, int longest) async {
    try {
      await trackerCollection.doc(userId).set({
        'habit_start_date': habitStartDate.toIso8601String(),
        'last_relapse': lastRelapse?.toIso8601String(),
        'relapse': relapse,
        'recovery_time': recoveryTime,
        'longest': longest,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      }, SetOptions(merge: true)); // Merge to update existing document
      return null; // Indicate success
    } catch (e) {
      return "Failed to add relapse. Please try again.";
    }
  }

  // Function to reset the counter
  Future<String?> resetCounter(String userId) async {
    try {
      await trackerCollection.doc(userId).update({
        'habit_start_date': DateTime.now().toIso8601String(),
        'last_relapse': null,
        'relapse': 0,
        'recovery_time': 0,
        'longest': 0,
        'updated_at': DateTime.now().toIso8601String(),
      });
      return null; // Indicate success
    } catch (e) {
      return "Failed to reset counter. Please try again.";
    }
  }

  Future<Map<String, dynamic>> getTrackerData(String userId) async {
    try {
      DocumentSnapshot doc = await trackerCollection.doc(userId).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      }
      return {};
    } catch (e) {
      print("Error fetching tracker data: $e");
      return Future.error(e);
    }
  }
}

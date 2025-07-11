import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> saveRecords() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;

  final userEntries = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('entries');

  for (var record in recordsList) {
    await userEntries.add({
      'text': record.text,
      'dateTime': record.dateTime.toIso8601String(),
    });
  }
}

Future<void> loadRecords() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;

  final userEntries = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('entries')
      .orderBy('dateTime', descending: true);

  final snapshot = await userEntries.get();

  recordsList.clear();
  recordsList.addAll(
    snapshot.docs.map((doc) {
      return Record.fromJson(doc.data(), doc.id);
    }),
  );
}

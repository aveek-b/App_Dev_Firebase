import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'main.dart';

const _storageKey = 'saved_record';

Future<void> saveRecords() async {
  final prefs = await SharedPreferences.getInstance();
  final List<String> jsonList = recordsList
      .map((record) => json.encode(record.toJson()))
      .toList();
  await prefs.setStringList(_storageKey, jsonList);
}

Future<void> loadRecords() async {
  final prefs = await SharedPreferences.getInstance();
  final List<String>? jsonList = prefs.getStringList(_storageKey);
  if (jsonList != null) {
    recordsList.clear();
    recordsList.addAll(
      jsonList.map((recordJson) {
        final Map<String, dynamic> jsonMap = json.decode(recordJson);
        return Record.fromJson(jsonMap);
      }),
    );
  }
}

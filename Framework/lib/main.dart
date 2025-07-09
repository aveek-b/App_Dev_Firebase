import 'package:daily_journal/Neptune.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "Alien.dart";
import "ViewEntry.dart";
import 'dart:convert';
import 'Storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadRecords();
  GoogleFonts.config.allowRuntimeFetching = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.orbitronTextTheme(Theme.of(context).textTheme),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 137, 34, 34),
        centerTitle: true,
        title: Text(
          'My Space Entries',
          style: const TextStyle(
            fontFamily: 'ShareTechMono',
            fontSize: 20,
            color: Color.fromRGBO(153, 191, 240, 1),
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Color.fromARGB(255, 75, 88, 185),
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
      ),

      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/retro-space-poster_810938-10.avif"),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          Positioned(
            top: 194,
            left: 110,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ViewEntry()),
                );
              },
              child: Image.asset("images/icons8-spaceship-48.png"),
            ),
          ),
          Positioned(
            top: 150,
            left: 90,
            child: Text(
              'Your Entries',
              style: GoogleFonts.orbitron(
                fontSize: 18,
                color: const Color.fromARGB(255, 226, 176, 241),
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: const Color.fromARGB(255, 241, 92, 92),
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 300,
            left: 180,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Spaceship()),
                );
              },
              child: Image.asset("images/icons8-uranus-planet-100.png"),
            ),
          ),
          Positioned(
            top: 340,
            left: 25,
            child: Text(
              'New Entry',
              style: GoogleFonts.orbitron(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 134, 195, 248),
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: const Color.fromARGB(255, 138, 89, 243),
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 460,
            left: 90,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Alien()),
                );
              },
              child: Image.asset("images/icons8-alien-48.png"),
            ),
          ),
          Positioned(
            top: 470,
            left: 150,
            child: Text(
              'Delete Entries',
              style: GoogleFonts.orbitron(
                fontSize: 18,
                color: const Color.fromARGB(255, 124, 248, 136),
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: const Color.fromARGB(255, 226, 240, 74),
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Record {
  String text;
  DateTime dateTime;
  Record(this.text, this.dateTime);
  String get preview {
    return text.length > 50 ? text.substring(0, 50) + '...' : text;
  }

  Map<String, dynamic> toJson() => {
    'text': text,
    'dateTime': dateTime.toIso8601String(),
  };
  factory Record.fromJson(Map<String, dynamic> json) =>
      Record(json['text'], DateTime.parse(json['dateTime']));
}

List<Record> recordsList = [];

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';
import "EntryDetailPage.dart";

class ViewEntry extends StatelessWidget {
  const ViewEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 137, 34, 34),
        title: Text(
          'UFO views Entries!',
          style: GoogleFonts.orbitron(
            textStyle: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.greenAccent,
                  offset: Offset(2, 2),
                ),
              ],
            ),
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
                image: NetworkImage(
                  "https://img.freepik.com/premium-vector/retro-space-poster_810938-10.jpg",
                ),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6), // transparent black
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListView.builder(
                itemCount: recordsList.length,
                itemBuilder: (context, index) {
                  final record = recordsList[index];
                  return ListTile(
                    title: Text(
                      record.preview,
                      style: GoogleFonts.orbitron(
                        textStyle: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.greenAccent,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                    subtitle: Text(record.dateTime.toLocal().toString()),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EntryDetailPage(record: record),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

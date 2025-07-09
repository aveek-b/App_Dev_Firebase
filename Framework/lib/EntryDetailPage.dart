import 'package:daily_journal/Storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';

class EntryDetailPage extends StatefulWidget {
  final Record record;
  const EntryDetailPage({super.key, required this.record});

  @override
  State<EntryDetailPage> createState() => _EntryDetailPageState();
}

class _EntryDetailPageState extends State<EntryDetailPage> {
  @override
  void editEntry() {
    final controller = TextEditingController(text: widget.record.text);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          "Edit Entry",
          style: const TextStyle(
            fontFamily: 'ShareTechMono',
            fontSize: 20,
            color: Color.fromARGB(255, 94, 81, 234),
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Color.fromARGB(255, 244, 108, 185),
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),

        content: TextField(
          controller: controller,
          maxLines: null,
          style: GoogleFonts.shareTechMono(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color.fromARGB(255, 89, 65, 65),
          ),

          decoration: InputDecoration(
            hintText: "Update your entry",
            hintStyle: const TextStyle(
              fontFamily: 'ShareTechMono',
              fontSize: 12,
              color: Color.fromARGB(255, 70, 66, 112),
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Color.fromARGB(255, 137, 98, 106),
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
        ),

        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: GoogleFonts.orbitron(
                textStyle: const TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 94, 81, 234),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Color.fromARGB(255, 244, 108, 185),
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),

          TextButton(
            onPressed: () async {
              setState(() {
                widget.record.text = controller.text;
              });
              await saveRecords();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Entry updated",
                    style: GoogleFonts.orbitron(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
            child: Text(
              "Save",
              style: GoogleFonts.orbitron(
                textStyle: const TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 94, 81, 234),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Color.fromARGB(255, 244, 108, 185),
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'View Entries!',
          style: const TextStyle(
            fontFamily: 'ShareTechMono',
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

        backgroundColor: const Color.fromARGB(255, 137, 34, 34),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: editEntry,
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/retro-space-poster_810938-10.avif"),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Created: ${widget.record.dateTime.toLocal()}",
                style: GoogleFonts.orbitron(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 188, 188, 234),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.record.text,
                style: GoogleFonts.orbitron(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 188, 188, 234),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';
import 'Storage.dart';

class Spaceship extends StatefulWidget {
  const Spaceship({super.key});

  @override
  State<Spaceship> createState() => _SpaceshipState();
}

class _SpaceshipState extends State<Spaceship> {
  @override
  final TextEditingController _controller = TextEditingController();
  void save() async {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      recordsList.add(Record(text, DateTime.now()));
      await saveRecords();
      Navigator.pop(context);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 137, 34, 34),
        title: Text(
          'Neptune Writes Entries!',
          style: const TextStyle(
            fontFamily: 'ShareTechMono',
            fontSize: 16,
            color: Color.fromARGB(255, 172, 185, 236),
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Color.fromARGB(255, 84, 114, 236),
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
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
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              "How are you doing?",
              style: GoogleFonts.orbitron(
                textStyle: const TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 188, 188, 234),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Color.fromARGB(255, 182, 90, 243),
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: GoogleFonts.shareTechMono(
                textStyle: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              decoration: InputDecoration(
                hintText: 'Type your galactic journal...',
                hintStyle: GoogleFonts.shareTechMono(
                  color: Colors.grey,
                  fontSize: 16,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 183, 108, 234),
                  ),
                ),
                filled: true,
                fillColor: Colors.black.withOpacity(0.4),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: save,
              child: Text(
                "Save Entry",
                style: GoogleFonts.orbitron(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 113, 113, 223),
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Color.fromARGB(255, 182, 90, 243),
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

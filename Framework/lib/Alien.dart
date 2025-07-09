import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';

class Alien extends StatefulWidget {
  const Alien({super.key});

  @override
  State<Alien> createState() => _AlienState();
}

class _AlienState extends State<Alien> {
  @override
  Widget build(BuildContext context) {
    void delete(int index) {
      setState(() {
        recordsList.removeAt(index);
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Entry deleted")));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 137, 34, 34),
        title: Text(
          'Alien Deletes Entries!',
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
          recordsList.isEmpty
              ? Center(
                  child: Text(
                    "No entries to delete",
                    style: GoogleFonts.orbitron(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 172, 247, 156),
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
                )
              : ListView.builder(
                  itemCount: recordsList.length,
                  itemBuilder: (context, index) {
                    final record = recordsList[recordsList.length - 1 - index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(
                          record.preview,
                          style: GoogleFonts.shareTechMono(
                            textStyle: TextStyle(
                              fontSize: 16,
                              color: const Color.fromARGB(255, 211, 187, 249),
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: const Color.fromARGB(
                                    255,
                                    255,
                                    131,
                                    170,
                                  ),
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                        subtitle: Text(
                          record.dateTime.toLocal().toString(),
                          style: GoogleFonts.orbitron(
                            textStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () => showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text(
                                "Delete this entry?",

                                style: GoogleFonts.orbitron(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 204, 117, 254),
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
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    "Cancel",
                                    style: GoogleFonts.orbitron(),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    delete(index);
                                  },
                                  child: Text(
                                    "Delete!",
                                    style: GoogleFonts.orbitron(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}

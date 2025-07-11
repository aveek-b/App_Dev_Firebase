import "main.dart";
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "Storage.dart";

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String errorMessage = '';
  bool isLogin = true;
  Future<void> _handleAuth() async {
    setState(() {
      errorMessage = '';
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    try {
      if (isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        await loadRecords();
        print("Logged in as: $email");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
        );
      } else {
        if (password != confirmPassword) {
          setState(() {
            errorMessage = "Password fields do not match!";
          });
          return;
        }

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await loadRecords();
        print("Signed up new user: $email");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? 'Authentication error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/retro-space-poster_810938-10.png"),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          isLogin
              ? Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Log In to Your Galaxy",
                          style: GoogleFonts.orbitron(
                            fontSize: 20,
                            color: const Color.fromARGB(255, 172, 185, 236),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            shadows: const [
                              Shadow(
                                blurRadius: 10.0,
                                color: Color.fromARGB(255, 84, 114, 236),
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),

                        TextField(
                          controller: _emailController,
                          style: GoogleFonts.shareTechMono(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Space Email',
                            hintStyle: GoogleFonts.shareTechMono(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.4),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 183, 108, 234),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          style: GoogleFonts.shareTechMono(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Secret Cosmic Password',
                            hintStyle: GoogleFonts.shareTechMono(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.4),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 183, 108, 234),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        ElevatedButton(
                          onPressed: _handleAuth,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadowColor: const Color.fromARGB(
                              255,
                              182,
                              90,
                              243,
                            ),
                            elevation: 10,
                          ),
                          child: Text(
                            "Launch",
                            style: GoogleFonts.orbitron(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 113, 113, 223),
                              shadows: const [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Color.fromARGB(255, 182, 90, 243),
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isLogin = !isLogin;
                              errorMessage = '';
                              _emailController.clear();
                              _passwordController.clear();
                            });
                          },
                          child: Text(
                            isLogin
                                ? "New here? Create an account"
                                : "Already have an account? Log in",
                            style: GoogleFonts.shareTechMono(
                              color: const Color.fromARGB(255, 172, 185, 236),
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                              decorationColor: const Color.fromARGB(
                                255,
                                113,
                                113,
                                223,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        if (errorMessage.isNotEmpty)
                          Text(
                            textAlign: TextAlign.center,
                            errorMessage,
                            style: TextStyle(
                              fontFamily: 'ShareTechMono',
                              fontSize: 20,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Color.fromARGB(255, 145, 98, 206),
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Sign up to your galaxy!",
                          style: GoogleFonts.orbitron(
                            fontSize: 20,
                            color: const Color.fromARGB(255, 172, 185, 236),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            shadows: const [
                              Shadow(
                                blurRadius: 10.0,
                                color: Color.fromARGB(255, 84, 114, 236),
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),

                        TextField(
                          controller: _emailController,
                          style: GoogleFonts.shareTechMono(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Space Email',
                            hintStyle: GoogleFonts.shareTechMono(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.4),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 183, 108, 234),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          style: GoogleFonts.shareTechMono(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Secret Cosmic Password',
                            hintStyle: GoogleFonts.shareTechMono(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.4),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 183, 108, 234),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          style: GoogleFonts.shareTechMono(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Confirm Secret Password',
                            hintStyle: GoogleFonts.shareTechMono(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.4),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 183, 108, 234),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),

                        ElevatedButton(
                          onPressed: _handleAuth,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadowColor: const Color.fromARGB(
                              255,
                              182,
                              90,
                              243,
                            ),
                            elevation: 10,
                          ),
                          child: Text(
                            "Sign up!",
                            style: GoogleFonts.orbitron(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 113, 113, 223),
                              shadows: const [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Color.fromARGB(255, 182, 90, 243),
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        if (errorMessage.isNotEmpty)
                          Text(
                            errorMessage,
                            style: TextStyle(
                              fontFamily: 'ShareTechMono',
                              fontSize: 20,
                              color: Colors.redAccent,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Color.fromARGB(255, 225, 131, 131),
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                          ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isLogin = !isLogin;
                              errorMessage = '';
                              _emailController.clear();
                              _passwordController.clear();
                            });
                          },
                          child: Text(
                            isLogin
                                ? "New here? Create an account"
                                : "Already have an account? Log in",
                            style: GoogleFonts.shareTechMono(
                              color: const Color.fromARGB(255, 172, 185, 236),
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                              decorationColor: const Color.fromARGB(
                                255,
                                113,
                                113,
                                223,
                              ),
                            ),
                          ),
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

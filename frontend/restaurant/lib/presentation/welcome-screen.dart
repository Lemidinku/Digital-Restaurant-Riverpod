import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'registration-form.dart';
import 'login-form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            Image.asset('./assets/img1.jpg'),
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              width: screenSize.width * 0.9,
              child: Column(
                children: [
                  Text(
                    'Welcome',
                    style: GoogleFonts.lato(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Before Enjoying Foodmedia Services Please Register First',
                    style: GoogleFonts.lato(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            SizedBox(
              width: screenSize.width * 0.7,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  showRegisterForm(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFFF97300), // Set the background color here
                ),
                child: Text(
                  'Create Account',
                  style: GoogleFonts.lato(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: screenSize.width * 0.7,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  showLoginForm(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 213, 181),
                ),
                child: Text(
                  'Login',
                  style: GoogleFonts.lato(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFF97300),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'By Logging in Or Registering, You Have Agreed To The ',
                          style: GoogleFonts.lato(
                            fontSize: 11,
                          ),
                        ),
                        TextSpan(
                          text: 'Terms ',
                          style: GoogleFonts.lato(
                            fontSize: 11,
                            color: Colors.orange,
                          ),
                        ),
                        TextSpan(
                          text: 'And ',
                          style: GoogleFonts.lato(
                            fontSize: 11,
                          ),
                        ),
                        TextSpan(
                          text: 'Conditons ',
                          style: GoogleFonts.lato(
                            fontSize: 11,
                            color: Colors.orange,
                          ),
                        ),
                        TextSpan(
                          text: 'And ',
                          style: GoogleFonts.lato(
                            fontSize: 11,
                          ),
                        ),
                        TextSpan(
                          text: 'Privacy Policies ',
                          style: GoogleFonts.lato(
                            fontSize: 11,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showRegisterForm(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isDismissible: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0)), // Set the curve radius here
    ),
    builder: (BuildContext context) {
      var screenSize = MediaQuery.of(context).size;

      return SizedBox(
        width: screenSize.width * 0.98,
        child: RegistrationForm(),
      );
    },
  );
}

// Function to show the login form as a modal bottom sheet

void showLoginForm(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isDismissible: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
          top: Radius.circular(200.0)), // Set the curve radius here
    ),
    builder: (BuildContext context) {
      var screenSize = MediaQuery.of(context).size;

      return SizedBox(
        width: screenSize.width * 0.98,
        child: LoginForm(),
      );
    },
  );
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widget/registration-form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SignupPage(),
    );
  }
}

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});
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
            SizedBox(
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RegistrationForm(),
                  SizedBox(
                    width: screenSize.width * 0.7,
                    height: 40,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        'Already Have An Account? Login Here',
                        style: GoogleFonts.lato(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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

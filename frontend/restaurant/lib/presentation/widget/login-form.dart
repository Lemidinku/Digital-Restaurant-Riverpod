import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../application/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print('login form init');
    super.initState();
    context.read<AuthBloc>().add(AuthCheck());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          print("Login successful");
          Navigator.pushReplacementNamed(context, '/entry');
        } else if (state is AuthError) {
          print("login not successful");
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Login failed")));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20.0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 30.0),
            Text(
              'Username',
              style:
                  GoogleFonts.lato(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: usernameController,
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter your username';
              //   }
              //   return null;
              // },
              decoration: InputDecoration(
                hintText: 'Enter your username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      15.0), // Adjust the radius here for more or less curve
                  borderSide: const BorderSide(
                    color: Colors.grey, // Set border color
                    width: 1.0, // Set border width
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Password',
              style:
                  GoogleFonts.lato(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              obscureText: true,
              controller: passwordController,
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter your password';
              //   }
              //   return null;
              // },
              decoration: InputDecoration(
                hintText: 'Enter your password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      15.0), // Adjust the radius here for more or less curve
                  borderSide: const BorderSide(
                    color: Colors.grey, // Set border color
                    width: 1.0, // Set border width
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              ),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                // if (_formKey.currentState!.validate()) {
                BlocProvider.of<AuthBloc>(context).add(AuthLogin(
                  username: usernameController.text,
                  password: passwordController.text,
                ));
                print(usernameController.text + ' ' + passwordController.text);
                // }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF97300), // Background color
                padding: const EdgeInsets.symmetric(vertical: 10.0),
              ),
              child: Text(
                'Login',
                style: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

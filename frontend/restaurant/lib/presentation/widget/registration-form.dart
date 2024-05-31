import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/application/auth/auth_provider.dart';

class RegistrationForm extends ConsumerStatefulWidget {
  RegistrationForm({super.key});

  @override
  ConsumerState<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends ConsumerState<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  void handleSignup() {
    // if (_formKey.currentState!.validate()) {
    final authNotifier = ref.read(authNotifierProvider.notifier);
    authNotifier.handleEvent(
      AuthSignUp(
        username: usernameController.text,
        phone: phoneController.text,
        password: passwordController.text,
      ),
    );
    // }
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authNotifierProvider, (previous, state) {
      if (state is AuthRegistered) {
        print("Registered successful");
        GoRouter.of(context).go('/login');
      } else if (state is AuthError) {
        print("Registered not successful");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.message)));
      }
    });

    return Container(
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
          TextField(
            keyboardType: TextInputType.text,
            controller: usernameController,
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
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            'phone number',
            style:
                GoogleFonts.lato(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          TextField(
            keyboardType: TextInputType.phone,
            controller: phoneController,
            decoration: InputDecoration(
              hintText: 'Enter your phone number',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    15.0), // Adjust the radius here for more or less curve
                borderSide: const BorderSide(
                  color: Colors.grey, // Set border color
                  width: 1.0, // Set border width
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            'Password',
            style:
                GoogleFonts.lato(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          TextField(
            obscureText: true,
            controller: passwordController,
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
              print(usernameController.text + ' ' + passwordController.text);
              handleSignup();
              // }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF97300), // Background color
              padding: const EdgeInsets.symmetric(vertical: 10.0),
            ),
            child: Text(
              'Create Account',
              style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

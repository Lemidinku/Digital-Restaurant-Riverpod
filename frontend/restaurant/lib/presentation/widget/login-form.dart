import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/auth/auth_provider.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void handleLogin() {
    final authNotifier = ref.read(authNotifierProvider.notifier);
    authNotifier.handleEvent(
      AuthLogin(
        username: usernameController.text,
        password: passwordController.text,
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authNotifierProvider.notifier).handleEvent(AuthCheck());
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authNotifierProvider, (previous, state) {
      if (state is AuthAuthenticated) {
        print("Login successful");
        if (state.user.role == 'admin') {
          GoRouter.of(context).go('/admin');
        } else {
          GoRouter.of(context).go('/entry');
        }
      } else if (state is AuthError) {
        print("Login not successful");
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
          TextFormField(
            keyboardType: TextInputType.text,
            controller: usernameController,
            decoration: InputDecoration(
              hintText: 'Enter your username',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.0,
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
          TextFormField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            ),
          ),
          const SizedBox(height: 30.0),
          ElevatedButton(
            onPressed: () {
              handleLogin();
              print(usernameController.text + ' ' + passwordController.text);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF97300),
              padding: const EdgeInsets.symmetric(vertical: 10.0),
            ),
            child: Text(
              'Login',
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

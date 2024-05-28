import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/application/auth/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocListener<AuthBloc, AuthState>(
        // listener: (context, state) {
        //   if (state == 1) {
        //     print("Login successful");
        //     Navigator.pushReplacementNamed(context, '/home');
        //   } else if (state == 0) {
        //     ScaffoldMessenger.of(context)
        //         .showSnackBar(SnackBar(content: Text("Login failed")));
        //   }
        // },
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            print("Login successful");
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is AuthError) {
            print("login not successful");
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Login failed")));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(AuthLogin(
                    username: usernameController.text,
                    password: passwordController.text,
                  ));
                  print(
                      usernameController.text + ' ' + passwordController.text);
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

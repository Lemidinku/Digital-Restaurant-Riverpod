import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/application/auth/auth_provider.dart';

class ProfilePage extends ConsumerStatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authNotifierProvider);

    if (state is AuthLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is AuthAuthenticated) {
      final user = state.user;
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(
                    'https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_640.png'),
              ),
              const SizedBox(height: 20),
              Text(
                user.username,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Card(
                child: ListTile(
                  leading: Icon(Icons.shopping_basket),
                  title: Text('Order'),
                  subtitle: Text('Explore Our Restaurant'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text('Phone'),
                  subtitle: Text(user.phone),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (state is AuthUnauthenticated) {
      return const Center(
        child: Text('The Token is Expired '),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}

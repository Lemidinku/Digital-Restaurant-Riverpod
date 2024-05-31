import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/presentation/admin/addfood.dart';
import 'package:restaurant/presentation/admin/component/dashbordhome.dart';
import 'package:restaurant/presentation/admin/orderlist.dart';
import 'package:go_router/go_router.dart';
import '../../application/auth/auth_provider.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key, required this.title});

  final String title;

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    AddedFoodsPage(),
    AddFoodPage(),
    OrdersListPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              fontFamily: AutofillHints.language),
        ),
        actions: [
          Consumer(
            builder: (context, ref, _) {
              return IconButton(
                onPressed: () {
                  _showLogoutConfirmationDialog(context, ref);
                },
                icon: const Icon(Icons.logout),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                ),
                child: Center(
                  child: Text(
                    'Digital restaurant',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: const Text('Dashboard',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                selected: _selectedIndex == 0,
                onTap: () {
                  _onItemTapped(0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(
                  'Add Food',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                selected: _selectedIndex == 1,
                onTap: () {
                  _onItemTapped(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Order List',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                selected: _selectedIndex == 2,
                onTap: () {
                  _onItemTapped(2);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: _widgetOptions[_selectedIndex],
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout Confirmation"),
          content: Text("Are you sure you want to logout?"),
          actions: <Widget>[
            TextButton(
              child: Text("Logout"),
              onPressed: () {
                ref
                    .read(authNotifierProvider.notifier)
                    .handleEvent(AuthLogout());
                // delay
                Future.delayed(Duration(seconds: 2));
                Navigator.of(context).pop(); // Close the dialog
                GoRouter.of(context).go('/login');
              },
            ),
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}

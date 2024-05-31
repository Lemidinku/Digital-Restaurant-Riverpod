// import 'package:flutter/material.dart';
// import 'package:restaurant/application/auth/auth_bloc.dart';
// import 'package:restaurant/presentation/home.dart';
// import 'package:restaurant/presentation/login_page.dart';
// import 'package:restaurant/presentation/order_now.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class BottomNav extends StatefulWidget {
//   const BottomNav({super.key});

//   @override
//   State<BottomNav> createState() => _BottomNavState();
// }

// class _BottomNavState extends State<BottomNav> {
//   //Create variable for selected index on the bottom nav bar
//   int selected_idx = 0;

//   void _navigateBottomBar(int index) {
//     setState(() {
//       selected_idx = index;
//     });
//   }

//   List _pages = [HomePage(), OrderNowPage(), LoginPage()];

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state is AuthUnauthenticated) {
//           Navigator.pushReplacementNamed(context, '/login');
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Logged Out Successfully')),
//           );
//         } else if (state is AuthError) {
//           ScaffoldMessenger.of(context)
//               .showSnackBar(const SnackBar(content: Text("Logout failed")));
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Digital Restaurant'),
//           centerTitle: true,
//           actions: [
//             IconButton(
//               onPressed: () {
//                 // ask for confirmation using showDialog
//                 // showDialog(context: context, builder: builder)
//                 _showLogoutConfirmationDialog(context);
//                 // context.read<AuthBloc>().add(AuthLogout());
//               },
//               icon: const Icon(Icons.logout),
//             ),
//           ],
//         ),
//         body: _pages[selected_idx],
//         bottomNavigationBar: BottomNavigationBar(
//           selectedItemColor: const Color(0xFFF97350),
//           unselectedItemColor: Colors.black,
//           iconSize: 34,
//           currentIndex: selected_idx,
//           onTap: _navigateBottomBar,
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.list),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person),
//               label: '',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void _showLogoutConfirmationDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text("Logout Confirmation"),
//         content: Text("Are you sure you want to logout?"),
//         actions: <Widget>[
//           TextButton(
//             child: Text("Logout"),
//             onPressed: () {
//               Navigator.of(context).pop();
//               context.read<AuthBloc>().add(AuthLogout());
//             },
//           ),
//           TextButton(
//             child: Text("Cancel"),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant/application/auth/auth_provider.dart';
import 'package:restaurant/presentation/home.dart';
import 'package:restaurant/presentation/login_page.dart';
import 'package:restaurant/presentation/order_now.dart';

class BottomNav extends ConsumerStatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  ConsumerState<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends ConsumerState<BottomNav> {
  int selectedIdx = 0;

  final List<Widget> _pages = [
    HomePage(),
    OrderNowPage(),
    LoginPage(),
  ];

  void _navigateBottomBar(int index) {
    setState(() {
      selectedIdx = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authNotifierProvider, (previous, state) {
      if (state is AuthUnauthenticated) {
        GoRouter.of(context).go('/login');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logged Out Successfully')),
        );
      } else if (state is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Logout failed")),
        );
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digital Restaurant'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _showLogoutConfirmationDialog(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _pages[selectedIdx],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFFF97350),
        unselectedItemColor: Colors.black,
        iconSize: 34,
        currentIndex: selectedIdx,
        onTap: _navigateBottomBar,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout Confirmation"),
          content: const Text("Are you sure you want to logout?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Logout"),
              onPressed: () {
                Navigator.of(context).pop();
                ref
                    .read(authNotifierProvider.notifier)
                    .handleEvent(AuthLogout());
              },
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

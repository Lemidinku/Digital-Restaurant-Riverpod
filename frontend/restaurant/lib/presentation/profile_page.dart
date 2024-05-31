// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:restaurant/application/auth/auth_bloc.dart';

// class ProfilePage extends StatefulWidget {
//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthBloc, AuthState>(
//       listener: (context, state) {
//         // TODO: implement listener
//       },
//       builder: (context, state) {
//         switch (state.runtimeType) {
//           case AuthAuthenticated:
//             final successState = state as AuthAuthenticated;
//             return Scaffold(
//               appBar: AppBar(
//                 title: Text('Profile'),
//               ),
//               body: Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     CircleAvatar(
//                       radius: 80,
//                       backgroundImage: NetworkImage(
//                           'https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_640.png'), // Use the user's photo URL here
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       successState
//                           .user.username, // Display the user's name here
//                       style:
//                           TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 20),
//                     Card(
//                       child: ListTile(
//                         leading: Icon(Icons.shopping_basket),
//                         title: Text('Order'),
//                         subtitle: Text('Explore Our Restaurant'),
//                       ),
//                     ),
//                     Card(
//                       child: ListTile(
//                         leading: Icon(Icons.phone),
//                         title: Text('Phone'),
//                         subtitle: Text(successState.user.phone),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           default:
//             return Center(
//               child: Text('The Token is Expired '),
//             );
//         }
//       },
//     );
//   }
// }

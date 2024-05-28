// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:restaurant/presentation/rating_stars.dart';

// class Meal {
//   final String id;
//   final String name;
//   final double price;
//   final String description;
//   final String imageUrl;
//   final List<String> types;
//   final bool fasting;
//   final String allergy;
//   final String origin;

//   Meal({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.description,
//     required this.imageUrl,
//     required this.types,
//     required this.fasting,
//     required this.allergy,
//     required this.origin,
//   });

//   factory Meal.fromJson(Map<String, dynamic> json) {
//     return Meal(
//       id: json['id'].toString(),
//       name: json['name'],
//       price: json['price'].toDouble(),
//       description: json['description'],
//       imageUrl: json['imageUrl'],
//       types: List<String>.from(json['types']),
//       fasting: json['fasting'],
//       allergy: json['allergy'],
//       origin: json['origin'],
//     );
//   }
// }

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Dio Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   String _response = 'lemi';
//   List<String> selected = [];
//   List<dynamic> _meals = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   void fetchData() async {
//     const token =
//         "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJhZG1pbiIsInBob25lIjoiMDkxMjMzNDMwOSIsInJvbGVzIjpbImFkbWluIl0sImlhdCI6MTcxNjQ2NTUzNCwiZXhwIjoxNzE2NTUxOTM0fQ.e-lT-wTcGIU1xQrT8N8NnGH40U2z-KEMOb3NxAzTeF0";

//     const url =
//         'http://10.0.2.2:5000/meals'; // Use 10.0.2.2 for Android emulator

//     try {
//       Dio dio = Dio();
//       dio.options.headers['Content-Type'] = 'application/json';
//       dio.options.headers['Authorization'] = 'Bearer $token';

//       Response response = await dio.get(url);

//       if (response.statusCode == 200) {
//         List<dynamic> data = response.data;

//         setState(() {
//           _meals = data.map((json) => Meal.fromJson(json)).toList();
//         });
//       } else {
//         setState(() {
//           _response = 'Request failed with status: ${response.statusCode}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _response = 'Request failed with error: $e';
//       });
//     }
//   }

//   void updateSelected(String id) {
//     setState(() {
//       selected.add(id);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(selected.join()),
//         ),
//         body: GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2, // Number of columns
//             crossAxisSpacing: 10.0, // Spacing between columns
//             mainAxisSpacing: 10.0, // Spacing between rows
//             childAspectRatio: 0.75, // Aspect ratio of each item
//           ),
//           itemCount: _meals.length,
//           itemBuilder: (context, index) {
//             Meal meal = _meals[index];
//             return _buildFoodItemCard(
//               id: meal.id,
//               title: meal.name,
//               imagePath: 'assets/Pizza.jpg',
//               rating: "3",
//               kind: meal.types[0],
//               type: "type",
//               origin: meal.origin,
//               price: meal.price.toString(),
//               updateSelected: updateSelected,
//             );
//           },
//         ));
//     // body: Text(_response));
//   }
// }

// Widget _buildFoodItemCard(
//     {required Function(String) updateSelected,
//     required String id,
//     required String title,
//     required String imagePath,
//     required String rating,
//     required String kind,
//     required String type,
//     required String origin,
//     required String price}) {
//   return Card(
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(15),
//     ),
//     color: const Color.fromARGB(255, 234, 228, 228),
//     elevation: 0,
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Padding(
//           padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
//           child: SizedBox(
//             height: 120,
//             child: Stack(
//               children: [
//                 Positioned.fill(
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.vertical(
//                       top: Radius.circular(15),
//                       bottom: Radius.circular(15),
//                     ),
//                     child: GestureDetector(
//                       onTap: () {},
//                       child: Image.asset(
//                         imagePath,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Expanded(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   Text(
//                     price,
//                     style: const TextStyle(
//                       fontSize: 15,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//               // const SizedBox(height: 5),
//               const RatingStars(
//                 rating: 3,
//                 size: 15.0,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     updateSelected(id);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFF97350),
//                     foregroundColor: Colors.white,
//                     elevation: 0,
//                     minimumSize: const Size(221, 37),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                   child: const Text('Select Order'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }

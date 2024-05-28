// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:bloc/bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

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

// abstract class MealEvent extends Equatable {
//   const MealEvent();

//   @override
//   List<Object> get props => [];
// }

// class FetchMeals extends MealEvent {}

// class UpdateSelected extends MealEvent {
//   final String mealId;

//   const UpdateSelected(this.mealId);

//   @override
//   List<Object> get props => [mealId];
// }

// // meal_state.dart

// abstract class MealState extends Equatable {
//   const MealState();

//   @override
//   List<Object> get props => [];
// }

// class MealInitial extends MealState {}

// class MealLoading extends MealState {}

// class MealLoaded extends MealState {
//   final List<Meal> meals;
//   final List<String> selected;

//   const MealLoaded(this.meals, {this.selected = const []});

//   @override
//   List<Object> get props => [meals, selected];
// }

// class MealError extends MealState {
//   final String message;

//   const MealError(this.message);

//   @override
//   List<Object> get props => [message];
// }

// // meal_bloc.dart
// // Import your meal model

// class MealBloc extends Bloc<MealEvent, MealState> {
//   MealBloc() : super(MealInitial()) {
//     on<FetchMeals>(_onFetchMeals);
//     on<UpdateSelected>(_onUpdateSelected);
//   }

//   void _onFetchMeals(FetchMeals event, Emitter<MealState> emit) async {
//     emit(MealLoading());
//     try {
//       const token =
//           "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJhZG1pbiIsInBob25lIjoiMDkxMjMzNDMwOSIsInJvbGVzIjpbImFkbWluIl0sImlhdCI6MTcxNjQ2NTUzNCwiZXhwIjoxNzE2NTUxOTM0fQ.e-lT-wTcGIU1xQrT8N8NnGH40U2z-KEMOb3NxAzTeF0";
//       const url =
//           'http://10.0.2.2:5000/meals'; // Use 10.0.2.2 for Android emulator

//       Dio dio = Dio();
//       dio.options.headers['Content-Type'] = 'application/json';
//       dio.options.headers['Authorization'] = 'Bearer $token';

//       Response response = await dio.get(url);

//       if (response.statusCode == 200) {
//         List<Meal> meals =
//             (response.data as List).map((json) => Meal.fromJson(json)).toList();
//         emit(MealLoaded(meals));
//       } else {
//         emit(MealError('Request failed with status: ${response.statusCode}'));
//       }
//     } catch (e) {
//       emit(MealError('Request failed with error: $e'));
//     }
//   }

//   void _onUpdateSelected(UpdateSelected event, Emitter<MealState> emit) {
//     if (state is MealLoaded) {
//       final currentState = state as MealLoaded;
//       final selected = List<String>.from(currentState.selected);
//       if (selected.contains(event.mealId)) {
//         selected.remove(event.mealId);
//       } else {
//         selected.add(event.mealId);
//       }
//       emit(MealLoaded(currentState.meals, selected: selected));
//     }
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
//       home: BlocProvider(
//         create: (_) => MealBloc()..add(FetchMeals()),
//         child: MyHomePage(),
//       ),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: BlocBuilder<MealBloc, MealState>(
//           builder: (context, state) {
//             if (state is MealLoaded) {
//               return Text(state.selected.join(', '));
//             } else {
//               return Text('Flutter Dio Demo');
//             }
//           },
//         ),
//       ),
//       body: BlocBuilder<MealBloc, MealState>(
//         builder: (context, state) {
//           if (state is MealInitial || state is MealLoading) {
//             return Center(child: CircularProgressIndicator());
//           } else if (state is MealLoaded) {
//             return GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2, // Number of columns
//                 crossAxisSpacing: 10.0, // Spacing between columns
//                 mainAxisSpacing: 10.0, // Spacing between rows
//                 childAspectRatio: 0.75, // Aspect ratio of each item
//               ),
//               itemCount: state.meals.length,
//               itemBuilder: (context, index) {
//                 Meal meal = state.meals[index];
//                 return _buildFoodItemCard(
//                   id: meal.id,
//                   title: meal.name,
//                   imagePath: 'assets/Pizza.jpg',
//                   rating: "3",
//                   kind: meal.types[0],
//                   type: "type",
//                   origin: meal.origin,
//                   price: meal.price.toString(),
//                   isSelected: state.selected.contains(meal.id),
//                   updateSelected: (String id) {
//                     BlocProvider.of<MealBloc>(context).add(UpdateSelected(id));
//                   },
//                 );
//               },
//             );
//           } else if (state is MealError) {
//             return Center(child: Text(state.message));
//           } else {
//             return Container();
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildFoodItemCard({
//     required String id,
//     required String title,
//     required String imagePath,
//     required String rating,
//     required String kind,
//     required String type,
//     required String origin,
//     required String price,
//     required bool isSelected,
//     required Function(String) updateSelected,
//   }) {
//     return Card(
//       child: Column(
//         children: [
//           Image.asset(imagePath, fit: BoxFit.cover),
//           Text(title),
//           // Text(kind),
//           // Text(type),
//           // Text(origin),
//           Text(price),
//           ElevatedButton(
//             onPressed: () => updateSelected(id),
//             child: Text(isSelected ? 'Deselect' : 'Select'),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:restaurant/domain/meal.dart';
import 'package:restaurant/presentation/admin/component/editMealform.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../application/meal/meal_provider.dart';

class AddedFoodsPage extends ConsumerStatefulWidget {
  @override
  _AddedFoodsPageState createState() => _AddedFoodsPageState();
}

class _AddedFoodsPageState extends ConsumerState<AddedFoodsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(mealNotifierProvider.notifier).loadMeals();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mealNotifierProvider);

    Widget body = Container(
      child: Text('NO content'),
    );

    if (state is MealSelectedButtonActionState) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Item selected')),
        );
      });
    }

    if (state is MealLoading) {
      body = const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (state is MealLoaded) {
      body = Scaffold(
        appBar: AppBar(
          title: Text(
            'Meals',
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange),
          ),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(16.0),
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          children: state.meals.map((meal) {
            return MealCard(meal: meal);
          }).toList(),
        ),
      );
    }

    return body;
  }
}

class MealCard extends ConsumerWidget {
  final Meal meal;

  const MealCard({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 400.0,
      child: Card(
        color: Colors.white,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 30.0, // Set a fixed height for the image
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                child: Image.asset(
                  'assets/Pizza.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 2.0),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // SizedBox(height: 4.0),
                  // Text(
                  //   'Kind: ${meal.description}',
                  //   style: TextStyle(fontSize: 16.0),
                  // ),
                  Text(
                    'Price: \$${meal.price}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return UpdateFoodPage(
                          meal: meal,
                        );
                      }));
                      // Handle edit action
                    },
                    child: Text('Edit'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle delete action
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Delete Food Item'),
                            content: Text(
                                'Are you sure you want to delete this item?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Perform delete action
                                  Navigator.of(context).pop();
                                  ref
                                      .read(mealNotifierProvider.notifier)
                                      .deleteMeal(meal.id.toString());
                                  // Assuming deleteMeal is defined in MealNotifier
                                },
                                child: Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text('Delete'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

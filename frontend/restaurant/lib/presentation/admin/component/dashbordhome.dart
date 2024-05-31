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
      child: const Text('NO content'),
    );

    if (state is MealSelectedButtonActionState) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item selected')),
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
          title: const Text(
            'Meals',
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange),
          ),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16.0),
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
              height: 30.0,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              ),
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16.0)),
                child: Image.asset(
                  'assets/Pizza.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 2.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.name,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Price: \$${meal.price}',
                    style: const TextStyle(fontSize: 16.0),
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
                    },
                    child: const Text('Edit'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Delete Food Item'),
                            content: const Text(
                                'Are you sure you want to delete this item?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  ref
                                      .read(mealNotifierProvider.notifier)
                                      .deleteMeal(meal.id.toString());
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Delete'),
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

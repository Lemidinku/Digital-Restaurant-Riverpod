import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant/application/meal/meal_provider.dart';
import 'package:restaurant/presentation/widget/built_item_card.dart';
import 'package:restaurant/presentation/widget/meal_col_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomoPageState createState() => _HomoPageState();
}

class _HomoPageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(mealNotifierProvider.notifier).loadMeals();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<MealState>(mealNotifierProvider, (previous, next) {
      if (next is MealError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.message)),
        );
      }
    });

    final state = ref.watch(mealNotifierProvider);

    Widget body;
    if (state is MealInitial) {
      body = const Center(child: CircularProgressIndicator());
    } else if (state is MealLoading) {
      body = const Center(child: CircularProgressIndicator());
    } else if (state is MealLoaded) {
      body = Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 4),
              child: SizedBox(
                height: 40,
                child: TextField(
                  style: const TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 228, 226, 226),
                    contentPadding: const EdgeInsets.all(1),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 160,
              child: PageView(
                children: const [
                  FlashOfferCard(
                    title: 'Flash Offer',
                    description: 'We are here with the best deserts in Addis.',
                    imagePath: 'assets/kitfo.jpg',
                  ),
                  FlashOfferCard(
                    title: 'Flash Offer',
                    description: 'We are here with the best deserts in Addis.',
                    imagePath: 'assets/dorowot.jpg',
                  ),
                  FlashOfferCard(
                    title: 'Flash Offer',
                    description: 'We are here with the best deserts in Addis.',
                    imagePath: 'assets/shiro.jpg',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today\'s Menu',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Text('Today\'s Specials'),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                itemCount: state.meals.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  mainAxisSpacing: 10.0, // Spacing between rows
                  crossAxisSpacing: 10.0, // Spacing between columns
                  childAspectRatio: 0.7, // Aspect ratio of each item
                ),
                itemBuilder: (context, index) {
                  return MealTail(
                    meals: state.meals[index],
                    // mealBloc: mealBloc,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFFF97350),
                  elevation: 0,
                  minimumSize: const Size(221, 37),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text('Order Now'),
              ),
            ),
          ],
        ),
      );
    } else if (state is MealError) {
      body = Center(child: Text('Error: ${state.message}'));
    } else {
      body = const Center(child: Text('Unknown state'));
    }

    return body;
  }
}

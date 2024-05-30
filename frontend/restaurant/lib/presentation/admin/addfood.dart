import 'package:flutter/material.dart';
import '../../application/meal/meal_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/meal.dart';

class Addpage extends StatelessWidget {
  const Addpage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project ',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: AddFoodPage(),
    );
  }
}

class AddFoodPage extends StatefulWidget {
  @override
  _AddFoodPageState createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  final _formKey = GlobalKey<FormState>();

  final _foodNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _photoLinkController = TextEditingController();
  final _originController = TextEditingController();

  bool _isDesert = false;
  bool _isStarter = false;
  bool _isDinner = false;
  bool _isLunch = false;
  bool _isBreakfast = false;
  bool? _isFasting = false;
  String _allergy = '';

  @override
  void dispose() {
    _foodNameController.dispose();
    _priceController.dispose();
    _photoLinkController.dispose();
    _descriptionController.dispose();
    _originController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Food Item',
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _foodNameController,
                decoration: const InputDecoration(
                  labelText: 'Food Name',
                  labelStyle: TextStyle(
                    color: Colors.red, // Change label text color
                    fontSize: 16.0, // Change label text size
                    fontWeight: FontWeight.bold, // Make label text bold
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the food name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Food Description',
                  labelStyle: TextStyle(
                    color: Colors.red, // Change label text color
                    fontSize: 16.0, // Change label text size
                    fontWeight: FontWeight.bold, // Make label text bold
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the food description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  labelStyle: TextStyle(
                    color: Colors.red, // Change label text color
                    fontSize: 16.0, // Change label text size
                    fontWeight: FontWeight.bold, // Make label text bold
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _photoLinkController,
                decoration: const InputDecoration(
                  labelText: 'Photo Link',
                  labelStyle: TextStyle(
                    color: Colors.red, // Change label text color
                    fontSize: 16.0, // Change label text size
                    fontWeight: FontWeight.bold, // Make label text bold
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the photo link';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _originController,
                decoration: const InputDecoration(
                  labelText: 'Origin',
                  labelStyle: TextStyle(
                    color: Colors.red, // Change label text color
                    fontSize: 16.0, // Change label text size
                    fontWeight: FontWeight.bold, // Make label text bold
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the origin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              const Text(
                'Food Type:',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange),
              ),
              CheckboxListTile(
                title: const Text('Desert'),
                value: _isDesert,
                onChanged: (value) {
                  setState(() {
                    _isDesert = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Starter'),
                value: _isStarter,
                onChanged: (value) {
                  setState(() {
                    _isStarter = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Dinner'),
                value: _isDinner,
                onChanged: (value) {
                  setState(() {
                    _isDinner = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Lunch'),
                value: _isLunch,
                onChanged: (value) {
                  setState(() {
                    _isLunch = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Breakfast'),
                value: _isBreakfast,
                onChanged: (value) {
                  setState(() {
                    _isBreakfast = value!;
                  });
                },
              ),
              SizedBox(height: 10),
              const Text(
                'Food Kind:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
              Row(
                children: [
                  Radio(
                    value: false,
                    groupValue: _isFasting,
                    onChanged: (value) {
                      setState(() {
                        print(_isFasting);
                        _isFasting = false;
                      });
                    },
                  ),
                  Text('Fasting'),
                  Radio(
                    value: true,
                    groupValue: _isFasting,
                    onChanged: (value) {
                      setState(() {
                        print(_isFasting);

                        _isFasting = true;
                      });
                    },
                  ),
                  Text('Non-Fasting'),
                ],
              ),
              SizedBox(height: 10),
              const Text(
                'Allergy:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
              Row(
                children: [
                  Text('Milk'),
                  Radio(
                    value: 'Milk',
                    groupValue: _allergy,
                    onChanged: (value) {
                      setState(() {
                        _allergy = value!;
                      });
                    },
                  ),
                  Text('Nuts'),
                  Radio(
                    value: 'Nuts',
                    groupValue: _allergy,
                    onChanged: (value) {
                      setState(() {
                        _allergy = value!;
                      });
                    },
                  ),
                  Text('Fish'),
                  Radio(
                    value: 'Fish',
                    groupValue: _allergy,
                    onChanged: (value) {
                      setState(() {
                        _allergy = value!;
                      });
                    },
                  ),
                  Text('Eggs'),
                  Radio(
                    value: 'Eggs',
                    groupValue: _allergy,
                    onChanged: (value) {
                      setState(() {
                        _allergy = value!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // Collect form data
                    final foodName = _foodNameController.text;
                    final description = _descriptionController.text;
                    final price = double.parse(_priceController.text);
                    final photoLink = _photoLinkController.text;
                    final origin = _originController.text;

                    final foodType = <String>[];
                    if (_isDesert) {
                      foodType.add('Desert');
                    }
                    if (_isStarter) {
                      foodType.add('Starter');
                    }
                    if (_isDinner) {
                      foodType.add('Dinner');
                    }
                    if (_isLunch) {
                      foodType.add('Lunch');
                    }
                    if (_isBreakfast) {
                      foodType.add('Breakfast');
                    }

                    BlocProvider.of<MealBloc>(context).add(AddMeal(
                        meal: Meal(
                            id: 0,
                            name: foodName,
                            description: description,
                            price: price,
                            imageUrl: photoLink,
                            types: foodType,
                            fasting: _isFasting!,
                            allergy: _allergy,
                            origin: origin)));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

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
  final _priceController = TextEditingController();
  final _photoLinkController = TextEditingController();

  bool _isDesert = false;
  bool _isStarter = false;
  bool _isDinner = false;
  bool _isLunch = false;
  bool _isBreakfast = false;
  bool? _foodKind;
  bool _isItaly = false;
  bool _isEthiopia = false;
  bool _isChina = false;
  bool _isFrance = false;

  @override
  void dispose() {
    _foodNameController.dispose();
    _priceController.dispose();
    _photoLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
                decoration: InputDecoration(
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
                controller: _priceController,
                decoration: InputDecoration(
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
                decoration: InputDecoration(
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
              SizedBox(height: 10),
              Text(
                'Food Type:',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange),
              ),
              CheckboxListTile(
                title: Text('Desert'),
                value: _isDesert,
                onChanged: (value) {
                  setState(() {
                    _isDesert = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Starter'),
                value: _isStarter,
                onChanged: (value) {
                  setState(() {
                    _isStarter = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Dinner'),
                value: _isDinner,
                onChanged: (value) {
                  setState(() {
                    _isDinner = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Lunch'),
                value: _isLunch,
                onChanged: (value) {
                  setState(() {
                    _isLunch = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Breakfast'),
                value: _isBreakfast,
                onChanged: (value) {
                  setState(() {
                    _isBreakfast = value!;
                  });
                },
              ),
              SizedBox(height: 10),
              Text(
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
                    value: true,
                    groupValue: _foodKind,
                    onChanged: (value) {
                      setState(() {
                        _foodKind = value as bool?;
                      });
                    },
                  ),
                  Text('Fasting'),
                  Radio(
                    value: false,
                    groupValue: _foodKind,
                    onChanged: (value) {
                      setState(() {
                        _foodKind = value as bool?;
                      });
                    },
                  ),
                  Text('Non-Fasting'),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Food Origin:',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange),
              ),
              CheckboxListTile(
                title: Text('Italy'),
                value: _isItaly,
                onChanged: (value) {
                  setState(() {
                    _isItaly = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Ethiopia'),
                value: _isEthiopia,
                onChanged: (value) {
                  setState(() {
                    _isEthiopia = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('China'),
                value: _isChina,
                onChanged: (value) {
                  setState(() {
                    _isChina = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('France'),
                value: _isFrance,
                onChanged: (value) {
                  setState(() {
                    _isFrance = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // Collect form data
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

class RaisedButton {}

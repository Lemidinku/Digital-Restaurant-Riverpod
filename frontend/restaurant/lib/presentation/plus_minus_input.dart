import 'package:flutter/material.dart';

void main() {
  runApp(const PlusMinusInput());
}

class PlusMinusInput extends StatefulWidget {
  const PlusMinusInput({super.key});
  @override
  PlusMinusInputState createState() => PlusMinusInputState();
}

class PlusMinusInputState extends State<PlusMinusInput> {
  int _value = 0;

  void _increment() {
    setState(() {
      _value++;
    });
  }

  void _decrement() {
    setState(() {
      if (_value > 0) {
        _value--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 150.0,
        // height: 30.0,
        child: Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                iconSize: 15.0,
                icon: const Icon(Icons.remove),
                onPressed: _decrement,
              ),
              Container(
                width: 40.0,
                height: 20.0,
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller: TextEditingController(text: _value.toString()),
                  readOnly: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                iconSize: 15.0,
                icon: const Icon(Icons.add),
                onPressed: _increment,
              ),
            ],
          ),
        ));
  }
}

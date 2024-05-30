import 'package:flutter/material.dart';

class PlusMinusInput extends StatelessWidget {
  final Function increment;
  final Function decrement;
  final int quantity;

  const PlusMinusInput({
    Key? key,
    required this.quantity,
    required this.increment,
    required this.decrement,
  }) : super(key: key);

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
                onPressed: () => decrement(),
              ),
              Container(
                width: 40.0,
                height: 20.0,
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller: TextEditingController(text: quantity.toString()),
                  readOnly: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                iconSize: 15.0,
                icon: const Icon(Icons.add),
                onPressed: () => increment(),
              ),
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';

class ButtonController extends StatelessWidget {
  const ButtonController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => {},
      icon: const Icon(Icons.headset_mic_sharp),
    );
  }
}

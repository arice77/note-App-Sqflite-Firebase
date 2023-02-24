import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData iconData;
  const CustomTextField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      validator: ((value) {
        if (value!.isEmpty) {
          return 'Cannot be  empty';
        }
        return null;
      }),
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        suffixIcon: Icon(
          iconData,
          color: Colors.white,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 50, 104, 254)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 50, 104, 254)),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
      ),
    );
  }
}

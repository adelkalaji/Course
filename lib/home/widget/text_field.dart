import 'package:flutter/material.dart';

Container myTextField(String hint, Color color, contr) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 25,
      vertical: 10,
    ),
    child: TextFormField(
      controller: contr,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 22,
        ),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.black45,
          fontSize: 19,
        ),
      ),
    ),
  );
}

import 'package:flutter/material.dart';

InputDecoration textFieldDecoration() {
  return InputDecoration(
    counterText: '',
    labelStyle: const TextStyle(
      fontSize: 14,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
    fillColor: const Color(0xffFAFAFA),
    filled: true,
    //0xffFAFAFA
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xffFAFAFA))),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xffFAFAFA))),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xffFAFAFA))),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xffFAFAFA))),
  );
}
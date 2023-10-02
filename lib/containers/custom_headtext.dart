import 'package:flutter/material.dart';

class CustomHeadText extends StatefulWidget {
  const CustomHeadText({super.key, required this.text});

  final String text;

  @override
  State<CustomHeadText> createState() => _CustomHeadTextState();
}

class _CustomHeadTextState extends State<CustomHeadText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}

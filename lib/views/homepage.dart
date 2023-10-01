import 'package:eventhub/colors/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kTransparent,
          foregroundColor: kTransparent,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.logout),
              color: kPrimary,
              iconSize: 30,
            ),
          ],
        ),
        body: Text(
          'Hi User',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}

import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({super.key, required this.data});
  final Document data;

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Image.network(
              'https://cloud.appwrite.io/v1/storage/buckets/651a89ae84605c06fb11/files/${widget.data.data['image']}/view?project=65192055e6e15fcbc9e5',
            ),
          ],
        ),
      ),
    );
  }
}

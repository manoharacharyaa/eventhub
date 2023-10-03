import 'package:appwrite/models.dart';
import 'package:eventhub/colors/colors.dart';
import 'package:eventhub/database.dart';
import 'package:eventhub/saved_data.dart';
import 'package:eventhub/views/event_details.dart';
import 'package:flutter/material.dart';

class RSVPEvents extends StatefulWidget {
  const RSVPEvents({super.key});

  @override
  State<RSVPEvents> createState() => _RSVPEventsState();
}

class _RSVPEventsState extends State<RSVPEvents> {
  List<Document> events = [];
  List<Document> userEvent = [];
  bool isLoading = true;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() {
    String userId = SaveData.getUserId();
    getAllEvents().then(
      (value) {
        events = value;
        for (var event in events) {
          List<dynamic> participants = event.data['participants'];
          if (participants.contains(userId)) {
            userEvent.add(event);
          }
          setState(() {
            isLoading = false;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'RSVP Events',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: ListView.builder(
        itemCount: userEvent.length,
        itemBuilder: (context, index) => Card(
          elevation: 3,
          color: const Color.fromARGB(255, 41, 42, 42),
          shadowColor: kPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: ListTile(
            title: Text(
              userEvent[index].data['name'],
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: kWhite),
            ),
            subtitle: Text(
              userEvent[index].data['location'],
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: kWhite, fontSize: 15),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventDetails(data: events[index]),
              ),
            ),
            trailing: const Icon(
              Icons.check_box,
              color: kPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

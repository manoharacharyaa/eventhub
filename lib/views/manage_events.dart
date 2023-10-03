import 'package:appwrite/models.dart';
import 'package:eventhub/colors/colors.dart';
import 'package:eventhub/database.dart';
import 'package:eventhub/views/edit_event.dart';
import 'package:eventhub/views/event_details.dart';
import 'package:flutter/material.dart';

class ManageEvents extends StatefulWidget {
  const ManageEvents({super.key});

  @override
  State<ManageEvents> createState() => _ManageEventsState();
}

class _ManageEventsState extends State<ManageEvents> {
  List<Document> userCreatedEvents = [];
  bool isLoading = true;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() {
    manageEvents().then((value) {
      userCreatedEvents = value;
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manage Events',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: ListView.builder(
        itemCount: userCreatedEvents.length,
        itemBuilder: (context, index) => Card(
          elevation: 3,
          color: const Color.fromARGB(255, 41, 42, 42),
          shadowColor: kPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: ListTile(
              title: Text(
                userCreatedEvents[index].data['name'],
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: kWhite),
              ),
              subtitle: Text(
                '${userCreatedEvents[index].data['participants'].length} pariicipants',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: kWhite, fontSize: 15),
              ),
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EventDetails(data: userCreatedEvents[index]),
                    ),
                  ),
              trailing: IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditEventPage(
                      image: userCreatedEvents[index].data['image'],
                      name: userCreatedEvents[index].data['name'],
                      desc: userCreatedEvents[index].data['description'],
                      loc: userCreatedEvents[index].data['location'],
                      datetime: userCreatedEvents[index].data['datetime'],
                      guest: userCreatedEvents[index].data['guests'],
                      sponsers: userCreatedEvents[index].data['sponsers'],
                      isInPerson: userCreatedEvents[index].data['isInPerson'],
                      docID: userCreatedEvents[index].$id,
                    ),
                  ),
                ),
                icon: const Icon(Icons.edit),
                color: kPrimary,
              )),
        ),
      ),
    );
  }
}

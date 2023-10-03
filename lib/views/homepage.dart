import 'package:appwrite/models.dart';
import 'package:eventhub/auth.dart';
import 'package:eventhub/colors/colors.dart';
import 'package:eventhub/database.dart';
import 'package:eventhub/saved_data.dart';
import 'package:eventhub/views/create_event_page.dart';
import 'package:eventhub/views/event_details.dart';
import 'package:eventhub/views/login.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = 'User';

  List<Document> events = [];
  @override
  void initState() {
    userName = SaveData.getUserName().split('')[0];
    _refresh();
    super.initState();
  }

  void _refresh() {
    getAllEvents().then(
      (value) {
        events = value;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kTransparent,
          foregroundColor: kTransparent,
          actions: [
            IconButton(
              onPressed: () {
                logoutUser();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              icon: const Icon(Icons.logout),
              color: kPrimary,
              iconSize: 30,
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  'EventHub',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetails(data: events[index]),
                    ),
                  ),
                  leading: Text(
                    '${index + 1}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  title: Text(
                    events[index].data["name"],
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    events[index].data["location"],
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                childCount: events.length,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateEventPage(),
              ),
            );
            _refresh();
          },
          backgroundColor: kPrimary,
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
    );
  }
}

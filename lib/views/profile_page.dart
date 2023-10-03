import 'package:eventhub/auth.dart';
import 'package:eventhub/colors/colors.dart';
import 'package:eventhub/saved_data.dart';
import 'package:eventhub/views/login.dart';
import 'package:eventhub/views/rsvp_events.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = "";
  String email = "";
  @override
  void initState() {
    super.initState();
    name = SaveData.getUserName();
    email = SaveData.getUserEmail();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, left: 10, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    email,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: kAppTheme,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: kPrimaryInactive,
                      blurRadius: 5,
                      spreadRadius: 0.5,
                      blurStyle: BlurStyle.solid,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RSVPEvents(),
                          ),
                        );
                      },
                      title: Text(
                        'RSVP Events',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Manage Events',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        logoutUser();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      title: Text(
                        'Logout Events',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

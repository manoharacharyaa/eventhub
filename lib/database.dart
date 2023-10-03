// ignore_for_file: avoid_print

import 'package:appwrite/appwrite.dart';
import 'package:eventhub/auth.dart';
import 'package:eventhub/saved_data.dart';

String databaseId = '6519a51fb6b991bad094';

final Databases database = Databases(client);

//Save the user data in appwrite DB
Future<void> saveUserData(String name, String email, String userId) async {
  return await database
      .createDocument(
          databaseId: databaseId,
          collectionId: '6519a5356dafabb4310f',
          documentId: ID.unique(),
          data: {
            'name': name,
            'email': email,
            'userId': userId,
          })
      .then((value) => print('Document Created'))
      .catchError((e) => print(e));
}

//get user data from database
Future getUserData() async {
  final id = SaveData.getUserId();
  try {
    final data = await database.listDocuments(
      databaseId: databaseId,
      collectionId: '6519a5356dafabb4310f',
      queries: [Query.equal('userId', id)],
    );
    SaveData.saveUserName(data.documents[0].data['name']);
    SaveData.saveUserEmail(data.documents[0].data['email']);
    print(data);
  } catch (e) {
    print(e);
  }
}

//Create new events
Future<void> createEvent(
  String name,
  String desc,
  String image,
  String location,
  String datetime,
  String createdBy,
  bool isPerson,
  String guest,
  String sponsers,
) async {
  return await database
      .createDocument(
        databaseId: databaseId,
        collectionId: '651a83fdaad202984933',
        documentId: ID.unique(),
        data: {
          "name": name,
          "description": desc,
          "image": image,
          "location": location,
          "datetime": datetime,
          "createdBy": createdBy,
          "isInPerson": isPerson,
          "guests": guest,
          "sponsers": sponsers,
        },
      )
      .then((value) => print('Event Created'))
      .catchError((e) => print(e));
}

//Read all events from DB
Future getAllEvents() async {
  try {
    final data = await database.listDocuments(
      databaseId: databaseId,
      collectionId: '651a83fdaad202984933',
    );
    return data.documents;
  } catch (e) {
    print(e);
  }
}

//rsvp an event
Future rsvpEvent(List participants, String documentId) async {
  final userId = SaveData.getUserId();
  participants.add(userId);
  try {
    await database.updateDocument(
      databaseId: databaseId,
      collectionId: '651a83fdaad202984933',
      documentId: documentId,
      data: {
        "participants": participants,
      },
    );
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

//list all events created by the user
Future manageEvents() async {
  final userId = SaveData.getUserId();
  try {
    final data = await database.listDocuments(
        databaseId: databaseId,
        collectionId: '651a83fdaad202984933',
        queries: [Query.equal("createdBy", userId)]);
    return data.documents;
  } catch (e) {
    print(e);
  }
}

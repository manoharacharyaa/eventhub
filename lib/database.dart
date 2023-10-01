// ignore_for_file: avoid_print

import 'package:appwrite/appwrite.dart';
import 'package:eventhub/auth.dart';

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
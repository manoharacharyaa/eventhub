// ignore_for_file: unused_local_variable, unused_catch_clause

import 'package:appwrite/appwrite.dart';

//Appwrite Initilisation
Client client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('65192055e6e15fcbc9e5')
    .setSelfSigned(
      status: true,
    ); // For self signed certificates, only use for development

//Sign Up
Account account = Account(client);

Future<String> createUser(String name, String email, String password) async {
  try {
    final user = await account.create(
      userId: ID.unique(),
      name: '',
      email: '',
      password: '',
    );
    return 'sucess';
  } on AppwriteException catch (e) {
    return e.message.toString();
  }
}

//Login
Future loginUser(String email, String password) async {
  try {
    final user =
        await account.createEmailSession(email: email, password: password);
  } on AppwriteException catch (e) {
    return false;
  }
}

//Logout
Future logoutUser() async {
  await account.deleteSession(sessionId: 'current');
}

//Check if any user have an active session
Future checkSession() async {
  try {
    await account.getSession(sessionId: 'current');
    return true;
  } on AppwriteException catch (e) {
    return false;
  }
}

import 'package:appwrite/appwrite.dart';

//Appwrite Initilisation
Client client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('65192055e6e15fcbc9e5')
    .setSelfSigned(
        status: true); // For self signed certificates, only use for development
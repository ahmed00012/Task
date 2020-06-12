import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:task/profile.dart';

class ApiProvider {
  String api = 'https://run.mocky.io/v3/3a1ec9ff-6a95-43cf-8be7-f5daa2122a34';
  Profile profile;




  getResponse() async {

    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request = await client.getUrl(Uri.parse(api));
    request.headers.set('content-type', 'application/json');
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    var decoded = json.decode(reply);
      profile = Profile(
           decoded['img'],
          decoded['date'],
           decoded['title'],
          decoded['address'],
          decoded['price'],
           decoded['interest'],
           decoded['occasionDetail'],
          decoded['trainerName'],
           decoded['trainerImg'],
           decoded['trainerInfo']);
      return profile;

  }
}

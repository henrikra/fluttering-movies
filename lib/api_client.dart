import 'dart:io';
import 'dart:convert';

import 'api_key.dart';

agent(String url) async {
  var httpClient = new HttpClient();
  var uri = new Uri.https('api.themoviedb.org', url, {
    'api_key': apiKey,
  });
  var request = await httpClient.getUrl(uri);
  var response = await request.close();
  var responseBody = await response.transform(UTF8.decoder).join();
  Map data = JSON.decode(responseBody);
  return data;
}

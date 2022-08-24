import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:wherebus/tools/get_bus_json_model.dart'
    as getBusJsonModelPackage;

import '../auth/secrets.dart';

class GetBusController extends GetxController {
  GetBusController({required this.email});

  String email;

  var url = Uri.parse('${MONGODB_URL_BASE}action/find');

  Future<getBusJsonModelPackage.GetBusJsonModel> getBuses(
      String ownerEmail) async {
    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.postUrl(url);
    request.headers.set('Content-Type', 'application/json');
    request.headers.set('api-key', MONGODB_API_KEY);
    request.add(utf8.encode(json.encode({
      'dataSource': 'Cluster0',
      'database': 'WhereBus',
      'collection': 'buses',
      'filter': {"owner": ownerEmail}
    })));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    // print(reply);
    // var jsonReply = json.decode(reply);
    httpClient.close();

    if (response.statusCode == 200) {
      return getBusJsonModelPackage.getBusJsonModelFromJson(reply);
    } else {
      return getBusJsonModelPackage
          .getBusJsonModelFromJson(json.encode(<String, dynamic>{
        'documents': [
          {'_id': 'Error'}
        ]
      }));
    }
  }

  List<getBusJsonModelPackage.Document> _allBusesList = [];
  List<getBusJsonModelPackage.Document> get allBusesList => _allBusesList;

  Future<void> getBusesList() async {
    getBusJsonModelPackage.GetBusJsonModel busesList = await getBuses(email);
    _allBusesList = [];
    _allBusesList.addAll(busesList.documents);
    // print('Got Data Successfully');
    // print(_allBusesList);
    update();
    // print('Number of Buses = ${_allBusesList.length}');
    // print('Number of Buses = ${_allBusesList.first.busType}');
  }
}

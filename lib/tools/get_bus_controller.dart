import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:wherebus/tools/get_bus_json_model.dart'
    as get_bus_json_model;

import '../auth/secrets.dart';

class GetBusController extends GetxController {
  GetBusController({required this.email});

  String email;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;


  var url = Uri.parse('${mongodburlbase}action/find');

  Future<get_bus_json_model.GetBusJsonModel> getBuses(
      String ownerEmail) async {
    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.postUrl(url);
    request.headers.set('Content-Type', 'application/json');
    request.headers.set('api-key', mongodbapikey);
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
      return get_bus_json_model.getBusJsonModelFromJson(reply);
    } else {
      return get_bus_json_model
          .getBusJsonModelFromJson(json.encode(<String, dynamic>{
        'documents': [
          {'_id': 'Error'}
        ]
      }));
    }
  }

  List<get_bus_json_model.Document> _allBusesList = [];
  List<get_bus_json_model.Document> get allBusesList => _allBusesList;

  Future<void> getBusesList() async {
    get_bus_json_model.GetBusJsonModel busesList = await getBuses(email);
    _allBusesList = [];
    _allBusesList.addAll(busesList.documents);
    // print('Got Data Successfully');
    // print(_allBusesList);
    _isLoaded = true;
    update();
    // print('Number of Buses = ${_allBusesList.length}');
    // print('Number of Buses = ${_allBusesList.first.busType}');
  }
}

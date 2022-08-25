// To parse this JSON data, do
//
//     final getBusJsonModel = getBusJsonModelFromJson(jsonString);

import 'dart:convert';

GetBusJsonModel getBusJsonModelFromJson(String str) =>
    GetBusJsonModel.fromJson(json.decode(str));

String getBusJsonModelToJson(GetBusJsonModel data) =>
    json.encode(data.toJson());

class GetBusJsonModel {
  GetBusJsonModel({
    required this.documents,
  });

  List<Document> documents;

  factory GetBusJsonModel.fromJson(Map<String, dynamic> json) {
    if (json['documents'] == null) {
      return GetBusJsonModel(
        documents: [Document(id: 'Empty')],
      );
    } else {
      return GetBusJsonModel(
        documents: List<Document>.from(
            json["documents"].map((x) => Document.fromJson(x))),
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
      };
}

class Document {
  Document({
    required this.id,
    this.owner,
    this.busRegNo,
    this.busNumberOfSeats,
    this.busDriverContact,
    this.busType,
    this.bookable,
  });

  String id;
  String? owner;
  String? busRegNo;
  String? busNumberOfSeats;
  String? busDriverContact;
  String? busType;
  String? bookable;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["_id"],
        owner: json["owner"],
        busRegNo: json["busRegNo"],
        busNumberOfSeats: json["busNumberOfSeats"],
        busDriverContact: json["busDriverContact"],
        busType: json["busType"],
        bookable: json["bookable"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "owner": owner,
        "busRegNo": busRegNo,
        "busNumberOfSeats": busNumberOfSeats,
        "busDriverContact": busDriverContact,
        "busType": busType,
        "bookable": bookable,
      };
}

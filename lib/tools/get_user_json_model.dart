// To parse this JSON data, do
//
//     final getUserJsonModel = getUserJsonModelFromJson(jsonString);

import 'dart:convert';

GetUserJsonModel getUserJsonModelFromJson(String str) {
  // print(str);
  return GetUserJsonModel.fromJson(json.decode(str));
}

String getUserJsonModelToJson(GetUserJsonModel data) =>
    json.encode(data.toJson());

class GetUserJsonModel {
  GetUserJsonModel({
    required this.document,
  });

  Document document;

  factory GetUserJsonModel.fromJson(Map<String, dynamic> json) {

    if(json["document"] == null) {
      return GetUserJsonModel(document: Document(id: 'Empty'));
    } else {
      return GetUserJsonModel(
      document: Document.fromJson(json["document"]),
    );
    }
  }

  Map<String, dynamic> toJson() => {
        "document": document.toJson(),
      };
}

class Document {
  Document({
    required this.id,
    this.fname,
    this.lname,
    this.email,
    this.password,
    this.phone,
    this.acctype,
  });

  String id;
  String? fname;
  String? lname;
  String? email;
  String? password;
  String? phone;
  String? acctype;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["_id"],
        fname: json["fname"],
        lname: json["lname"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        acctype: json["acctype"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fname": fname,
        "lname": lname,
        "email": email,
        "password": password,
        "phone": phone,
        "acctype": acctype,
      };
}

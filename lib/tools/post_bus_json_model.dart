// To parse this JSON data, do
//
//     final postBusJsonModel = postBusJsonModelFromJson(jsonString);

import 'dart:convert';

PostBusJsonModel postBusJsonModelFromJson(String str) => PostBusJsonModel.fromJson(json.decode(str));

String postBusJsonModelToJson(PostBusJsonModel data) => json.encode(data.toJson());

class PostBusJsonModel {
    PostBusJsonModel({
        required this.insertedId,
    });

    String insertedId;

    factory PostBusJsonModel.fromJson(Map<String, dynamic> json) => PostBusJsonModel(
        insertedId: json["insertedId"],
    );

    Map<String, dynamic> toJson() => {
        "insertedId": insertedId,
    };
}

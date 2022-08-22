// To parse this JSON data, do
//
//     final postUserJsonModel = postUserJsonModelFromJson(jsonString);

import 'dart:convert';

PostUserJsonModel postUserJsonModelFromJson(String str) => PostUserJsonModel.fromJson(json.decode(str));

String postUserJsonModelToJson(PostUserJsonModel data) => json.encode(data.toJson());

class PostUserJsonModel {
    PostUserJsonModel({
        required this.insertedId,
    });

    String insertedId;

    factory PostUserJsonModel.fromJson(Map<String, dynamic> json) => PostUserJsonModel(
        insertedId: json["insertedId"],
    );

    Map<String, dynamic> toJson() => {
        "insertedId": insertedId,
    };
}

import 'package:nche/model/users.dart';

class FeedPost {
  String writeUp;
  List? avarter;
  DateTime time;
  Users sender;
  List? upLike;
  List? downLike;
  String id;
  String? location;
  String? incidentType;
  String? isAnanymous;
  FeedPost({
    required this.id,
    required this.writeUp,
    this.avarter,
    required this.time,
    this.isAnanymous,
    this.downLike,
    this.incidentType,
    this.location,
    required this.sender,
    this.upLike,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'sender': sender,
        'location': location,
        'time': time.toIso8601String(),
        'writeUp': writeUp,
        'avarter': avarter,
        'downLike': downLike,
        'upLike': upLike,
        'isAnanymous': isAnanymous,
        'incidentType': incidentType,
      };
  factory FeedPost.fromJson(Map<String, dynamic> json) => FeedPost(
        writeUp: json['writeUp'],
        sender: json['sender'],
        time: DateTime.parse(json["time"]),
        id: json['id'],
        avarter: json['avarter'],
        downLike: json['downLike'],
        incidentType: json['incidentType'],
        isAnanymous: json['isAnanymous'],
        location: json['location'],
        upLike: json['upLike'],
      );
}

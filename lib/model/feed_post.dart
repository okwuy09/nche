import 'package:nche/model/users.dart';

class FeedPost {
  String writeUp;
  List? avarter;
  DateTime time;
  Users sender;
  List? upLike;
  List? downLike;
  List? savePost;
  String id;
  String? location;
  String? incidentType;
  bool isAnanymous;
  FeedPost({
    required this.id,
    required this.writeUp,
    this.avarter,
    required this.time,
    this.isAnanymous = false,
    this.downLike,
    this.incidentType,
    this.location,
    required this.sender,
    this.upLike,
    this.savePost,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'sender': sender.toJson(),
        'location': location,
        'time': time.toIso8601String(),
        'writeUp': writeUp,
        'avarter': avarter,
        'downLike': downLike,
        'upLike': upLike,
        'save_post': savePost,
        'isAnanymous': isAnanymous,
        'incidentType': incidentType,
      };
  static FeedPost fromJson(Map<String, dynamic> json) => FeedPost(
        writeUp: json['writeUp'],
        sender: Users.fromJson(json['sender']),
        time: DateTime.parse(json["time"]),
        id: json['id'],
        avarter: json['avarter'],
        downLike: json['downLike'],
        incidentType: json['incidentType'],
        isAnanymous: json['isAnanymous'],
        location: json['location'],
        upLike: json['upLike'],
        savePost: json['save_post'],
      );
}

class ChatAgency {
  String name;
  String messageText;
  String avarter;
  DateTime time;
  String? id;
  ChatAgency(
      {this.id,
      required this.name,
      required this.messageText,
      required this.avarter,
      required this.time});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'time': time.toIso8601String(),
        'messageText': messageText,
        'avarter': avarter,
      };
  factory ChatAgency.fromJson(Map<String, dynamic> json) => ChatAgency(
        messageText: json['messageText'],
        name: json['name'],
        time: DateTime.parse(json["time"]),
        id: json['id'],
        avarter: json['avarter'],
      );
}

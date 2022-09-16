class EmergencyContact {
  String friendName;
  String friendPhone;
  EmergencyContact({
    required this.friendName,
    required this.friendPhone,
  });

  Map<String, dynamic> toJson() => {
        'name': friendName,
        'phone': friendPhone,
      };

  static EmergencyContact fromJson(Map<String, dynamic> json) =>
      EmergencyContact(
        friendName: json['name'],
        friendPhone: json['phone'],
      );
}

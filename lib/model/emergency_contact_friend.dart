class EmergencyContactFriend {
  final String name;
  final String phone;
  bool approved = false;
  EmergencyContactFriend({
    required this.name,
    required this.phone,
    required this.approved,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'approved': approved,
      };

  static EmergencyContactFriend fromJson(Map<String, dynamic> json) =>
      EmergencyContactFriend(
        name: json['name'],
        phone: json['phone'],
        approved: json['approved'],
      );
}

class UserFriends {
  final String id;
  final String userId;
  final String searchName;
  final List<EmergencyContactFriend> userFriends;

  UserFriends({
    required this.id,
    required this.userFriends,
    required this.userId,
    required this.searchName,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'searchName': searchName,
        'userFriends': userFriends.map((e) => e.toJson()).toList(),
      };

  static UserFriends fromJson(Map<String, dynamic> json) {
    final contactData = json['userFriends'] as List;
    return UserFriends(
      id: json['id'],
      userId: json['userId'],
      searchName: json['searchName'],
      userFriends: contactData
          .map((data) => EmergencyContactFriend.fromJson(data))
          .toList(),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String? email;
  String? fullName;
  String? userName;
  String? userCity;
  String id;
  String? phoneNumber;
  String? countryState;
  String? avarter;
  GeoPoint? location;
  List? emergencyContact;
  Users({
    required this.id,
    this.email,
    this.fullName,
    this.userName,
    this.countryState,
    this.phoneNumber,
    this.avarter,
    this.userCity,
    this.location,
    this.emergencyContact,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'userName': userName,
        'userCity': userCity,
        'email': email,
        'countryState': countryState,
        'phoneNumber': phoneNumber,
        'avarter': avarter,
        'location': location,
        'emergencyContact': emergencyContact,
      };

  static Users fromJson(Map<String, dynamic> json) => Users(
      email: json['email'],
      fullName: json['fullName'],
      id: json['id'],
      userName: json['userName'],
      userCity: json['userCity'],
      countryState: json['countryState'],
      phoneNumber: json['phoneNumber'],
      avarter: json['avarter'],
      location: json['location'],
      emergencyContact: json['emergencyContact']);
}

import 'package:flutter/widgets.dart';

class UserModel with ChangeNotifier {
  String name;
  String profileImage;
  String about;
  String uId;
  String phoneNumber;
  List<String> groupIds;
  bool isOnline;
  UserModel({
    required this.about,
    required this.name,
    required this.uId,
    required this.phoneNumber,
    required this.profileImage,
    required this.groupIds,
    this.isOnline = true,
  });
}

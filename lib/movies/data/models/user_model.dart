import 'package:movies_app/movies/domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {super.userId,
      super.email,
      super.name,
      super.pic,
      super.fav,
      super.favIds});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json['userId'],
        email: json['email'],
        name: json['name'],
        pic: json['pic'],
        fav: json['favourite'],
        favIds: json['favIds'],
      );

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'pic': pic,
      'favourite': fav,
      'favIds': favIds,
    };
  }
}

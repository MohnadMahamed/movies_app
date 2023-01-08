import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? userId, email, name, pic;
  final dynamic fav;
  final dynamic favIds;

  const User(
      {this.fav, this.favIds, this.userId, this.email, this.name, this.pic});

  @override
  List<Object?> get props => [userId, email, name, pic, fav, favIds];
}

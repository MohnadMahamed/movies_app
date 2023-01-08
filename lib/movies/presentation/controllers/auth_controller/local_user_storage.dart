import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/core/utils/app_string.dart';
import 'package:movies_app/movies/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalUserStorageData extends GetxController {
  Future<UserModel> get getUser async {
    try {
      UserModel userModel = await _getUserData();
      // if (userModel == null) {
      //   return UserModel();
      // }
      return userModel;
    } catch (e) {
      debugPrint(e.toString());
      return const UserModel();
    }
  }

  _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(AppString.cachedUserData);
    return UserModel.fromJson(jsonDecode(value!));
  }

  setUser(UserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        AppString.cachedUserData, jsonEncode(userModel.toJson()));
  }

  void deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

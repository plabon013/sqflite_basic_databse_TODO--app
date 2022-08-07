import 'package:flutter/material.dart';

import '../db/db_todo.dart';
import '../model/user_model.dart';

class UserProvider extends ChangeNotifier {
  List<UserModel> userList = [];

  Future<void> getAllUsers() async {
    userList = await DBTodo.getAllUsers();
  }

  Future<bool> addNewUser(UserModel userModel) async {
    final rowId = await DBTodo.createUser(userModel);
    var tag = false;

    for (var element in userList) {
      // print(element.userName);
      if (userModel.userName == element.userName) {
        tag = true;
        break;
      }
    }
    if (tag) {
      throw 'User exists';
    } else {
      if (rowId > 0) {
        userModel.userID = rowId;
        userList.add(userModel);
        notifyListeners();
        return true;
      }
      return false;
    }
  }

  bool loginUser(UserModel userModel) {
    var tag = false;

    // print(userList.toString());
    for (var element in userList) {
      // print(element.userName);
      if (userModel.userName == element.userName) {
        tag = true;
        break;
      }
    }
    return tag;
  }
}

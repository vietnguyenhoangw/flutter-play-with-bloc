import 'package:flutter_play_with_bloc/contants/error_list.dart';
import 'package:flutter_play_with_bloc/modals/todo_user.dart';
import 'package:flutter_play_with_bloc/modals/todo_user_rp.dart';
import 'package:flutter_play_with_bloc/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final baseUrl = "https://api-nodejs-todolist.herokuapp.com";

class TodoApi {
  Future<dynamic> todoLoginAPI(
      {Function(String)? onError,
      required String username,
      required String password}) async {
    try {
      String endpoint = baseUrl + "/user/login";
      http.Response response = await http.post(Uri.parse(endpoint),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json"
          },
          body: jsonEncode({
            "email": "muh.nurali43@gmail.com",
            "password": "12345678",
            // "email": username.toString(),
            // "password": password.toString()
          }));
      dynamic bodyResponse = json.decode(response.body);
      if (bodyResponse != TodoErrorList.unable_to_login) {
        TodoUserRP allUserData = TodoUserRP.fromJson(bodyResponse);
        return allUserData;
      } else {
        // return errorr unable_to_login
        String error = response.body;
        return error.substring(1, error.length - 1);
      }
    } catch (e) {
      return ("Something get wrong! Status code ${e.toString()}");
    }
  }

  Future<dynamic> todoListFetchedAPI(
      {Function(String)? onError,
      required int limit,
      required int skip}) async {
    try {
      String userToken =
          SpUtil().getStringFromLocal(SpUtilKey.userToken.toString()) as String;
      print(']]]]]]]]]]]]]]] USERTOKEN: ${userToken}');

      String endpoint = baseUrl + "/task?limit=$limit&skip=$skip";
      http.Response response = await http.post(
        Uri.parse(endpoint),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
      );
      // dynamic bodyResponse = json.decode(response.body);
      // if (bodyResponse != TodoErrorList.unable_to_login) {
      //   dynamic rawUser = bodyResponse["user"];
      //   TodoUser userData = TodoUser.fromJson(rawUser);
      //   return userData;
      // } else {
      //   // return errorr unable_to_login
      //   String error = response.body;
      //   return error.substring(1, error.length - 1);
      // }
    } catch (e) {
      return ("Something get wrong! Status code ${e.toString()}");
    }
  }
}

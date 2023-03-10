import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';

// To seperate our ui logic from business part
// No need of buildcontext in stateful widget


class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      User user = User(
          email: email,
          id: '',
          name: name,
          password: password,
          address: '',
          type: '',
          token: '');

      http.Response response = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'});
      // print(response.body);
      // print(response.statusCode);

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Account created! Login with same credentials');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

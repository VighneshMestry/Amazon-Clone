import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/feautres/home/screens/home_screen.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';

// To seperate our ui logic from business part
// No need of buildcontext in stateful widget

class AuthService {
  // sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        address: '',
        type: '',
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          //Provider stores the information of the user temporarily
          //listen:false because Provider is used outside the build function
          // ignore: use_build_context_synchronously
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          // ignore: use_build_context_synchronously
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    void getUserData(
      BuildContext context,
    ) async {
      try {

        SharedPreferences prefs = await SharedPreferences.getInstance();
        // The value of the token can be null when the user is logging in for the first time, otherwise the user can be kept logged in.
        String? token = prefs.getString('x-auth-token');
        
        if(token == null) {
          prefs.setString('x-auth-token', '');
        }
        
        final tokenRes = await http.post(Uri.parse('$uri/isTokenValid'), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token' : token!,
        });

        // http.Response res = await http.post(
        //   Uri.parse('$uri/api/signin'),
        //   body: jsonEncode({
        //     'email': email,
        //     'password': password,
        //   }),
        //   headers: <String, String>{
        //     'Content-Type': 'application/json; charset=UTF-8',
        //   },
        // );
        // httpErrorHandle(
        //   response: res,
        //   context: context,
        //   onSuccess: () async {
        //     SharedPreferences prefs = await SharedPreferences.getInstance();

        //     //Provider stores the information of the user temporarily
        //     //listen:false because Provider is used outside the build function
        //     // ignore: use_build_context_synchronously
        //     Provider.of<UserProvider>(context, listen: false).setUser(res.body);
        //     await prefs.setString(
        //         'x-auth-token', jsonDecode(res.body)['token']);
        //     // ignore: use_build_context_synchronously
        //     Navigator.pushNamedAndRemoveUntil(
        //       context,
        //       HomeScreen.routeName,
        //       (route) => false,
        //     );
        //   },
        // );
      } catch (e) {
        showSnackBar(context, e.toString());
      }
    }
  }
}

import 'package:amazon_clone/models/user.dart';
import 'package:http/http.dart' as http;

import '../../constants/global_variables.dart';


// To seperate our ui logic from business part
class AuthService {
  void signUpUser({
    required String email,
    required String name,
    required String password,
  }) {
    try {
      User user = User(
          email: email,
          id: '',
          name: name,
          password: password,
          address: '',
          type: '',
          token: '');

      http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
      );
    } catch (e) {}
  }
}

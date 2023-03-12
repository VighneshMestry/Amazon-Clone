import 'package:amazon_clone/models/user.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    email: '',
    id: '',
    name: '',
    password: '',
    address: '',
    type: '',
    token: '',
  );

  User get user => _user;

  // String user because res.body which is in the form of a String will be passed to the function. 
  void setUser (String user){
    _user = User.fromJson(user);
    notifyListeners();
  }
}

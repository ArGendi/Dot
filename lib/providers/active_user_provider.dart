import 'package:ecommerce/models/User.dart';
import 'package:flutter/cupertino.dart';

class ActiveUserProvider extends ChangeNotifier {
  User _activeUser = new User();

  User get activeUser => _activeUser;

}
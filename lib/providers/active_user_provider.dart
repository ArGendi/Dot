import 'package:ecommerce/models/user.dart';
import 'package:flutter/cupertino.dart';

class ActiveUserProvider extends ChangeNotifier {
  AppUser _activeUser = new AppUser();

  AppUser get activeUser => _activeUser;

  setActiveUser(AppUser user){
    _activeUser = user;
    notifyListeners();
  }

  setCountry(String country){
    _activeUser.country = country;
    notifyListeners();
  }

}
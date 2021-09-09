class AppUser {
  String id = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';
  String country = '';
  String language = '';
  String phoneNumber = '';
  String imageUrl = '';
  String token = '';

  AppUser({this.firstName = '', this.lastName = '', this.email = '', this.password = '',
        this.id = '', this.token = '', this.imageUrl = '', this.country = ''});

  setFromJson(Map<String, dynamic> json){
    id = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastname'];
    email = json['email'];
    token = json['token'];
  }
}
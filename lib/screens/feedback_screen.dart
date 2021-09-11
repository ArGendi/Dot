import 'dart:convert';

import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/providers/active_user_provider.dart';
import 'package:ecommerce/providers/all_products_provider.dart';
import 'package:ecommerce/services/web_services.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:ecommerce/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class FeedBack extends StatefulWidget {
  final Product product;

  const FeedBack({Key? key, required this.product}) : super(key: key);

  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  String _comment = '';
  double _rate = 3.0;
  final _formKey = GlobalKey<FormState>();
  WebServices _webServices = new WebServices();

  _setComment(String comment) {
    _comment = comment;
  }

  showMsgDialog(String text){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(text),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(
                        color: primaryColor
                    ),
                  )
              ),
            )
          ],
        );
      },
    );
  }

  _onSubmit(BuildContext context) async{
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    print(_comment);
    print(_rate);
    var token = Provider.of<ActiveUserProvider>(context, listen: false).activeUser.token;
    var response = await _webServices.postWithBearerToken('https://souk-team-server.herokuapp.com/api/review/${widget.product.slug}',
        token, {
          "rating": _rate,
          "comment": _comment,
        });
    if(response.statusCode >=200 && response.statusCode < 300){
      showMsgDialog('Thanks for your review :)');
    }
    else {
      var body = jsonDecode(response.body);
      showMsgDialog(body['err']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Feedback',
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  color: Colors.grey[300],
                  child: widget.product.images.length > 0 ? Image.network(
                    widget.product.images[0],
                    fit: BoxFit.cover,
                  ) : Container(),
                ),
                SizedBox(height: 10,),
                Text(
                  widget.product.name,
                  style: TextStyle(
                    fontSize: 18,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20,),
                Text(
                  'Rate this product now',
                  style: TextStyle(),
                ),
                SizedBox(height: 5,),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    _rate = rating;
                  },
                ),
                SizedBox(height: 30,),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Have any comments?',
                        style: TextStyle(),
                      ),
                      SizedBox(height: 5,),
                      CustomTextField(
                        text: 'Write your comment here',
                        obscureText: false,
                        textInputType: TextInputType.text,
                        setValue: _setComment,
                        validation: (value) {
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Text(
                  'Thanks for your time have a good day :)',
                  style: TextStyle(),
                ),
                SizedBox(height: 10,),
                CustomButton(
                  text: 'Submit',
                  onclick: (){
                    _onSubmit(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

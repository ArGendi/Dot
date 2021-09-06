import 'dart:convert';
import 'package:ecommerce/services/web_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Currency {
  WebServices _webServices = new WebServices();

  Future<String> doConversion(BuildContext context) async {
    print(0);
    Locale locale = Localizations.localeOf(context);
    NumberFormat format = NumberFormat.simpleCurrency(locale: locale.toString());
    String toCurrency = format.currencyName.toString();
    print(1);
    var response = await _webServices.get('https://api.exchangeratesapi.io/latest?base=USD&symbols=$toCurrency');
    print(2);
    var body = json.decode(response.body);
    String result = body["rates"][toCurrency].toString();
    return result;
  }

}
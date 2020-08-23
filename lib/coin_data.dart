import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<Map> getResponse(var selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    var key = '78BFD45B-B69B-4051-BBF3-05CB88063641';
    for (String coin in cryptoList) {
      var url =
          'http://rest.coinapi.io/v1/exchangerate/$coin/$selectedCurrency?apikey=$key';
      print(url);
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var exchangeData = jsonDecode(response.body);
        double price = exchangeData['rate'];
        cryptoPrices[coin] = price.toStringAsFixed(2);
      } else {
        print(response.statusCode);
      }
    }
    print(cryptoPrices);
    return cryptoPrices;
  }
}

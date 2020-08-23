import 'dart:html';

import 'package:bitcoin_ticker/networking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  var coin = 'BTC';

  List<Widget> getDropDownItems() {
    List<Text> dropDownList = [];
    for (String currency in currenciesList) {
      dropDownList.add(Text(
        currency,
        style: TextStyle(color: Colors.white),
      ));
    }
//    if (Platform.isAndroid)
    return dropDownList;
  }

  Future<dynamic> getExchangeRate(var coin, var selectedCurrency) async {
    var url =
        'http://rest.coinapi.io/v1/exchangerate/$coin/$selectedCurrency?apikey=2C099656-D363-4C1E-BDBA-5039B8A78434#';
    NetworkHelper networkHelper = NetworkHelper(url);
    var exchangeData = networkHelper.getData();
    return exchangeData;
  }

  @override
  Widget build(BuildContext context) {
    getDropDownItems();
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: CupertinoPicker(
                backgroundColor: Colors.lightBlue,
                itemExtent: 32.0,
                onSelectedItemChanged: (selectedIndex) {
                  setState(() {
//                    selectedCurrency = value;
                  });
                },
                children: getDropDownItems()),
          ),
        ],
      ),
    );
  }
}

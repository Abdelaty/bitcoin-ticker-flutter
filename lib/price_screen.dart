import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency;
  var rate;

  List<Widget> getDropDownItems() {
    List<Text> dropDownList = [];
    for (String currency in currenciesList) {
      dropDownList.add(Text(
        currency,
        style: TextStyle(color: Colors.white),
      ));
    }

    return dropDownList;
  }

  @override
  Widget build(BuildContext context) {
    getDropDownItems();
    CoinData coinData = CoinData();
    rate = coinData.getResponse(selectedCurrency);
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ListOfCards(),
          Container(
            height: 150.0,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: CupertinoPicker(
                backgroundColor: Colors.lightBlue,
                itemExtent: 32.0,
                onSelectedItemChanged: (selectedIndex) {
                  setState(() {
                    selectedCurrency = currenciesList[selectedIndex];
                    print(selectedCurrency);
                  });
                },
                children: getDropDownItems()),
          ),
        ],
      ),
    );
  }

  Column ListOfCards() {
    List<CoinCard> cardsList = [];
    for (String item in cryptoList) {
      cardsList.add(
        CoinCard(
          cryptoCurrency: item,
          selectedCurrency: selectedCurrency,
          rate: rate,
        ),
      );
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, children: cardsList);
  }
}

class CoinCard extends StatelessWidget {
  const CoinCard({
    Key key,
    @required this.rate,
    @required this.selectedCurrency,
    @required this.cryptoCurrency,
  }) : super(key: key);

  final rate;
  final String selectedCurrency;
  final cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $rate $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

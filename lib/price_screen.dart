import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selected = "AUD";
  int btc = 0;
  int eth = 0;
  int ltc = 0;

  List<DropdownMenuItem<String>> getCurrency() {
    List<DropdownMenuItem<String>> currencyItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      currencyItems.add(newItem);
    }
    return currencyItems;
  }

  List<Widget> getCupertinoList() {
    List<Widget> currencyList = [];
    for (String currency in currenciesList) {
      var newWidget = Text(
        currency,
        style: TextStyle(
          color: Colors.white,
        ),
      );
      currencyList.add(newWidget);
    }
    return currencyList;
  }

  void getBTCJson(String currency) async {
    var url =
        Uri.parse('https://rest.coinapi.io/v1/exchangerate/BTC/$currency');
    var headers = {'X-CoinAPI-Key': '88743EE3-1524-4216-9CD5-E17BDE084024'};
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var conv = ((jsonDecode(response.body)['rate']).round());
      setState(() {
        btc = conv;
      });
    } else {
      var conv = 0;
    }
  }

  void getETHJson(String currency) async {
    var url =
        Uri.parse('https://rest.coinapi.io/v1/exchangerate/ETH/$currency');
    var headers = {'X-CoinAPI-Key': '88743EE3-1524-4216-9CD5-E17BDE084024'};
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var conv = ((jsonDecode(response.body)['rate']).round());
      setState(() {
        eth = conv;
      });
    } else {
      var conv = 0;
    }
  }

  void getLTCJson(String currency) async {
    var url =
        Uri.parse('https://rest.coinapi.io/v1/exchangerate/LTC/$currency');
    var headers = {'X-CoinAPI-Key': '88743EE3-1524-4216-9CD5-E17BDE084024'};
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var conv = ((jsonDecode(response.body)['rate']).round());
      setState(() {
        ltc = conv;
      });
    } else {
      var conv = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' ₿ Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 BTC = $btc $selected',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 ETH = $eth $selected',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 LTC = $ltc $selected',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(bottom: 10.0),
              color: Colors.lightBlue,
              child: CupertinoPicker(
                itemExtent: 32,
                onSelectedItemChanged: (index) {
                  getBTCJson(currenciesList[index]);
                  getETHJson(currenciesList[index]);
                  getLTCJson(currenciesList[index]);
                  setState(() {
                    selected = currenciesList[index];
                  });
                },
                children: getCupertinoList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// DropdownButton<String>(
// value: selected,
// items: getCurrency(),
// onChanged: (value) {
// setState(() {
// selected = value;
// });
// },
// )

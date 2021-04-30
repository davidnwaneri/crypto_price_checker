import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

CoinData coinData = CoinData();

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String selectedCrypto = 'BTC';

  var f = new NumberFormat('#,###');

  DropdownButton androidDropDown() {
    List<DropdownMenuItem<String>> currencyDropDownMenu = [];
    for (String currencies in currenciesList) {
      var dropDown =
          DropdownMenuItem(child: Text(currencies), value: currencies);
      currencyDropDownMenu.add(dropDown);
    }
    return DropdownButton(
      value: selectedCurrency,
      items: currencyDropDownMenu,
      onChanged: (value) {
        setState(() {
          price = '?';
          selectedCurrency = value;
          chosenCurrency = value;
          getData();
        });
      },
    );
  }

  DropdownButton androidCryptoDropDown() {
    List<DropdownMenuItem<String>> cryptoDropDownMenu = [];
    for (String crypto in cryptoList) {
      var dropDown = DropdownMenuItem(child: Text(crypto), value: crypto);
      cryptoDropDownMenu.add(dropDown);
    }
    return DropdownButton(
      value: selectedCrypto,
      items: cryptoDropDownMenu,
      onChanged: (value) {
        setState(() {
          price = '?';
          selectedCrypto = value;
          chosenCrypto = value;
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> listOfCurrencies = [];
    for (String currencies in currenciesList) {
      var currency = Text(currencies);
      listOfCurrencies.add(currency);
    }
    return CupertinoPicker(
      scrollController: FixedExtentScrollController(initialItem: 20),
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedValue) {
        price = '?';
        selectedCurrency = currenciesList[selectedValue];
        chosenCurrency = currenciesList[selectedValue];
        getData();
      },
      children: listOfCurrencies,
    );
  }

  CupertinoPicker iOSCryptoPicker() {
    List<Text> cryptoPicker = [];
    for (String crypto in cryptoList) {
      var picker = Text(crypto);
      cryptoPicker.add(picker);
    }
    return CupertinoPicker(
      useMagnifier: true,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedValue) {
        price = '?';
        selectedCrypto = cryptoList[selectedValue];
        chosenCrypto = cryptoList[selectedValue];
        getData();
      },
      children: cryptoPicker,
    );
  }

  String price = '?';
  void getData() async {
    try {
      var data = await CoinData().getCoinData();
      setState(() {
        int thePrice = data;
        price = f.format(thePrice);
      });
    } catch (e) {
      print(e);
      print('There was an error!');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
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
                  '1 $selectedCrypto = $price $selectedCurrency',
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
            width: 50.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Platform.isIOS
                    ? Expanded(child: iOSPicker())
                    : androidDropDown(),
                Platform.isIOS
                    ? Expanded(child: iOSCryptoPicker())
                    : androidCryptoDropDown(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

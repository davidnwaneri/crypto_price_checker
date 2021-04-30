// import 'price_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  'NGN',
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

String chosenCrypto = 'BTC';

const apiKey = '7EA9C410-5140-405D-81C3-5D24336B58B9';
const baseURL = 'https://rest.coinapi.io/v1/exchangerate';
String chosenCurrency = 'USD';

class CoinData {
  Future getCoinData() async {
    String url = '$baseURL/$chosenCrypto/$chosenCurrency?apikey=$apiKey';

    // String cryptoCurrency;
    // String purchasingCurrency;

    int cryptoCurrencyPrice;
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      var decodeData = jsonDecode(data);

      // cryptoCurrency = decodeData['asset_id_base'];
      // purchasingCurrency = decodeData['asset_id_quote'];

      double cryptoCurrencyPriceDouble = decodeData['rate'];
      cryptoCurrencyPrice = cryptoCurrencyPriceDouble.toInt();

      // *********** printing data **************
      // print(cryptoCurrency);
      // print(purchasingCurrency);
      // print(cryptoCurrencyPrice);
      return cryptoCurrencyPrice;
    } else {
      print('Error, Status Code: ${response.statusCode}');
    }
  }
}

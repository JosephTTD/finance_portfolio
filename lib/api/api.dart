import 'dart:convert';
import 'package:finance_portfolio/models/portfolio.dart';
import 'package:finance_portfolio/models/trend.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

String apiKey = 'y7vtvjSntG12lD5g7cSWZ4zcszBI1CyZSnBlRYYf';
String baseUrl = 'https://yfapi.net';
String trend = 'v1/finance/trending';
String portfolio = 'v8/finance/chart';

Future<Trend> fetchTrend() async {
  final response = await http.get(
    Uri.parse('$baseUrl/$trend/US/'),
    headers: {
      'x-api-key': apiKey,
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Trend.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception();
  }
}

Future<List<PortfolioModel>> fetchPortfolio({String interval = '', required List ticker}) async {

  //const ticker = ['ABB', 'AAPL', 'GME', 'BMBL', 'MSFT'];

  var value = <PortfolioModel>[];
  var urls = <Future<dynamic>>[];
  
  inspect(ticker);

  for (var i = 0; i < ticker.length; i++) {
    var url = '$baseUrl/$portfolio/' + ticker[i];
    urls.add(http.get(
      Uri.parse(interval.isNotEmpty ? url + '?range=1mo&region=US&interval=$interval&lang=en' : url),
      headers: {
        'x-api-key': apiKey,
      },
    ));
  }

  var results = await Future.wait(urls);

  for (var response = 0; response < results.length; response++) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    value.add(PortfolioModel.fromJson(jsonDecode(results[response].body)));
  } 
   inspect(results);
  return value;
}

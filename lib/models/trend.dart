class Trend {
  Finance? finance;

  Trend({this.finance});

  Trend.fromJson(Map<String, dynamic> json) {
    finance =
        json['finance'] != null ? Finance.fromJson(json['finance']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (finance != null) {
      data['finance'] = finance!.toJson();
    }
    return data;
  }
}

class Finance {
  List<Result>? result;

  Finance({this.result});

  Finance.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? count;
  List<Quotes>? quotes;
  int? jobTimestamp;
  int? startInterval;

  Result({this.count, this.quotes, this.jobTimestamp, this.startInterval});

  Result.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['quotes'] != null) {
      quotes = <Quotes>[];
      json['quotes'].forEach((v) {
        quotes!.add(Quotes.fromJson(v));
      });
    }
    jobTimestamp = json['jobTimestamp'];
    startInterval = json['startInterval'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (quotes != null) {
      data['quotes'] = quotes!.map((v) => v.toJson()).toList();
    }
    data['jobTimestamp'] = jobTimestamp;
    data['startInterval'] = startInterval;
    return data;
  }
}

class Quotes {
  String? symbol;

  Quotes({this.symbol});

  Quotes.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol'] = symbol;
    return data;
  }
}

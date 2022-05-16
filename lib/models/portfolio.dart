class PortfolioModel {
  final Chart? chart;

  PortfolioModel({
    this.chart,
  });

  PortfolioModel.fromJson(Map<String, dynamic> json)
      : chart = (json['chart'] as Map<String, dynamic>?) != null
            ? Chart.fromJson(json['chart'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'chart': chart?.toJson()};
}

class Chart {
  final List<Result>? result;
  final dynamic error;

  Chart({
    this.result,
    this.error,
  });

  Chart.fromJson(Map<String, dynamic> json)
    : result = (json['result'] as List?)?.map((dynamic e) => Result.fromJson(e as Map<String,dynamic>)).toList() ?? [],
      error = json['error'];

  Map<String, dynamic> toJson() => ({
    'result' : result?.map((e) => e.toJson()).toList(),
    'error' : error
  });
}

class Result {
  final Meta? meta;
  final List<int>? timestamp;
  final Indicators? indicators;

  Result({
    this.meta,
    this.timestamp,
    this.indicators,
  });

  Result.fromJson(Map<String, dynamic> json)
      : meta = (json['meta'] as Map<String, dynamic>?) != null
            ? Meta.fromJson(json['meta'] as Map<String, dynamic>)
            : null,
        timestamp =
            (json['timestamp'] as List?)?.map((dynamic e) => e as int).toList(),
        indicators = (json['indicators'] as Map<String, dynamic>?) != null
            ? Indicators.fromJson(json['indicators'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'meta': meta?.toJson(),
        'timestamp': timestamp,
        'indicators': indicators?.toJson()
      };

  where(bool Function(dynamic element) param0) {}
}

class Meta {
  final String? currency;
  final String? symbol;
  final String? exchangeName;
  final String? instrumentType;
  final int? firstTradeDate;
  final int? regularMarketTime;
  final int? gmtoffset;
  final String? timezone;
  final String? exchangeTimezoneName;
  final double? regularMarketPrice;
  final double? chartPreviousClose;
  final double? previousClose;
  final int? scale;
  final int? priceHint;
  final CurrentTradingPeriod? currentTradingPeriod;
  final List<dynamic>? tradingPeriods;
  final String? dataGranularity;
  final String? range;
  final List<String>? validRanges;

  Meta({
    this.currency,
    this.symbol,
    this.exchangeName,
    this.instrumentType,
    this.firstTradeDate,
    this.regularMarketTime,
    this.gmtoffset,
    this.timezone,
    this.exchangeTimezoneName,
    this.regularMarketPrice,
    this.chartPreviousClose,
    this.previousClose,
    this.scale,
    this.priceHint,
    this.currentTradingPeriod,
    this.tradingPeriods,
    this.dataGranularity,
    this.range,
    this.validRanges,
  });

  Meta.fromJson(Map<String, dynamic> json)
      : currency = json['currency'] as String?,
        symbol = json['symbol'] as String?,
        exchangeName = json['exchangeName'] as String? ?? '',
        instrumentType = json['instrumentType'] as String?,
        firstTradeDate = json['firstTradeDate'] as int?,
        regularMarketTime = json['regularMarketTime'] as int?,
        gmtoffset = json['gmtoffset'] as int?,
        timezone = json['timezone'] as String?,
        exchangeTimezoneName = json['exchangeTimezoneName'] as String?,
        regularMarketPrice = json['regularMarketPrice'] as double?,
        chartPreviousClose = json['chartPreviousClose'] as double?,
        previousClose = json['previousClose'] as double?,
        scale = json['scale'] as int?,
        priceHint = json['priceHint'] as int?,
        currentTradingPeriod =
            (json['currentTradingPeriod'] as Map<String, dynamic>?) != null
                ? CurrentTradingPeriod.fromJson(
                    json['currentTradingPeriod'] as Map<String, dynamic>)
                : null,
        tradingPeriods = json['tradingPeriods'] as List?,
        dataGranularity = json['dataGranularity'] as String?,
        range = json['range'] as String?,
        validRanges = (json['validRanges'] as List?)
            ?.map((dynamic e) => e as String)
            .toList();

  Map<String, dynamic> toJson() => {
        'currency': currency,
        'symbol': symbol,
        'exchangeName': exchangeName,
        'instrumentType': instrumentType,
        'firstTradeDate': firstTradeDate,
        'regularMarketTime': regularMarketTime,
        'gmtoffset': gmtoffset,
        'timezone': timezone,
        'exchangeTimezoneName': exchangeTimezoneName,
        'regularMarketPrice': regularMarketPrice,
        'chartPreviousClose': chartPreviousClose,
        'previousClose': previousClose,
        'scale': scale,
        'priceHint': priceHint,
        'currentTradingPeriod': currentTradingPeriod?.toJson(),
        'tradingPeriods': tradingPeriods,
        'dataGranularity': dataGranularity,
        'range': range,
        'validRanges': validRanges
      };
}

class CurrentTradingPeriod {
  final Pre? pre;
  final Regular? regular;
  final Post? post;

  CurrentTradingPeriod({
    this.pre,
    this.regular,
    this.post,
  });

  CurrentTradingPeriod.fromJson(Map<String, dynamic> json)
      : pre = (json['pre'] as Map<String, dynamic>?) != null
            ? Pre.fromJson(json['pre'] as Map<String, dynamic>)
            : null,
        regular = (json['regular'] as Map<String, dynamic>?) != null
            ? Regular.fromJson(json['regular'] as Map<String, dynamic>)
            : null,
        post = (json['post'] as Map<String, dynamic>?) != null
            ? Post.fromJson(json['post'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'pre': pre?.toJson(),
        'regular': regular?.toJson(),
        'post': post?.toJson()
      };
}

class Pre {
  final String? timezone;
  final int? end;
  final int? start;
  final int? gmtoffset;

  Pre({
    this.timezone,
    this.end,
    this.start,
    this.gmtoffset,
  });

  Pre.fromJson(Map<String, dynamic> json)
      : timezone = json['timezone'] as String?,
        end = json['end'] as int?,
        start = json['start'] as int?,
        gmtoffset = json['gmtoffset'] as int?;

  Map<String, dynamic> toJson() => {
        'timezone': timezone,
        'end': end,
        'start': start,
        'gmtoffset': gmtoffset
      };
}

class Regular {
  final String? timezone;
  final int? end;
  final int? start;
  final int? gmtoffset;

  Regular({
    this.timezone,
    this.end,
    this.start,
    this.gmtoffset,
  });

  Regular.fromJson(Map<String, dynamic> json)
      : timezone = json['timezone'] as String?,
        end = json['end'] as int?,
        start = json['start'] as int?,
        gmtoffset = json['gmtoffset'] as int?;

  Map<String, dynamic> toJson() => {
        'timezone': timezone,
        'end': end,
        'start': start,
        'gmtoffset': gmtoffset
      };
}

class Post {
  final String? timezone;
  final int? end;
  final int? start;
  final int? gmtoffset;

  Post({
    this.timezone,
    this.end,
    this.start,
    this.gmtoffset,
  });

  Post.fromJson(Map<String, dynamic> json)
      : timezone = json['timezone'] as String?,
        end = json['end'] as int?,
        start = json['start'] as int?,
        gmtoffset = json['gmtoffset'] as int?;

  Map<String, dynamic> toJson() => {
        'timezone': timezone,
        'end': end,
        'start': start,
        'gmtoffset': gmtoffset
      };
}

class Indicators {
  final List<Quote>? quote;

  Indicators({
    this.quote,
  });

  Indicators.fromJson(Map<String, dynamic> json)
      : quote = (json['quote'] as List?)
            ?.map((dynamic e) => Quote.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() =>
      {'quote': quote?.map((e) => e.toJson()).toList()};
}

class Quote {
  final List? open;
  final List? low;
  final List? high;
  final List? close;
  final List? volume;

  Quote({
    this.open,
    this.low,
    this.high,
    this.close,
    this.volume,
  });

  Quote.fromJson(Map<String, dynamic> json)
      : open = (json['open'] as List?)?.map((dynamic e) => e).toList(),
        low = (json['low'] as List?)?.map((dynamic e) => e).toList(),
        high = (json['high'] as List?)?.map((dynamic e) => e).toList(),
        close = (json['close'] as List?)?.map((dynamic e) => e).toList(),
        volume =
            (json['volume'] as List?)?.map((dynamic e) => e ).toList();

  Map<String, dynamic> toJson() => {
        'open': open,
        'low': low,
        'high': high,
        'close': close,
        'volume': volume
      };
}

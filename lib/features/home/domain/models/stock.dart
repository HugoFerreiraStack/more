class Stock {
  final String stock;
  final String name;
  final double close;
  final double change;
  final int volume;
  final double? marketCap;
  final String logo;
  final String? sector;
  final String type;

  const Stock({
    required this.stock,
    required this.name,
    required this.close,
    required this.change,
    required this.volume,
    this.marketCap,
    required this.logo,
    this.sector,
    required this.type,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      stock: json['stock'] as String,
      name: json['name'] as String,
      close: (json['close'] as num).toDouble(),
      change: (json['change'] as num).toDouble(),
      volume: json['volume'] as int,
      marketCap: json['market_cap'] != null
          ? (json['market_cap'] as num).toDouble()
          : null,
      logo: json['logo'] as String? ?? '',
      sector: json['sector'] as String?,
      type: json['type'] as String? ?? 'stock',
    );
  }

  bool get isPositive => change >= 0;

  Map<String, dynamic> toJson() => {
        'stock': stock,
        'name': name,
        'close': close,
        'change': change,
        'volume': volume,
        'market_cap': marketCap,
        'logo': logo,
        'sector': sector,
        'type': type,
      };
}

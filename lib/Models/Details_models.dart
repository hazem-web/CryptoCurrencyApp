class Details_Model{
  final int rank;
  final String name;
  final String symbol;
  final current_price;
  final String image;
  final String description;

// graph 
  final double percentchange_24h;
  final double percentchange_7d;
  final double per_ch_14;
  final double per_ch_30;
  final double per_ch_60;
  final double per_ch_200;
  final double per_ch_1y;

  Details_Model({required this.rank,
    required this.name,
    required this.symbol,
    required this.current_price,
    required this.image,
  required this.percentchange_24h,
  required this.percentchange_7d,
  required this.per_ch_14,
  required this.per_ch_30,
  required this.per_ch_60,
  required this.per_ch_200,
  required this.per_ch_1y,
  required this.description

  });

  factory Details_Model.fromjson(Map<String,dynamic> json){
    return Details_Model(rank: json['market_cap_rank'],
        name: json['name'],
        symbol: json['symbol'],
        current_price: json['market_data']['current_price']['usd'],
        image: json['image']['large'],
        percentchange_24h: json['market_data']['price_change_percentage_24h'],
        percentchange_7d: json['market_data']['price_change_percentage_7d'],
        per_ch_14: json['market_data']['price_change_percentage_14d'],
        per_ch_30: json['market_data']['price_change_percentage_30d'],
        per_ch_60: json['market_data']['price_change_percentage_60d'],
        per_ch_200: json['market_data']['price_change_percentage_200d'],
        per_ch_1y: json['market_data']['price_change_percentage_1y'],
        description: json['description']['en']
    );
  }
}
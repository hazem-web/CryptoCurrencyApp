class Search_Model {
  final String id;
  final String name;
  final String symbol;
  final String image;
  final int rank;

  Search_Model(
      {required this.id, required this.name, required this.symbol, required this.image, required this.rank});

  factory Search_Model.fromjson(Map<String, dynamic> json){
    return Search_Model(
        id: json['id'],
        name: json['name'],
        symbol: json['symbol'],
        image: json['large'],
        rank: json['market_cap_rank']
    );
  }
}
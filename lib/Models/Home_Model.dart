class Home_Model {
final String id;
final String name;
final String symbol;
final String image;
final  current_price;
final double pricechange;
final double pricechange_percentage;
final int rank;

Home_Model({required this.id,required this.name,required this.symbol,required this.image,required this.current_price,
     required this.pricechange,required this.pricechange_percentage,required this.rank});

 factory Home_Model.fromjson(Map<String,dynamic> json){
   return Home_Model(
       id: json['id'],
       name: json['name'],
       symbol: json['symbol'],
       image: json['image'],
       current_price: json['current_price'],
       pricechange: json['price_change_24h'],
       pricechange_percentage: json['price_change_percentage_24h'],
       rank:json['market_cap_rank']
   );

}
}
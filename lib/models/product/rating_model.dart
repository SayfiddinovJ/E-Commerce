class RatingModel{
  final num rate;
  final num count;
  RatingModel({
    required this.rate,
    required this.count,
  });
  factory RatingModel.fromJson(Map<String,dynamic> json){
    return RatingModel(
        rate: json['rate'] as num? ?? 0,
        count: json['count'] as num? ?? 0,
    );
  }
}
// "rate": 3.9,
// "count": 120
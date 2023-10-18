class NameModel{
  final String firstname;
  final String lastname;

  NameModel(
      {
        required this.firstname,
        required this.lastname,
      });
  factory NameModel.fromJson(Map<String,dynamic> json){
    return NameModel(
      firstname: json['firstname'] as String? ?? '',
      lastname: json['lastname'] as String? ?? '',
    );
  }
}
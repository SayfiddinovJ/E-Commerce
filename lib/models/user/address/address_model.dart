import 'package:e_commerce/models/user/address/geolocation/geolocation_model.dart';

class AddressModel{
  final GeolocationModel geolocation;
  final String city;
  final String street;
  final int number;
  final String zipcode;
  AddressModel({
    required this.geolocation,
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
});
  factory AddressModel.fromJson(Map<String,dynamic> json){
    return AddressModel(
      geolocation: GeolocationModel.fromJson(json['geolocation']),
      city: json['city'] as String? ?? '',
      street: json['street'] as String? ?? '',
      number: json['number'] as int? ?? 0,
      zipcode: json['zipcode'] as String? ?? '',
    );
  }
}
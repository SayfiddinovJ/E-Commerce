import 'package:e_commerce/models/user/address/address_model.dart';
import 'package:e_commerce/models/user/name_model.dart';

class UserModel{
  final AddressModel address;
  final int id;
  final String email;
  final String userName;
  final String password;
  final NameModel name;
  final String phone;
  final int v;

  UserModel(
  {
    required this.address,
    required this.id,
    required this.email,
    required this.userName,
    required this.password,
    required this.name,
    required this.phone,
    required this.v,
});
  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(
      address: AddressModel.fromJson(json['address']),
      id: json['id'] as int? ?? 0,
      email: json['email'] as String? ?? '',
      userName: json['username'] as String? ?? '',
      password: json['password'] as String? ?? '',
      name: NameModel.fromJson(json['name']),
      phone: json['phone'] as String? ?? '',
      v: json['__v'] as int? ?? 0,
    );
  }
}

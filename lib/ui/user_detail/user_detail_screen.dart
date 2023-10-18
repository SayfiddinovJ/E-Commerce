import 'package:e_commerce/models/user/user_model.dart';
import 'package:e_commerce/ui/users/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({
    super.key,
    required this.userModel,
  });
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back,color: Colors.black,),
        ),
        title: const Text('User',style: TextStyle(
          color: Colors.black
        ),),
        elevation: 0.3,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Icon(Icons.account_circle_sharp,size: 200.h,),
                  SizedBox(height: 15.h,),
                  Text('${userModel.name.firstname.capitalize()} ${userModel.name.lastname.capitalize()}',style: TextStyle(
                    fontSize: 30.sp,
                  ),),
                ],
              ),
            ),
            SizedBox(height: 10.h,),
            Text('Username: ${userModel.userName}',style: TextStyle(
              fontSize: 20.sp,
            ),),
            SizedBox(height: 10.h,),
            Text('Password: ${userModel.password}',style: TextStyle(
              fontSize: 20.sp,
            ),),
            SizedBox(height: 10.h,),
            Text('Email: ${userModel.email}',style: TextStyle(
              fontSize: 20.sp,
            ),),
            SizedBox(height: 10.h,),
            Text('Phone: ${userModel.phone}',style: TextStyle(
              fontSize: 20.sp,
            ),),
            SizedBox(height: 10.h,),
            Text('Address: ${userModel.address.city.capitalize()} ${userModel.address.street.capitalize()} ${userModel.address.number}',style: TextStyle(
              fontSize: 20.sp,
            ),),
            SizedBox(height: 10.h,),
            Text('Geolocation: lat(${userModel.address.geolocation.lat}) long(${userModel.address.geolocation.long})',style: TextStyle(
              fontSize: 20.sp,
            ),),
            SizedBox(height: 10.h,),
            Text('Zipcode: ${userModel.address.zipcode}',style: TextStyle(
              fontSize: 20.sp,
            ),),
          ],
        ),
      ),
    );
  }
}

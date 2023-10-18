import 'package:e_commerce/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class SearchTextField extends StatelessWidget {
  SearchTextField({super.key,required this.onTap});
  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h,horizontal: 20.w),
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Text('Search Product Name',style: TextStyle(
              fontSize: 14.sp,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w500,
              color: const Color(0xFFC4C5C4),
            ),),
            const Spacer(),
            SvgPicture.asset(AppIcons.search),
          ],
        ),
      ),
    );
  }
}

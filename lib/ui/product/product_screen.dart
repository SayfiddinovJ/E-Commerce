import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/models/product/product_model.dart';
import 'package:e_commerce/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.3,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Detail Product',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2.sp,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(AppIcons.share),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(AppIcons.cart),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Center(
              child: Padding(
                padding: EdgeInsets.all(10.h),
                child: CachedNetworkImage(
                  height: 280.h,
                  imageUrl: productModel.image,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              productModel.title,
              style: TextStyle(
                color: const Color(0xFF0C1A30),
                fontWeight: FontWeight.w700,
                fontFamily: 'DM Sans',
                fontSize: 24.sp,
                letterSpacing: 0.2.sp,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Rp ${productModel.price}',
              style: TextStyle(
                color: const Color(0xFFFE3A30),
                fontWeight: FontWeight.w500,
                fontFamily: 'DM Sans',
                fontSize: 16.sp,
                letterSpacing: 0.2.sp,
              ),
            ),
            SizedBox(height: 11.h),
            Row(
              children: [
                SvgPicture.asset(AppIcons.star),
                SizedBox(width: 3.w),
                Text(
                  productModel.ranking.rate.toString(),
                  style: TextStyle(
                    color: const Color(0xFFFE3A30),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'DM Sans',
                    fontSize: 24.sp,
                    letterSpacing: 0.2.sp,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEFAF6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Available: ${productModel.ranking.count}',
                      style: TextStyle(
                        color: const Color(0xFF3A9B7A),
                        fontSize: 12.sp,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Container(
              height: 1,
              width: double.infinity,
              color: const Color(0xFFEDEDED),
            ),
            SizedBox(height: 10.h),
            Text(
              'Description Product',
              style: TextStyle(
                color: const Color(0xFF0C1A30),
                fontWeight: FontWeight.w700,
                fontFamily: 'DM Sans',
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 15.h),
            Text(
              productModel.description,
              style: TextStyle(
                color: const Color(0xFF0C1A30),
                fontWeight: FontWeight.w400,
                fontFamily: 'DM Sans',
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/models/product/product_model.dart';
import 'package:e_commerce/ui/product/product_screen.dart';
import 'package:e_commerce/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProductSearchView extends SearchDelegate {
  ProductSearchView({
    required this.suggestionList,
  });

  final List<ProductModel> suggestionList;

  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
      onPressed: () {
        query = '';
      },
      icon: const Icon(Icons.close),
    )
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () {
      close(context, query);
    },
  );

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,
        style: const TextStyle(
          fontSize: 64,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = suggestionList.map((e) => e.category).where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 25.w),
      children: List.generate(
        suggestions.length,
            (index) => GestureDetector(
              onTap: (){
                query = suggestions[index];
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductScreen(productModel: suggestionList[index])));
              },
              child: Container(

                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      height: 130.h,
                      width: 130.h,
                      imageUrl: suggestionList[index].image,
                    ),
                    SizedBox(width: 10.h,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 170,
                          child: Text(suggestionList[index].title,style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'DM Sans',
                            fontSize: 14.sp,
                            letterSpacing: 0.2.sp,
                            color: const Color(0xFF0C1A30),
                          ),),),
                        SizedBox(height: 4.h,),
                        SizedBox(
                          width: 170,
                          child: Text('${suggestionList[index].price.toString()}\$',style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'DM Sans',
                            fontSize: 12.sp,
                            letterSpacing: 0.2.sp,
                            color: const Color(0xFFFE3A30),
                          ),),),
                        SizedBox(height: 5.h,),
                        SizedBox(
                          width: 170,
                          child: Text('Count: ${suggestionList[index].ranking.count.toString()}',style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'DM Sans',
                            fontSize: 12.sp,
                            letterSpacing: 0.2.sp,
                            color: const Color(0xFF0C1A30),
                          ),),),
                        SizedBox(height: 10.h,),
                        SizedBox(
                          width: 170,
                          child: Row(
                            children: [
                              SvgPicture.asset(AppIcons.star),
                              SizedBox(width: 3.w,),
                              Text(suggestionList[index].ranking.rate.toString(),style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: 'DM Sans',
                                fontSize: 10.sp,
                                letterSpacing: 0.2.sp,
                                color: const Color(0xFF0C1A30),
                              ),),
                            ],
                          ),),
                      ],
                    ),
                  ],
                ),
                // Text(
                //   suggestions[index],
                //   style: const TextStyle(color: Colors.white, fontSize: 20),
                // ),
              ),
            ),
      ),
    );
  }
}

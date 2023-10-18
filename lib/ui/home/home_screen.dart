import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/data/local/storage_repository.dart';
import 'package:e_commerce/data/network/provider/api_provider.dart';
import 'package:e_commerce/data/network/repositories/category_repo.dart';
import 'package:e_commerce/data/network/repositories/product_repo.dart';
import 'package:e_commerce/data/network/repositories/user_repo.dart';
import 'package:e_commerce/models/product/product_model.dart';
import 'package:e_commerce/models/user/user_model.dart';
import 'package:e_commerce/ui/home/widgets/category_selector.dart';
import 'package:e_commerce/ui/home/widgets/search_text_field.dart';
import 'package:e_commerce/ui/home/widgets/search_view_screen.dart';
import 'package:e_commerce/ui/product/product_screen.dart';
import 'package:e_commerce/utils/app_utils.dart';
import 'package:e_commerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.productRepo,
    required this.categoryRepo,
    required this.userRepo,
  });
  final ProductRepo productRepo;
  final CategoryRepo categoryRepo;
  final UserRepo userRepo;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String activeCategoryName = "";
  String searchText = "";
  String username = StorageRepository.getString('username');
  String password = StorageRepository.getString('password');

  final UserRepo usersRepository = UserRepo(apiProvider: ApiProvider());
  final ProductRepo productsRepository = ProductRepo(apiProvider: ApiProvider());
  String sort = 'ASC';
  int selectMenu = 0;
  List<UserModel> users = [];
  List<ProductModel> products = [];
  List<String> categories = [];
  
  _init() async {
    categories = await widget.categoryRepo.getAllCategories();
  }
  
  bool isLoading = false;
  _updateProducts() async {
    setState(() {
      isLoading = true;
    });
    products =
    await widget.productRepo.getProductsByCategory(activeCategoryName,sort);
    setState(() {
      isLoading = false;
    });
  }
  _getProductsByQuery(String sort) async {
    setState(() {
      isLoading = true;
    });
    products =
    await widget.productRepo.getSortedProducts(sort);
    setState(() {
      isLoading = false;
    });
  }
  _getUsers() async {
    setState(() {
      isLoading = true;
    });
    setState(() {
      isLoading = false;
    });
  }

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    users = await usersRepository.getAllUsers(username: userName, password: password);
    debugPrint("PRODUCT FETCH FINISHED:${users.length}");

    products = await productsRepository.getAllProducts();
    debugPrint("PRODUCT FETCH FINISHED:${products.length}");
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _fetchData();
    _init();
    _updateProducts();
    _getUsers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0.3,
        actions: [
          Center(
            child: Text('Mega Mall',style: TextStyle(
              fontSize: 18.sp,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w700,
              color: const Color(0xFF3669C9),
            ),),
          ),
          SizedBox(width: 59.w,),
          IconButton(
            onPressed: (){},
            icon: SvgPicture.asset(AppIcons.notification),
          ),
          IconButton(
            onPressed: (){},
            icon: SvgPicture.asset(AppIcons.cart),
          ),
        ],
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Text('Hi, $username',style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'DM Sans',
                  fontSize: 16.sp,
                  color: const Color(0xFF0C1A30),
                  letterSpacing: 0.2.sp,
                ),),
              ),
              SizedBox(height: 10.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Text('What are you looking for today?',style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: 'DM Sans',
                  fontSize: 24.sp,
                  color: const Color(0xFF0C1A30),
                  letterSpacing: 0.2.sp,
                ),),
              ),
              SizedBox(height: 20.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: SearchTextField(onTap: ()async{
                  searchText = await showSearch(
                    context: context,
                    delegate: ProductSearchView(
                      suggestionList: List.generate(products.length, (index) => products[index]),
                    ),
                  );
                },),
              ),
              SizedBox(height: 30.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Row(
                  children: [
                    Text('Categories',style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'DM Sans',
                      fontSize: 16.sp,
                      color: const Color(0xFF0C1A30),
                      letterSpacing: 0.6.sp,
                    ),),
                    const Spacer(),
                    PopupMenuButton<int>(
                      onSelected: (int item){
                        setState(() {
                          selectMenu = item;
                        });
                        debugPrint('$selectMenu');
                        if(selectMenu==1){
                          setState(() {
                            sort = 'ASC';
                            _getProductsByQuery('ASC');
                          });
                        }else{
                          setState(() {
                            sort = 'DESC';
                          });
                          _updateProducts();
                        }
                      },
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (BuildContext context)=> <PopupMenuEntry<int>>[
                        const PopupMenuItem(
                          value: 1,
                          child: Text('ASC'),
                        ),
                        const PopupMenuItem(
                          value: 2,
                          child: Text('DESC'),
                        ),
                      ]
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h,),
              isLoading ? const Center(child: CircularProgressIndicator()) : CategorySelector(categories: categories, onCategorySelected: (selectedCategory) {
                activeCategoryName = selectedCategory;
                _updateProducts();
              },),
            ],
          ),

          ...List.generate(products.length, (index){
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductScreen(productModel: products[index])));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w,vertical: 10.h),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 10.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        height: 130.h,
                        width: 130.h,
                        imageUrl: products[index].image,
                      ),
                      SizedBox(width: 10.h,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 170,
                            child: Text(products[index].title,style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'DM Sans',
                            fontSize: 14.sp,
                            letterSpacing: 0.2.sp,
                            color: const Color(0xFF0C1A30),
                          ),),),
                          SizedBox(height: 4.h,),
                          SizedBox(
                            width: 170,
                            child: Text('${products[index].price.toString()}\$',style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'DM Sans',
                            fontSize: 12.sp,
                            letterSpacing: 0.2.sp,
                            color: const Color(0xFFFE3A30),
                          ),),),
                          SizedBox(height: 5.h,),
                          SizedBox(
                            width: 170,
                            child: Text('Count: ${products[index].ranking.count.toString()}',style: TextStyle(
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
                              Text(products[index].ranking.rate.toString(),style: TextStyle(
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
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

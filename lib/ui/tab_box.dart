
import 'package:e_commerce/data/network/provider/api_provider.dart';
import 'package:e_commerce/data/network/repositories/category_repo.dart';
import 'package:e_commerce/data/network/repositories/login_repo.dart';
import 'package:e_commerce/data/network/repositories/product_repo.dart';
import 'package:e_commerce/data/network/repositories/user_repo.dart';
import 'package:e_commerce/ui/home/home_screen.dart';
import 'package:e_commerce/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'users/users_screen.dart';

class TabBox extends StatefulWidget {
  const TabBox({Key? key, required this.apiProvider}) : super(key: key);

  final ApiProvider apiProvider;

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  List<Widget> screens = [];
  int activePage = 0;

  late ProductRepo productRepo;
  late UserRepo userRepo;
  late CategoryRepo categoryRepo;
  late LoginRepo loginRepo;

  @override
  void initState() {
    productRepo = ProductRepo(apiProvider: widget.apiProvider);
    userRepo = UserRepo(apiProvider: widget.apiProvider);
    categoryRepo = CategoryRepo(apiProvider: widget.apiProvider);
    loginRepo = LoginRepo(apiProvider: widget.apiProvider);

    screens.add(HomeScreen(
      productRepo: productRepo,
      categoryRepo: categoryRepo,
      userRepo: userRepo,
    ));
    screens.add(UsersScreen(
      loginRepo: loginRepo,
      userRepo: userRepo,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: activePage,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: activePage,
        onTap: (index) {
          setState(() {
            activePage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppIcons.home),
            label: "Products",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined),
            label: "Users",
          ),
        ],
      ),
    );
  }
}

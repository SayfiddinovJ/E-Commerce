import 'package:e_commerce/data/network/provider/api_provider.dart';
import 'package:e_commerce/data/network/repositories/login_repo.dart';
import 'package:e_commerce/data/network/repositories/user_repo.dart';
import 'package:e_commerce/models/user/user_model.dart';
import 'package:e_commerce/ui/login/widgets/login_textfield.dart';
import 'package:e_commerce/ui/login/widgets/universal_button.dart';
import 'package:e_commerce/ui/tab_box.dart';
import 'package:e_commerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.loginRepo});
  final LoginRepo loginRepo;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final UserRepo usersRepository = UserRepo(apiProvider: ApiProvider());

  List<UserModel> users = [];

  bool isLoading = false;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    users = await usersRepository.getAllUsers(
        username: userName, password: password);
    debugPrint("PRODUCT FETCH FINISHED:${users.length}");
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 30.h, right: 25.w, left: 25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 127.h),
            Text(
              'Welcome back to Mega Mall',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25.sp,
                fontFamily: 'DM Sans',
                color: const Color(0xFF0C1A30),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Please enter data to login',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                fontFamily: 'DM Sans',
                color: const Color(0xFF838589),
              ),
            ),
            SizedBox(height: 50.h),
            LoginTextField(
              label: 'Username',
              hintText: 'Enter Your Username',
              n: 0,
              listener: () {
                _fetchData();
              },
            ),
            SizedBox(height: 30.h),
            LoginTextField(
              label: 'Password',
              hintText: 'Enter Account Password',
              n: 1,
              listener: () {
                _fetchData();
              },
            ),
            SizedBox(height: 70.h),
            UniversalButton(
              text: 'Sign In',
              ready: ready,
              onTap: () {
                if (userName == '' || password == '') {
                  setState(() {
                    ready = false;
                    _showSnackBar('Fields are not filled');
                  });
                } else {
                  setState(() {
                    ready = true;
                  });
                  List.generate(
                    users.length,
                    (index) {
                      if (users[index].userName == userName) {
                        if (users[index].password == password) {
                          setState(() {
                            widget.loginRepo.loginUser(
                                username: userName, password: password);
                          });
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TabBox(apiProvider: ApiProvider())));
                        } else {
                          _showSnackBar('Incorrect password');
                        }
                      } else {
                        _showSnackBar('Incorrect username');
                      }
                      debugPrint(users[index].userName);
                    },
                  );
                }
              },
            ),
            SizedBox(height: 104.h),
            Row(
              children: [
                SizedBox(width: 5.w),
                Text(
                  'Forgot password',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    fontFamily: 'DM Sans',
                    color: const Color(0xFF0C1A30),
                  ),
                ),
                const Spacer(),
                Text(
                  'Sign Up',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    fontFamily: 'DM Sans',
                    color: const Color(0xFF3669C9),
                  ),
                ),
                SizedBox(width: 5.w),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _showSnackBar(String text) {
    dynamic snackBar = SnackBar(
      content: Text(text),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

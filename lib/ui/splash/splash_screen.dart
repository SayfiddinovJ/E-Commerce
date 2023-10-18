import 'package:e_commerce/data/network/repositories/login_repo.dart';
import 'package:e_commerce/ui/login/login_screen.dart';
import 'package:e_commerce/ui/tab_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/local/storage_repository.dart';
import '../../data/network/provider/api_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String token = StorageRepository.getString('token');
    _navigator(context, token);
    return Scaffold(
      body: Center(
        child: Text(
          'Mega Mall',
          style: TextStyle(
              color: const Color(0xFF3669C9),
              fontSize: 35.sp,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  _navigator(
    BuildContext context,
    String token,
  ) {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => token.isEmpty
                ? LoginScreen(
                    loginRepo: LoginRepo(apiProvider: ApiProvider()),
                  )
                : TabBox(apiProvider: ApiProvider()),
          ),
        );
      },
    );
  }
}

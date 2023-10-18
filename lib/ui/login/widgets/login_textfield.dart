import 'package:e_commerce/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../utils/constants.dart';

// ignore: must_be_immutable
class LoginTextField extends StatefulWidget {
  LoginTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.n,
    required this.listener
  });
  String label;
  String hintText;
  VoidCallback listener;
  int n;
  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  bool obscure = false;
  var maskFormatter = MaskTextInputFormatter(
      mask: '(##) ### - ## - ##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return widget.n==0 ?
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,style: TextStyle(
            color: const Color(0xFF0C1A30),
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            fontFamily: 'DM Sans'
        ),),
        SizedBox(height: 20.h,),
        SizedBox(
          height: 50.h,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            focusNode: emailFocusNode,
            controller: controllerUsername,
            onChanged: (t){
              userName = t;

            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 19.h,horizontal: 20.w),
              filled: true,
              fillColor: const Color(0xFFFAFAFA),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w400,
                color: const Color(0xFFC4C5C4),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: Color(0xFFFAFAFA),
                    width: 0
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: Color(0xFFFAFAFA),
                    width: 0
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: Color(0xFFFAFAFA),
                    width: 0
                ),
              ),
            ),
          ),
        ),
      ],
    ):
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,style: TextStyle(
          color: const Color(0xFF0C1A30),
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
          fontFamily: 'DM Sans'
        ),),
        SizedBox(height: 20.h,),
        SizedBox(
          height: 50.h,
          child: TextField(
            obscureText: obscure,
            controller: controllerPassword,
            onChanged: (t){
              password = t;
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 19.h,horizontal: 20.w),
              filled: true,
              fillColor: const Color(0xFFFAFAFA),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w400,
                color: const Color(0xFFC4C5C4),
              ),
              suffixIcon: IconButton(
                splashColor: Colors.transparent,
                color: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: (){
                  setState(() {
                    obscure = !obscure;
                  });
                },
                icon: SvgPicture.asset(obscure ? AppIcons.notVisible : AppIcons.visible),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xFFFAFAFA),
                  width: 0
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: Color(0xFFFAFAFA),
                    width: 0
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: Color(0xFFFAFAFA),
                    width: 0
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
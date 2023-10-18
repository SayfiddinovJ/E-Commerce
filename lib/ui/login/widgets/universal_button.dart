import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class UniversalButton extends StatefulWidget {
  UniversalButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.ready,
  });
  String text;
  bool ready;
  VoidCallback onTap;
  @override
  State<UniversalButton> createState() => _UniversalButtonState();
}

class _UniversalButtonState extends State<UniversalButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(widget.ready ? 0xFF3669C9 : 0xFFC4C5C4),
        ),
        onPressed: widget.onTap,
        child: Text(widget.text,style: TextStyle(
          color: Colors.white,
          fontFamily: 'DM Sans',
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),),
      ),
    );
  }
}

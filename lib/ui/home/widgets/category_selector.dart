import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });
  final List<String> categories;
  final ValueChanged<String> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(width: 5.w,),
          TextButton(
            onPressed: () {
              onCategorySelected.call("");
            },
            child: const Text("All"),
          ),
          ...List.generate(categories.length, (index) {
            return Container(
              width: 120.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    onCategorySelected.call(categories[index]);
                  },
                  child: Text(
                    categories[index].toUpperCase(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }),
          // SizedBox(width: 10.h,),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_recipe_app/ui/app_colors.dart';
import 'package:flutter_recipe_app/ui/text_styles.dart';

class FilterButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        //padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        //margin: const EdgeInsets.only(right: 8, bottom: 8),
        width: 80, // 원하는 너비로 설정
        height: 35, // 원하는 높이로 설정
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary100 : Colors.transparent,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: AppColors.primary100,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyles.smallerTextRegular.copyWith(
                color: isSelected ? AppColors.white : AppColors.primary100,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

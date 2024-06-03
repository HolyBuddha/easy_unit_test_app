import 'package:easy_unit_test_app/core/theme/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UnitTextField extends StatelessWidget {
  const UnitTextField({
    super.key,
    required this.controller,
    required this.themeData,
    this.readOnly = false,
    this.onChanged,
  });

  final TextEditingController controller;
  final ThemeData themeData;
  final bool readOnly;
  final Function()? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      width: double.infinity,
      child: TextField(
        readOnly: readOnly,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
        ],
        controller: controller,
        keyboardType:
            const TextInputType.numberWithOptions(signed: true, decimal: true),
        style: themeData.textTheme.titleLarge,
        decoration: InputDecoration(
            hintStyle: themeData.textTheme.titleLarge
                ?.copyWith(color: const Color.fromRGBO(0, 0, 0, 0.15)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: AppColors.gray,
            hintText: '0'),
        onChanged: (_) => onChanged != null ? onChanged!() : null,
      ),
    );
  }
}
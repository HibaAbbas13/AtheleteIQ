import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../data/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final bool obscureText;
  final TextInputType keyboardType;
  final int? maxLines;
  final int? minLines;
  final bool enabled;
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;
  final EdgeInsetsGeometry? contentPadding;

  const CustomTextField({
    Key? key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.minLines,
    this.enabled = true,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.contentPadding,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.label != null) ...[
              Text(
                widget.label!,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 8.h),
            ],
            TextFormField(
              controller: widget.controller,
              obscureText: _obscureText,
              keyboardType: widget.keyboardType,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              enabled: widget.enabled,
              readOnly: widget.readOnly,
              onTap: widget.onTap,
              onChanged: widget.onChanged,
              onFieldSubmitted: widget.onSubmitted,
              validator: widget.validator,
              autovalidateMode: widget.autovalidateMode,
              style: TextStyle(fontSize: 16.sp, color: AppColors.black),
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: TextStyle(fontSize: 16.sp, color: AppColors.grey500),
                errorText: widget.errorText,
                errorStyle: TextStyle(fontSize: 12.sp, color: AppColors.error),
                contentPadding:
                    widget.contentPadding ??
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                prefixIcon: widget.prefixIcon != null
                    ? Icon(
                        widget.prefixIcon,
                        color: AppColors.grey500,
                        size: 20.w,
                      )
                    : null,
                suffixIcon: _buildSuffixIcon(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.grey300, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.grey300, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(
                    color: AppColors.primaryBlue,
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.error, width: 1),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.error, width: 2),
                ),
                filled: true,
                fillColor: widget.enabled ? AppColors.white : AppColors.grey50,
              ),
            ),
          ],
        )
        .animate()
        .fadeIn(duration: 300.ms)
        .slideY(begin: 0.1, end: 0, duration: 300.ms, curve: Curves.easeOut);
  }

  Widget? _buildSuffixIcon() {
    if (widget.obscureText) {
      return IconButton(
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        icon: Icon(
          _obscureText ? Iconsax.eye : Iconsax.eye_slash,
          color: AppColors.grey500,
          size: 20.w,
        ),
      );
    }

    if (widget.suffixIcon != null) {
      return IconButton(
        onPressed: widget.onSuffixTap,
        icon: Icon(widget.suffixIcon, color: AppColors.grey500, size: 20.w),
      );
    }

    return null;
  }
}

// Dropdown Field
class CustomDropdown<T> extends StatelessWidget {
  final String? label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? hint;
  final String? errorText;
  final bool enabled;

  const CustomDropdown({
    Key? key,
    this.label,
    this.value,
    required this.items,
    this.onChanged,
    this.hint,
    this.errorText,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (label != null) ...[
              Text(
                label!,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.getTextPrimary(context),
                ),
              ),
              SizedBox(height: 8.h),
            ],
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              decoration: BoxDecoration(
                border: Border.all(
                  color: errorText != null
                      ? AppColors.error
                      : AppColors.borderLight,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12.r),
                color: enabled
                    ? AppColors.getBackground(context)
                    : AppColors.grey50,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<T>(
                  value: value,
                  items: items,
                  onChanged: enabled ? onChanged : null,
                  hint: hint != null
                      ? Text(
                          hint!,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.getTextSecondary(context),
                          ),
                        )
                      : null,
                  isExpanded: true,
                  icon: Icon(
                    Iconsax.arrow_down_1,
                    color: AppColors.getTextSecondary(context),
                    size: 20.w,
                  ),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.getTextPrimary(context),
                  ),
                  dropdownColor: AppColors.getBackground(context),
                ),
              ),
            ),
            if (errorText != null) ...[
              SizedBox(height: 4.h),
              Text(
                errorText!,
                style: TextStyle(fontSize: 12.sp, color: AppColors.error),
              ),
            ],
          ],
        )
        .animate()
        .fadeIn(duration: 300.ms)
        .slideY(begin: 0.1, end: 0, duration: 300.ms, curve: Curves.easeOut);
  }
}


class SearchField extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final bool showClearButton;

  const SearchField({
    Key? key,
    this.controller,
    this.hint = 'Search...',
    this.onChanged,
    this.onClear,
    this.showClearButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
          height: 48.h,
          decoration: BoxDecoration(
            color: AppColors.getBackground(context),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.getTextPrimary(context),
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: 16.sp,
                color: AppColors.getTextSecondary(context),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
              prefixIcon: Icon(
                Iconsax.search_normal,
                color: AppColors.getTextSecondary(context),
                size: 20.w,
              ),
              suffixIcon:
                  showClearButton && (controller?.text.isNotEmpty ?? false)
                  ? IconButton(
                      onPressed: () {
                        controller?.clear();
                        onClear?.call();
                      },
                      icon: Icon(
                        Iconsax.close_circle,
                        color: AppColors.getTextSecondary(context),
                        size: 20.w,
                      ),
                    )
                  : null,
              border: InputBorder.none,
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 300.ms)
        .slideY(begin: 0.1, end: 0, duration: 300.ms, curve: Curves.easeOut);
  }
}

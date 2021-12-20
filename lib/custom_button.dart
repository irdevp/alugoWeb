import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final Color color;
  final Color textColor;
  final bool outline;
  final bool disabled;
  final bool flexible;
  final bool loading;
  final bool hasIcon;

  const CustomButton(
      {Key? key,
      this.onTap,
      required this.text,
      this.color = const Color(0xff7165E3),
      this.outline = false,
      this.textColor = Colors.white,
      this.disabled = false,
      this.flexible = false,
      this.loading = false,
      this.hasIcon = false})
      : super(key: key);
  final double radius = 8;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: flexible ? double.infinity : ScreenUtil().setHeight(85),
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: disabled || loading ? null : onTap,
          child: Ink(
            decoration: outline
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    border: Border.all(
                        color: disabled ? const Color(0xFFECF0F3) : color,
                        width: .7),
                  )
                : BoxDecoration(
                    color: disabled ? const Color(0xFFECF0F3) : color,
                    borderRadius: BorderRadius.circular(radius),
                  ),
            child: Center(
              child: !loading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (hasIcon) ...[
                          SvgPicture.asset('assets/bell.svg'),
                          const SizedBox(
                            width: 15,
                          )
                        ],
                        Text(
                          text,
                          style: TextStyle(
                              color: outline
                                  ? disabled
                                      ? const Color(0xFFECF0F3)
                                      : color
                                  : disabled
                                      ? const Color(0xFFADB5BD)
                                      : textColor,
                              fontSize: 28.5.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    )
                  : SizedBox(
                      height: 35.h,
                      width: 35.h,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 1.4,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool? disable;
  final String hintText;
  final bool obscureText;
  final IconData? suffixIcon;
  final Widget? suffixWidget;
  final String? suffixSVG;
  final String? suffixText;
  final IconData? prefixIcon;
  final String? preffixText;
  final int maxLines;

  final void Function()? onTap;
  final List<TextInputFormatter>? mask;
  final Color borderColor;

  const CustomField(
      {Key? key,
      this.disable,
      this.maxLines = 1,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.onChanged,
      this.validator,
      required this.hintText,
      this.suffixIcon,
      this.obscureText = false,
      this.onTap,
      this.mask,
      this.borderColor = const Color(0xff7165E3),
      this.prefixIcon,
      this.suffixText,
      this.preffixText,
      this.suffixWidget,
      this.suffixSVG})
      : super(key: key);

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _focused = _focusNode.hasFocus;
    });
  }

  Color decideColorBorder({required bool onFocus}) {
    if (onFocus) {
      return widget.borderColor;
    } else {
      return const Color(0xFFECF0F3);
    }
  }

  Color decideColorBackground({required bool onFocus}) {
    if (onFocus || widget.controller.text.isNotEmpty) {
      return Colors.white;
    } else {
      return const Color(0xFFF8F9FA);
    }
  }

  Color decideColorLabel({required bool onFocus}) {
    if (onFocus) {
      return const Color(0xff7165E3);
    } else {
      return const Color(0xFFADB5BD);
    }
  }

  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final Color colorBorder = decideColorBorder(onFocus: _focused);
    final Color colorLabel = decideColorLabel(onFocus: _focused);
    final Color colorBackground = decideColorBackground(onFocus: _focused);
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: colorBorder,
              width: .9,
            ),
            color: colorBackground),
        child: Row(
          children: [
            Flexible(
              child: TextFormField(
                  focusNode: _focusNode,
                  enabled: widget.disable != null ? widget.disable! : null,
                  maxLines: widget.maxLines,
                  onTap: widget.onTap,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(28),
                      color: !_focused
                          ? const Color(0xFF495057)
                          : const Color(0xff7165E3)),
                  inputFormatters: widget.mask,
                  controller: widget.controller,
                  keyboardType: widget.keyboardType,
                  obscureText: widget.obscureText,
                  onChanged: widget.onChanged,
                  validator: widget.validator,
                  decoration: InputDecoration(
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 30,
                        minHeight: 30,
                      ),
                      suffixIconConstraints: const BoxConstraints(
                        minWidth: 30,
                        minHeight: 30,
                      ),
                      contentPadding: const EdgeInsets.all(14.0),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelStyle: TextStyle(color: colorLabel),
                      labelText: widget.hintText,
                      prefixIcon: widget.prefixIcon != null
                          ? Icon(widget.prefixIcon, color: colorLabel)
                          : widget.preffixText != null
                              ? SizedBox(
                                  width: 20,
                                  child: Center(
                                    child: Text(
                                      widget.preffixText!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: colorLabel,
                                          fontSize: 10),
                                    ),
                                  ),
                                )
                              : null,
                      suffixIcon: widget.suffixIcon != null
                          ? Padding(
                              padding: EdgeInsets.only(right: 18.w),
                              child: Icon(widget.suffixIcon, color: colorLabel))
                          : widget.suffixText != null
                              ? SizedBox(
                                  width: 20,
                                  child: Center(
                                    child: Text(
                                      widget.suffixText!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: colorLabel,
                                          fontSize: 10),
                                    ),
                                  ),
                                )
                              : widget.suffixSVG != null
                                  ? Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: SizedBox(
                                        width: 20,
                                        child: Center(
                                            child: SvgPicture.asset(
                                          widget.suffixSVG!,
                                          color: colorLabel,
                                        )),
                                      ),
                                    )
                                  : null,
                      suffixStyle: TextStyle(color: colorLabel))),
            ),
            widget.suffixWidget ?? const SizedBox()
          ],
        ));
  }
}

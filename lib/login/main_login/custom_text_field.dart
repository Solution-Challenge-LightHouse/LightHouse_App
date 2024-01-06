import 'package:flutter/material.dart';
import 'package:flutterlogin/login/main_login/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField(
      {required this.onChanged,
      this.hintText,
      this.errorText,
      this.obscureText = false,
      this.autofocus = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    const baseBorder = OutlineInputBorder(
        borderSide: BorderSide(
      color: INPUT_BG_COLOR,
      width: 1.0,
    ));

    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      //비밀번호 입력할떄
      obscureText: obscureText,
      autofocus: autofocus,
      onChanged: onChanged,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          hintText: hintText,
          hintStyle: const TextStyle(color: BODY_TEXT_COLOR, fontSize: 14.0),
          fillColor: INPUT_BG_COLOR,
          //fasle - 배경색 없음
          //true - 배경색 있음
          filled: true,
          //모든 input상태의 기본 스타일 세팅
          border: baseBorder,
          //활성화되어잇는 필드 보더 설정
          enabledBorder: baseBorder,
          focusedBorder: baseBorder.copyWith(
              borderSide: baseBorder.borderSide.copyWith(color: PRIMARY_COLOR)),
          errorText: errorText),
    );
  }
}

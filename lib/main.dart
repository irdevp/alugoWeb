import 'dart:html';

import 'package:animate_do/animate_do.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'custom_button.dart';
import 'custom_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(750, 1334),
        builder: () => MaterialApp(
              title: 'AluGo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primaryColor: const Color(0xff7165E3),
                  fontFamily: 'DMSans',
                  inputDecorationTheme: const InputDecorationTheme(
                      hintStyle: TextStyle(color: Colors.grey),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      isDense: true,
                      labelStyle: TextStyle(color: Colors.black))),
              home: const MyHomePage(),
            ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      document.addEventListener('keydown',
          (event) => {if (event.type == 'tab') event.preventDefault()});
    }

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ZoomIn(
              delay: const Duration(milliseconds: 400),
              child: SvgPicture.asset('assets/wait.svg')),
          ZoomIn(
            delay: const Duration(milliseconds: 550),
            child: Text(
              'Estamos contruíndo tudo...',
              style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 8),
          ZoomIn(
            delay: const Duration(milliseconds: 750),
            child: const Text(
              'Em breve vamos revolucionar a maneira como você aluga e\ngerencia o seu alguel.',
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 100.h,
          ),
          ZoomIn(
            delay: const Duration(milliseconds: 1050),
            child: SizedBox(
                width: 180.w,
                child: CustomButton(
                  hasIcon: true,
                  text: 'Quero ser avisado',
                  flexible: false,
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      12.0)), //this right here
                              child: SizedBox(
                                height: 1000.h,
                                width: 300.w,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w, vertical: 15.h),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          const Spacer(),
                                          Expanded(
                                            child: SvgPicture.asset(
                                              'assets/bell.svg',
                                              height: 80.h,
                                              color: const Color(0xff7165E3),
                                            ),
                                          ),
                                          Text("Deixe seu contato",
                                              style: TextStyle(
                                                  fontSize: 40.sp,
                                                  fontWeight: FontWeight.w700)),
                                          SizedBox(height: 17.h),
                                          const Text(
                                              "Avisaremos sobre todas as atualizações"),
                                          SizedBox(height: 94.h),
                                          CustomField(
                                              controller: name,
                                              hintText: "Seu Nome"),
                                          SizedBox(height: 20.h),
                                          CustomField(
                                              controller: email,
                                              hintText: "Email para contato"),
                                          SizedBox(height: 20.h),
                                          CustomField(
                                              controller: phone,
                                              mask: [
                                                TextInputMask(
                                                  mask: [
                                                    '(99) 9999-9999',
                                                    '(99) 9 9999-9999'
                                                  ],
                                                )
                                              ],
                                              hintText: "Telefone (Opcional)"),
                                          const Spacer(),
                                          CustomButton(
                                              text: "Enviar",
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              }),
                                          const Spacer()
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                        right: 0,
                                        top: 0,
                                        child: SizedBox(
                                          height: 84.h,
                                          width: 84.h,
                                          child: ClipOval(
                                            child: Material(
                                              color: Colors
                                                  .transparent, // button color
                                              child: InkWell(
                                                splashColor: const Color(
                                                    0xff7165E3), // splash color
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                }, // button pressed
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Color(0xFF868E96),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ));
                  },
                )),
          )
        ],
      ),
    ));
  }
}

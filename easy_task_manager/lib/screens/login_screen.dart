import 'package:easy_task_manager/consts/consts.dart';
import 'package:easy_task_manager/screens/home_page_screen.dart';
import 'package:easy_task_manager/screens/sign_up_screen.dart';

import 'package:easy_task_manager/widgets_common/custom_textfield.dart';
import 'package:easy_task_manager/widgets_common/our_button.dart';
import 'package:easy_task_manager/widgets_common/social_icons.dart';

import 'package:get/get.dart';
import '../widgets_common/bg_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgwidget(
      Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              250.heightBox,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  "Login to Easy Task Manager"
                      .text
                      .fontFamily(semibold)
                      .gray400
                      .size(18)
                      .shadowBlur(9)
                      .shadowOffset(2, 10)
                      .shadowColor(Vx.gray200)
                      .make(),
                  customTextField(
                    email,
                    "abc@gmail.com",
                    false,
                    null,
                    null,
                  ),
                  5.heightBox,
                  customTextField(
                    password,
                    "P@ssw0rd",
                    true,
                    null,
                    null,
                  ),
                  10.heightBox,
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {},
                          child: forgetPassword.text.gray400.bold.make())),
                  10.heightBox,
                  ourButton(() {
                    Get.to(() => const HomeScreen());
                  }, darkBlueColor, whiteColor, login)
                      .box
                      .width(context.screenWidth - 200)
                      .make(),
                  5.heightBox,
                  createNewAccount.text.color(Colors.red[300]).semiBold.make(),
                  5.heightBox,
                  ourButton(() {
                    Get.to(() => const SignUpScreen());
                  }, lightGrey, darkBlueColor, signUp),
                  20.heightBox,
                  Row(
                    children: [
                      socialIcons(icFacebookLogo),
                      5.widthBox,
                      socialIcons(icGoogleLogo),
                      5.widthBox,
                      socialIcons(icTwitterLogo),
                      5.widthBox,
                    ],
                  ),
                ],
              )
                  .box
                  .rounded
                  .margin(const EdgeInsets.all(12))
                  .padding(const EdgeInsets.all(10))
                  .color(transparentWhiteColor)
                  .make(),
            ],
          ),
        ),
      ),
    );
  }
}

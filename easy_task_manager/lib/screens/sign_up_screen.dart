import 'package:easy_task_manager/consts/consts.dart';
import 'package:easy_task_manager/widgets_common/privacy_policy.dart';
import '../widgets_common/bg_widget.dart';
import '../widgets_common/custom_textfield.dart';
import '../widgets_common/our_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? ischecked = false;
  @override
  Widget build(BuildContext context) {
    return bgwidget(
      Scaffold(
        body: Center(
          child: Column(
            children: [
              150.heightBox,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  "Join Easy Task Manager"
                      .text
                      .fontFamily(semibold)
                      .gray400
                      .size(18)
                      .shadowBlur(9)
                      .shadowOffset(2, 10)
                      .shadowColor(Vx.gray200)
                      .make(),
                  customTextField(
                    name,
                    nameHint,
                    false,
                    null,
                    null,
                  ),
                  5.heightBox,
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
                    passwordHint,
                    true,
                    null,
                    null,
                  ),
                  5.heightBox,
                  customTextField(
                    retypePassword,
                    "retype password",
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.heightBox,
                      const PrivacyBox(),
                      Checkbox(
                        value: ischecked,
                        checkColor: whiteColor,
                        activeColor: darkBlueColor,
                        onChanged: (val) {
                          setState(() {
                            ischecked = val;
                          });
                        },
                      ),
                    ],
                  ),
                  ourButton(() {}, ischecked == true ? darkBlueColor : fontGrey,
                          lightGrey, signUp)
                      .box
                      .width(context.screenWidth - 100)
                      .make(),
                  10.heightBox,
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    "Already have an account?".text.gray600.make(),
                    TextButton(
                        onPressed: () {},
                        child: "Login".text.orange600.size(18).bold.make())
                  ])
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

import 'package:easy_task_manager/consts/consts.dart';

class PrivacyBox extends StatefulWidget {
  const PrivacyBox({super.key});

  @override
  State<PrivacyBox> createState() => _PrivacyBoxState();
}

class _PrivacyBoxState extends State<PrivacyBox> {
  bool? checkVal = false; // Initial value

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        5.widthBox,
        Expanded(
          child: RichText(
            text: const TextSpan(children: [
              TextSpan(
                text: "I Agree to the ",
                style:
                    TextStyle(fontFamily: bold, color: fontGrey, fontSize: 12),
              ),
              TextSpan(
                text: "Terms and Conditions ",
                style: TextStyle(
                    fontFamily: bold, color: Vx.orange300, fontSize: 13),
              ),
              TextSpan(
                text: "& ",
                style:
                    TextStyle(fontFamily: bold, color: fontGrey, fontSize: 12),
              ),
              TextSpan(
                text: "Privacy Policy ",
                style: TextStyle(
                    fontFamily: bold, color: Vx.orange300, fontSize: 13),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

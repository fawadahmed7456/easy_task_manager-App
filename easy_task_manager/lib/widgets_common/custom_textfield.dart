import 'package:easy_task_manager/consts/consts.dart';

Widget customTextField(
    String title, String hint, isPass, Widget? widget, controller) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    title.text.color(darkBlueColor).textStyle(subHeadingStyle).size(19).make(),
    8.heightBox,
    Row(
      children: [
        Expanded(
          child: SizedBox(
            width: 200,
            child: TextFormField(
              controller: controller,
              readOnly: widget == null ? false : true,
              obscureText: isPass,
              decoration: InputDecoration(
                  hintStyle: const TextStyle(
                    fontFamily: semibold,
                    color: textfieldGrey,
                  ),
                  hintText: hint,
                  isDense: true,
                  fillColor: lightGrey,
                  filled: true,
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        color: darkBlueColor,
                      )),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(color: redColor),
                  ),
                  suffixIcon: widget),
            ),
          ),
        ),
      ],
    )
  ]);
}

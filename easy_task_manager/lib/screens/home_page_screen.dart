import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:easy_task_manager/consts/consts.dart';
import 'package:easy_task_manager/screens/create_task_screen.dart';
import 'package:easy_task_manager/screens/tasks_details_screen.dart';
import 'package:easy_task_manager/widgets_common/our_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Easy Task Management"
            .text
            .fontFamily(bold)
            .size(20)
            .color(darkBlueColor)
            .makeCentered(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DateFormat.yMMMMd().format(DateTime.now()).text.gray500.make(),
              130.widthBox,
              ourButton(() {
                Get.to(() => CreateTask(
                      date: selectedDate,
                    ));
              }, blueColor, whiteColor, "+ Add Task")
            ],
          ),
          "Today".text.textStyle(subHeadingStyle).size(23).gray400.make(),
          5.heightBox,
          Container(
            padding: const EdgeInsets.all(5),
            color: whiteColor,
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: blueColor,
              selectedTextColor: whiteColor,
              dateTextStyle: const TextStyle(color: Colors.black, fontSize: 16),
              dayTextStyle: const TextStyle(color: Colors.grey, fontSize: 12),
              monthTextStyle: const TextStyle(
                color: blueColor,
                fontSize: 14,
              ),
              onDateChange: (date) {
                selectedDate = date;
              },
            ),
          ),
          15.heightBox,
          TaskDetailsScreen(tasks: globalTaskList),
        ],
      )
          .box
          .color(lightGrey)
          .margin(
            const EdgeInsets.only(left: 5, right: 5),
          )
          .padding(const EdgeInsets.all(10))
          .rounded
          .make(),
    );
  }
}

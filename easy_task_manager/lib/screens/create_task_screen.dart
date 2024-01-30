import 'dart:math';

import 'package:easy_task_manager/consts/consts.dart';
import 'package:easy_task_manager/screens/home_page_screen.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../models/task_model_class.dart';
import '../services/task_service_class.dart';
import '../widgets_common/custom_textfield.dart';
import '../widgets_common/our_button.dart';

List<TaskModel> globalTaskList = [];
int globalGenerateUniqueId() {
  // Get the current timestamp
  int timestamp = DateTime.now().millisecondsSinceEpoch;

  // Generate a random number between 0 and 9999
  int randomNumber = Random().nextInt(10000);

  // Concatenate the timestamp and random number to create a unique ID
  int uniqueId = int.parse('$timestamp$randomNumber');

  return uniqueId;
}

class CreateTask extends StatefulWidget {
  final DateTime date;
  const CreateTask({Key? key, required this.date}) : super(key: key);

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  List<int> remindList = [5, 10, 15, 20, 30];
  List<Color> avatarColors = [
    darkgreenColor,
    transparentgreenColor,
    transparentYellowColor,
    transparentredColor,
    darkRedColor
  ];
  Color? selectedColor;
  int? remindSelected;
  DateTime? _selectedStartDate;
  DateTime? _selectedDueDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  List<int> priorityList = [1, 2, 3, 4, 5];
  List<String> priorityTags = ["Minimal", "Low", "Medium", "High", "Critical"];
  int? prioritySelected;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool? invalidEntry = false;
  var uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    Future<void> getStartDatefromUser() async {
      DateTime? dateData = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2124),
      );
      if (dateData != null) {
        setState(() {
          _selectedStartDate = dateData;
        });
      }
    }

    Future<void> getDueDateFromUser() async {
      DateTime? dateData = await showDatePicker(
        context: context,
        initialDate: _selectedDueDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2124),
      );
      if (dateData != null) {
        setState(() {
          _selectedDueDate = dateData;
        });
      }
    }

    Future<void> getTimefromUser(bool isStartTime) async {
      TimeOfDay? timePicked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (timePicked != null) {
        setState(() {
          if (isStartTime) {
            _startTime = timePicked;
          } else {
            _endTime = timePicked;
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              "Add Task".text.size(20).fontFamily(bold).color(blueColor).make(),
              10.heightBox,
              Column(
                children: [
                  customTextField(
                    "Title",
                    "Enter task title",
                    false,
                    null,
                    titleController,
                  ),
                  6.heightBox,
                  customTextField("Description", "Enter task Description",
                      false, null, descriptionController),
                  10.heightBox,
                  customTextField(
                    "Task Priority",
                    "Priority : ",
                    false,
                    DropdownButton<int>(
                      value: prioritySelected,
                      onChanged: (int? newValue) {
                        if (newValue != null) {
                          setState(() {
                            prioritySelected = newValue;
                          });
                        }
                      },
                      items:
                          priorityList.map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: '$value => ${priorityTags[value - 1]}'
                              .text
                              .color(fontGrey)
                              .make(),
                        );
                      }).toList(),
                    ),
                    null,
                  ),
                  10.heightBox,
                  SizedBox(
                    width: 400,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: customTextField(
                                "Start Date",
                                DateFormat.yMd().format(
                                  _selectedStartDate ?? widget.date,
                                ),
                                false,
                                IconButton(
                                  onPressed: getStartDatefromUser,
                                  icon: const Icon(
                                    Icons.calendar_today_outlined,
                                    color: fontGrey,
                                    size: 20,
                                  ),
                                ),
                                null,
                              ),
                            ),
                            10.widthBox,
                            Expanded(
                                child: customTextField(
                              "Due Date",
                              DateFormat.yMd().format(
                                _selectedDueDate ?? widget.date,
                              ),
                              false,
                              IconButton(
                                onPressed: getDueDateFromUser,
                                icon: const Icon(
                                  Icons.calendar_today_outlined,
                                  color: fontGrey,
                                  size: 20,
                                ),
                              ),
                              null,
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  10.heightBox,
                  SizedBox(
                    width: 400,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: customTextField(
                                "Start Time",
                                _startTime != null
                                    ? _startTime!.format(context)
                                    : "Select start time",
                                false,
                                IconButton(
                                  onPressed: () {
                                    getTimefromUser(true);
                                  },
                                  icon: const Icon(
                                    Icons.access_time_rounded,
                                    size: 25,
                                  ),
                                ),
                                null,
                              ),
                            ),
                            10.widthBox,
                            Expanded(
                              child: customTextField(
                                "End Time",
                                _endTime != null
                                    ? _endTime!.format(context)
                                    : "Select end time",
                                false,
                                IconButton(
                                  onPressed: () {
                                    getTimefromUser(false);
                                  },
                                  icon: const Icon(
                                    Icons.access_time_rounded,
                                    size: 25,
                                  ),
                                ),
                                null,
                              ),
                            ),
                          ],
                        ),
                        10.heightBox,
                        customTextField(
                          "Remind",
                          "Remind ",
                          false,
                          DropdownButton<int>(
                            value: remindSelected,
                            onChanged: (int? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  remindSelected = newValue;
                                });
                              }
                            },
                            items: remindList
                                .map<DropdownMenuItem<int>>((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: '$value minutes before start time'
                                    .text
                                    .color(fontGrey)
                                    .make(),
                              );
                            }).toList(),
                          ),
                          null,
                        )
                      ],
                    ),
                  ),
                  10.heightBox,
                  Row(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              "Color"
                                  .text
                                  .color(fontGrey)
                                  .textStyle(subHeadingStyle)
                                  .size(20)
                                  .makeCentered(),
                              Wrap(
                                children: List<Widget>.generate(5, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedColor = avatarColors[index];
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(3),
                                      child: CircleAvatar(
                                        radius: 14,
                                        backgroundColor: avatarColors[index],
                                        foregroundColor: Colors.white,
                                        child:
                                            selectedColor == avatarColors[index]
                                                ? const Icon(
                                                    Icons.done,
                                                    color: Colors.white,
                                                  )
                                                : Container(),
                                      ),
                                    ),
                                  );
                                }),
                              )
                            ],
                          ),
                          55.widthBox,
                        ],
                      ),
                      Column(children: [
                        20.heightBox,
                        ourButton(() {
                          if (invalidEntry == false) {
                            _saveTaskToDatabase();
                          } else {
                            validateData();
                          }
                        }, blueColor, whiteColor, "Create Task")
                      ])
                    ],
                  )
                ],
              )
                  .box
                  .rounded
                  .color(lightGrey)
                  .padding(const EdgeInsets.all(10))
                  .make(),
            ],
          ),
        ),
      ),
    );
  }

  void validateData() {
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        _selectedStartDate == null &&
        _startTime == null &&
        _endTime == null) {
      invalidEntry == true;
    } else {
      invalidEntry = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Required fields are missing !'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _saveTaskToDatabase() async {
    String selectedPriorityTag =
        ''; // Variable to store the selected priority tag

    // Check if prioritySelected is not null and within range
    if (prioritySelected != null &&
        prioritySelected! >= 1 &&
        prioritySelected! <= priorityList.length) {
      // Get the priority tag corresponding to the selected priority level
      selectedPriorityTag =
          priorityTags[priorityList.indexOf(prioritySelected!)];
    } else {
      // If prioritySelected is null or out of range, default to Minimal priority
      selectedPriorityTag = priorityTags.last;
    }

    TaskModel newTask = TaskModel(
      id: globalGenerateUniqueId(),
      title: titleController.text,
      note: descriptionController.text,
      isCompleted: 0,
      date:
          '${DateFormat.yMd().format(_selectedStartDate ?? DateTime.now())}      Due: ${DateFormat.yMd().format(_selectedDueDate ?? DateTime.now())}',
      startTime: _startTime != null ? _startTime!.format(context) : '',
      endTime: _endTime != null ? _endTime!.format(context) : '',
      color: selectedColor ?? Colors.grey,
      remind: remindSelected ?? 0,
      priority: selectedPriorityTag, // Assign the selected priority tag
    );

    await TaskDatabaseService().insertTask(newTask);
    globalTaskList.add(newTask);
    Get.to(() => const HomeScreen());
  }
}

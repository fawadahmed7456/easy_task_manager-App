import 'package:easy_task_manager/models/task_model_class.dart';
import 'package:easy_task_manager/services/task_service_class.dart';
import 'package:easy_task_manager/consts/consts.dart';
import 'package:easy_task_manager/screens/home_page_screen.dart';
import 'package:get/get.dart';

class EditTask extends StatefulWidget {
  final TaskModel task;

  const EditTask({Key? key, required this.task}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  int? prioritySelected;
  Color? selectedColor;
  int? remindSelected;
  List<int> priorityList = [1, 2, 3, 4, 5];
  List<String> priorityTags = ["Minimal", "Low", "Medium", "High", "Critical"];
  List<int> remindList = [5, 10, 15, 20, 30];
  List<Color> avatarColors = [
    darkgreenColor,
    transparentgreenColor,
    transparentYellowColor,
    transparentredColor,
    darkRedColor
  ];

  @override
  void initState() {
    super.initState();
    // Initialize controllers with task properties
    titleController.text = widget.task.title;
    descriptionController.text = widget.task.note;
    prioritySelected = priorityTags.indexOf(widget.task.priority) + 1;
    selectedColor = widget.task.color;
    remindSelected = widget.task.remind;
    // Set initial values of other controllers
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text('Edit Task'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            DropdownButtonFormField<int>(
              value: prioritySelected,
              onChanged: (int? newValue) {
                if (newValue != null) {
                  setState(() {
                    prioritySelected = newValue;
                  });
                }
              },
              items: priorityList.map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(priorityTags[value - 1]),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Priority'),
            ),
            // Implement other input fields for date, time, color, etc.
            10.heightBox,
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _saveChanges();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Required fields are missing !'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
                child: const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveChanges() {
    // Update task object with new values from input fields
    widget.task.title = titleController.text;
    widget.task.note = descriptionController.text;
    widget.task.priority = priorityTags[prioritySelected! - 1];
    widget.task.color = selectedColor!;
    widget.task.remind = remindSelected!;

    // Save updated task to the database
    TaskDatabaseService().updateTask(widget.task);

    // Navigate back to the previous screen
    Get.off(() => const HomeScreen());
  }
}

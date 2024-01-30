import 'package:easy_task_manager/screens/edit_task_screen.dart';
import 'package:easy_task_manager/services/task_service_class.dart';
import 'package:get/get.dart';

import '../consts/consts.dart';
import '../models/task_model_class.dart';

class TaskDetailsScreen extends StatefulWidget {
  final List<TaskModel> tasks;

  const TaskDetailsScreen({Key? key, required this.tasks}) : super(key: key);

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 500,
        child: ListView.builder(
          itemCount: widget.tasks.length,
          itemBuilder: (context, index) {
            return _buildTaskCard(widget.tasks[index]);
          },
        ),
      ),
    );
  }

  Widget _buildTaskCard(TaskModel task) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          decoration: BoxDecoration(
            color: task.color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title: ${task.title}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 330,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    child: Text(
                      'Description:  ${task.note}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: semibold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildOutlinedBox('Date', task.date, 250),
                        _buildOutlinedBox('Start Time', task.startTime, 150),
                        _buildOutlinedBox('End Time', task.endTime, 150),
                        _buildOutlinedBox('Priority', task.priority, 150),
                        _buildOutlinedBox(
                            'Remind', '${task.remind} minutes', 150),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Get.to(() => EditTask(task: task));
                            TaskDatabaseService().updateTask(task);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            // Delete the task from the database
                            await TaskDatabaseService().deleteTask(task.id!);

                            // Remove the task from the global task list
                            setState(() {
                              widget.tasks.removeWhere(
                                  (element) => element.id == task.id);
                            });

                            // Update the UI to reflect the changes
                            setState(() {});
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.check_circle),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOutlinedBox(String label, String text, double width) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white38),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(2),
      margin: const EdgeInsets.only(bottom: 2),
      child: Text(
        '$label: $text',
        style: const TextStyle(fontSize: 13),
      ),
    );
  }
}

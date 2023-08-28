import '../models/data_layer.dart';
import 'package:flutter/material.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  Plan plan = const Plan();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Master plan')),
      body: _buildList(),
      floatingActionButton: _buildAddTaskAction(),
      );

  }

  Widget _buildAddTaskAction(){
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: (){
        setState(() {
          plan = Plan(
            name: plan.name,
            tasks: List<Task>.from(plan.tasks)
              ..add(const Task()),
          );
        });
      },
    );
  }
  Widget _buildList(){
    return ListView.builder(
      itemCount: plan.tasks.length,
        itemBuilder: (context,index) => _builTaskTile(plan.tasks[index], index),
    );
  }
  Widget _builTaskTile(Task task, int index)  {
    return ListTile(
      leading: Checkbox(
        value: task.complete,
        onChanged: (selected) {
          setState(() {
            plan = Plan(
              name: plan.name,
              tasks: List<Task>.from(plan.tasks)
                ..[index] = Task(
                  description: task.description,
                  complete: selected ?? false,
                )
            );
          });
        },
      ),
      title: TextFormField(
        initialValue: task.description,
        onChanged: (text) {
          setState(() {
            plan = Plan(
              name: plan.name,
              tasks: List<Task>.from(plan.tasks)
                ..[index] = Task(
                  description: text,
                  complete: task.complete
                )
            );
          });
        }
      ),
    );
  }
}

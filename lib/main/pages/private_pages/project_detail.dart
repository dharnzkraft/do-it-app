
import 'dart:io';
import 'package:do_it_fixed_fixed/app-themes/MarkTextStyle.dart';
import 'package:do_it_fixed_fixed/main/pages/private_pages/create_task.dart';
import 'package:do_it_fixed_fixed/main/pages/private_pages/task_list_page.dart';
import 'package:do_it_fixed_fixed/main/widgets/button.dart';
import 'package:do_it_fixed_fixed/main/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class ProjectDetailPage extends StatelessWidget {
  final Map<String, dynamic> project;

  const ProjectDetailPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        title: project['name'],
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (project['imagePath'] != null)
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: FileImage(File(project['imagePath'])),
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                "From: ${project['fromDate']}", 
                style: MarkTextStyles.bodyRegular16
              ),
              const SizedBox(height: 8),
              Text("To: ${project['toDate']}", style: MarkTextStyles.bodyRegular16),
              const SizedBox(height: 16),
              Text("Members:", style: MarkTextStyles.bodyRegular16),
              Wrap(
                spacing: 8,
                children: List<Widget>.from(
                  (project['members'] as List).map((m) => Chip(
                    label: Text(
                      m,
                      style: MarkTextStyles.bodyRegular16
                    )
                  )),
                ),
              ),
              const SizedBox(height: 16),
              Text("Tags:", style: MarkTextStyles.bodyRegular16),
              Wrap(
                spacing: 8,
                children: List<Widget>.from(
                  (project['tags'] as List).map((t) => Chip(label: Text(
                    t,
                    style: MarkTextStyles.bodyRegular16
                  ))),
                ),
              ),
              const SizedBox(height: 16),
              Text("Description:", style: MarkTextStyles.bodyRegular16),
              Text(project['description'], style: MarkTextStyles.bodyRegular16),
              Text(project['id'], style: MarkTextStyles.bodyRegular16),
              SizedBox(
                height: size.height * .05,
              ),
              Column(

                children: [
                  CustomButton(
                    label: 'Create Task', 
                    onPressed: () {
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TaskCreationPage(projectId: project['id'],),
                            ),
                          );
                    }, 
                    text: 'Create Task'),
                    SizedBox(height: 20,),
                  CustomButton(
                    label: 'View Tasks', 
                    onPressed: () { 
                       Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TaskListPage(projectId: project['id'],),
                            ),
                          );
                     }, 
                     text: 'View Tasks',),
                  
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

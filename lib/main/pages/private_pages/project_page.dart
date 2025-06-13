
import 'dart:convert';
import 'dart:io';
import 'package:do_it_fixed_fixed/app-themes/MarkTextStyle.dart';
import 'package:do_it_fixed_fixed/app-themes/theme.dart';
import 'package:do_it_fixed_fixed/main/pages/private_pages/create_project.dart';
import 'package:do_it_fixed_fixed/main/pages/private_pages/dashboard_page.dart';
import 'package:do_it_fixed_fixed/main/pages/private_pages/project_detail.dart';
import 'package:do_it_fixed_fixed/main/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  List<Map<String, dynamic>> _projects = [];

  Future<void> _loadProjects() async {
    final prefs = await SharedPreferences.getInstance();
    final String? projectsString = prefs.getString('projects');
    if (projectsString != null) {
      setState(() {
        _projects = List<Map<String, dynamic>>.from(jsonDecode(projectsString));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        onBack: (){
          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DashboardPage(),
                            ),
                          );
        },
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
              onPressed: () {
                 Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProjectCreationPage(),
                              ),
                            );
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: AppTheme.primaryColor), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
              child:  Text(
                'Create Project',
                style: MarkTextStyles.bodyLight14.copyWith(
                  color: AppTheme.primaryColor
                )
              ),
            ),
          )
         
        ], title: '',
      ),
      body: _projects.isEmpty
    ? const Center(child: Text('No projects found.'))
    : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Projects',
                style: MarkTextStyles.headingRegularBold20.copyWith(
                  color: AppTheme.secondaryColor,
                ),
              ),
              const SizedBox(height: 10),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _projects.length,
                itemBuilder: (context, index) {
                  final project = _projects[index];
                  return Card(
                    color: AppTheme.white,
                    child: ListTile(
                      title: Row(
                        children: [
                          project['imagePath'] != null
                              ? CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      FileImage(File(project['imagePath'])),
                                )
                              : Image.asset(
                                  'assets/images/doit-logo.png',
                                  height: 40,
                                ),
                          const SizedBox(width: 10),
                          Text(
                            project['name'],
                            style: MarkTextStyles.bodyRegular16.copyWith(
                              color: AppTheme.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                      trailing: Column(
                        children: [
                          Chip(
                            label: Text(
                              '4d',
                              style: MarkTextStyles.bodyLight14
                                  .copyWith(color: AppTheme.white),
                            ),
                            backgroundColor: AppTheme.success,
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            'Team Members',
                            style: MarkTextStyles.caption12,
                          ),
                          Wrap(
                            spacing: 8,
                            children: List<Widget>.from(
                              (project['members'] as List).map(
                                (m) => Chip(
                                  padding: EdgeInsets.zero,
                                  label: Text(
                                    m,
                                    style: MarkTextStyles.bodyLight14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              CircularImage(
                                imagePath: 'assets/icons/calendar.png',
                                backgroundColor: AppTheme.subtleWarning,
                                size: 10,
                              ),
                              SizedBox(width: size.width * .03),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Start',
                                    style: MarkTextStyles.caption12
                                        .copyWith(color: Colors.red),
                                  ),
                                  Text(
                                    '${project['fromDate']}',
                                    style: MarkTextStyles.caption12.copyWith(
                                        color: AppTheme.secondaryColor),
                                  ),
                                ],
                              ),
                              SizedBox(width: size.width * .05),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'End',
                                    style: MarkTextStyles.caption12
                                        .copyWith(color: AppTheme.success),
                                  ),
                                  Text(
                                    '${project['toDate']}',
                                    style: MarkTextStyles.caption12.copyWith(
                                        color: AppTheme.secondaryColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ProjectDetailPage(project: project),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/create-project'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

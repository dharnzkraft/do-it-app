import 'dart:convert';

import 'package:do_it_fixed_fixed/app-themes/MarkTextStyle.dart';
import 'package:do_it_fixed_fixed/app-themes/theme.dart';
import 'package:do_it_fixed_fixed/helpers/stat_helper.dart';
import 'package:do_it_fixed_fixed/main/pages/private_pages/project_detail.dart';
import 'package:do_it_fixed_fixed/main/pages/private_pages/project_page.dart';
import 'package:do_it_fixed_fixed/main/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? name;
  String? email;
  String? phone;
  int _projectCount = 0;
int _taskCount = 0;
int _completed = 0;
int _overdueTask = 0;

  List<Map<String, dynamic>> _projects = [];

@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    _loadDashboardInfo();
    _loadCounts();
    _loadProjects();
  });
  }
  

  Future<void> _loadCounts() async {
  _projectCount = await DataHelper.getProjectCount();
  _taskCount = await DataHelper.getTaskCount();
  _completed = await DataHelper.getCompletedTaskCount();
  _overdueTask = await DataHelper.getOverdueTaskCount();
  
  setState(() {});
}

Future<void> _loadProjects() async {
    final prefs = await SharedPreferences.getInstance();
    final String? projectsString = prefs.getString('projects');
    if (projectsString != null) {
      setState(() {
        _projects = List<Map<String, dynamic>>.from(jsonDecode(projectsString));
      });
    }
  }

  Future<void> _loadDashboardInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('logged_in_user');

    if (userString != null) {
      final user = jsonDecode(userString);
      name = user['name'];
      email = user['email'];
      phone = user['mobile'];
    }
  
  }

  

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              Padding(
                padding: const EdgeInsets.only(top: 16.0, right: 12.0, left: 12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Text(
                                'Hi $name',
                                style: MarkTextStyles.headingBold32.copyWith(
                                  color: AppTheme.secondaryColor,
                                ),
                              ),
                              Text(
                                'Welcome onboard',
                                style: MarkTextStyles.bodyRegular16.copyWith(
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.notification_add),
                      ],
                    ),
                    Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Card(
                      color: AppTheme.cardColors[0],
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                CircularImage(
                                  imagePath:
                                      'assets/icons/arcticons_zoho-projects.png',
                                  backgroundColor: AppTheme.warning,
                                ),
                                Text(
                                  '$_projectCount',
                                  style: MarkTextStyles.headingRegularBold20,
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * .07),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Projects',
                                style: MarkTextStyles.bodyBold14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Card(
                      color: AppTheme.cardColors[1],
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                CircularImage(
                                  imagePath: 'assets/icons/icon3.png',
                                  backgroundColor: AppTheme.primaryColor,
                                ),
                                Text(
                                  '$_taskCount',
                                  style: MarkTextStyles.headingRegularBold20,
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * .07),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Tasks',
                                style: MarkTextStyles.bodyBold14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Card(
                      color: AppTheme.cardColors[2],
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                CircularImage(
                                  imagePath: 'assets/icons/vector.png',
                                  backgroundColor: AppTheme.success,
                                ),
                                Text(
                                  '$_completed',
                                  style: MarkTextStyles.headingRegularBold20,
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * .07),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Completed',
                                style: MarkTextStyles.bodyBold14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Card(
                      color: AppTheme.cardColors[3],
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                CircularImage(
                                  imagePath: 'assets/icons/icon4.png',
                                  backgroundColor: AppTheme.grey,
                                ),
                                Text(
                                  '$_overdueTask',
                                  style: MarkTextStyles.headingRegularBold20,
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * .07),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Overdue Task',
                                style: MarkTextStyles.bodyBold14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
                  ],
                ),
              ),
              
              SizedBox(height: size.height * .02),
              _projects.isEmpty
                  ? const Center(child: Text('No projects found.'))
                  : Container(
          color: AppTheme.subtlegrey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Task in Progress',
                      style: MarkTextStyles.headingRegularBold20.copyWith(
                        color: AppTheme.secondaryColor
                      ),
                    ),
                    TextButton(
                       onPressed: () { 
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProjectsPage(),
                        ),
                      );
                        }, 
                      child: Text('See all',
                      style: MarkTextStyles.bodyRegular16.copyWith(
                        color: AppTheme.primaryColor
                      ),),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * .5,
                child: ListView.builder(
                  itemCount: _projects.length > 2 ? 2 : _projects.length,
                  itemBuilder: (context, index) {
                    final reversedIndex = _projects.length - 2 + index;
    final project = _projects.length > 2
        ? _projects[reversedIndex]
        : _projects[index];
                    return Card(
                      color: AppTheme.white,
                      margin: const EdgeInsets.all(12),
                      child: ListTile(
                        title: Text(
                          project['name'],
                          style: MarkTextStyles.bodyRegular16.copyWith(
                            color: AppTheme.secondaryColor
                          ),
                        ),
                        trailing: Column(
                          children: [
                            Chip(
                              label: Text(
                                '4d',
                                style: MarkTextStyles.bodyLight14.copyWith(
                                  color: AppTheme.white
                                ),
                              ),
                              backgroundColor: AppTheme.primaryColor,
                            ),

                          ],
                        ),
                        subtitle: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Team Members',
                                  style: MarkTextStyles.caption12,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                  spacing: 8,
                                  children: List<Widget>.from(
                                    (project['members'] as List).map((m) => Chip(
                                      padding: EdgeInsets.all(0), 
                                      label: Text(
                                        m,
                                        style: MarkTextStyles.bodyLight14,
                                      )
                                    )),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    CircularImage(
                                      imagePath:
                                          'assets/icons/calendar.png',
                                      backgroundColor: AppTheme.subtleWarning,
                                      size: 10,
                                    ),
                                    SizedBox(width: size.width * .03,),
                                    Column(
                                      children: [
                                        Text(
                                          'start',
                                          style: MarkTextStyles.caption12.copyWith(
                                            color: Colors.red
                                          ),
                                        ),
                                        Text(
                                          '${project['fromDate']}',
                                          style: MarkTextStyles.caption12.copyWith(
                                            color: AppTheme.secondaryColor
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(width: size.width * .03,),
                                    Column(
                                      children: [
                                        Text(
                                          'End',
                                          style: MarkTextStyles.caption12.copyWith(
                                            color: AppTheme.success
                                          ),
                                        ),
                                        
                                        Text(
                                          '${project['toDate']}',
                                          style: MarkTextStyles.caption12.copyWith(
                                            color: AppTheme.secondaryColor
                                          ),
                                        )
                                      ],
                                    ),
                                    // Text('${project['fromDate']} → ${project['toDate']}'),
                                  ],
                                )),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProjectDetailPage(project: project),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
                    ),
            
          
            ],
          ),
        ),
      ),
    );
  }
}

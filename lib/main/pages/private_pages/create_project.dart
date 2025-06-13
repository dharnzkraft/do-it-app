
import 'dart:convert';
import 'dart:io';
import 'package:do_it_fixed_fixed/app-themes/MarkTextStyle.dart';
import 'package:do_it_fixed_fixed/app-themes/theme.dart';
import 'package:do_it_fixed_fixed/main/widgets/button.dart';
import 'package:do_it_fixed_fixed/main/widgets/date_picker_field.dart';
import 'package:do_it_fixed_fixed/main/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ProjectCreationPage extends StatefulWidget {
  const ProjectCreationPage({super.key});

  @override
  State<ProjectCreationPage> createState() => _ProjectCreationPageState();
}

class _ProjectCreationPageState extends State<ProjectCreationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _membersController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = picked.toIso8601String().split('T').first;
    }
  }

  Future<void> _saveProjectLocally(Map<String, dynamic> project) async {
    final prefs = await SharedPreferences.getInstance();
    final existingProjectsString = prefs.getString('projects');
    List<dynamic> projects = existingProjectsString != null ? jsonDecode(existingProjectsString) : [];
    projects.add(project);
    await prefs.setString('projects', jsonEncode(projects));
  }

  void _handleProjectCreation() async{
    final String id = const Uuid().v4();
    final String name = _nameController.text.trim();
    final String fromDate = _fromDateController.text.trim();
    final String toDate = _toDateController.text.trim();
    final List<String> members = _membersController.text.trim().split(',').map((e) => e.trim()).toList();
    final List<String> tags = _tagsController.text.trim().split(',').map((e) => e.trim()).toList();
    final String description = _descriptionController.text.trim();
    final String? imagePath = _imageFile?.path;

    if (name.isEmpty || fromDate.isEmpty || toDate.isEmpty || members.isEmpty || tags.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    debugPrint('Project Created:');
    debugPrint('ID: $id');
    debugPrint('Name: $name');
    debugPrint('From: $fromDate');
    debugPrint('To: $toDate');
    debugPrint('Members: $members');
    debugPrint('Tags: $tags');
    debugPrint('Description: $description');
    debugPrint('Image Path: $imagePath');

    final Map<String, dynamic> project = {
      'id': id,
      'name': name,
      'fromDate': fromDate,
      'toDate': toDate,
      'members': members,
      'tags': tags,
      'description': description,
      'imagePath': imagePath,
    };

    await _saveProjectLocally(project);

    debugPrint('Project saved locally: $project');

    Navigator.pushNamedAndRemoveUntil(context, '/projects', (route) => false);

  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Padding(
        padding: const EdgeInsets.only(left:16.0, right: 16.0, top: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create Project",
                style: MarkTextStyles.headingSemiBold24.copyWith(
                  color: Colors.black
                ),
              ),
              SizedBox(height: size.height * .02,),
              Row(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                      child: _imageFile == null
                          ? const Icon(Icons.camera_alt, size: 30, color: Colors.white)
                          : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomInputField(
                      label: 'Project Name',
                      controller: _nameController,
                      hint: 'Enter project name', 
                      isMultiline: false,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * .05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomDatePickerField(
                      label: 'Created (from)',
                      controller: _fromDateController,
                      onTap: () => _selectDate(context, _fromDateController),
                    ),
                  ),
                   SizedBox(width: size.width * .1),
                  Expanded(
                    child: CustomDatePickerField(
                      label: 'End (To)',
                      controller: _toDateController,
                      onTap: () => _selectDate(context, _toDateController),
                    ),
                  ),
                ],
              ),
               SizedBox(height: size.height * .05),
              CustomInputField(
                label: 'Assign to:',
                controller: _membersController,
                hint: 'Comma-separated list',
                isMultiline: true,
              ),
              Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Comma-separated list',
                      style: MarkTextStyles.bodyLight14.copyWith(
                        color: AppTheme.grey
                      ),
                    ),
                  ),
              SizedBox(height: size.height * .05),
              CustomInputField(
                label: 'Tags',
                controller: _tagsController,
                hint: 'Comma-separated tags',
                isMultiline: true,
              ),
              Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Comma-separated list',
                      style: MarkTextStyles.bodyLight14.copyWith(
                        color: AppTheme.grey
                      ),
                    ),
                  ),
              SizedBox(height: size.height * .05),
              CustomTextArea(
                label: 'Description',
                controller: _descriptionController,
                maxLines: 5,
              ),
              SizedBox(height: size.height * .05),
              CustomButton(
                text: 'Create Project',
                onPressed: _handleProjectCreation, 
                label: 'Create Project',
              )
            ],
          ),
        ),
      ),
    );
  }
}

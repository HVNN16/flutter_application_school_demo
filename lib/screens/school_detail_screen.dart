import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/school.dart';
import '../providers/school_provider.dart';
import 'add_edit_teacher_screen.dart';
import 'add_edit_student_screen.dart';

class SchoolDetailScreen extends StatelessWidget {
  final School school;

  SchoolDetailScreen({required this.school});

  @override
  Widget build(BuildContext context) {
    final schoolProvider = Provider.of<SchoolProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text(school.name)),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Địa chỉ: ${school.address}', style: TextStyle(fontSize: 16)),
                Text('Số điện thoại: ${school.phone}', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(tabs: [
                    Tab(text: 'Giáo viên'),
                    Tab(text: 'Học sinh'),
                  ]),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Tab Giáo viên
                        StreamBuilder<List<Teacher>>(
                          stream: schoolProvider.getTeachers(school.id),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                            final teachers = snapshot.data!;
                            return ListView.builder(
                              itemCount: teachers.length,
                              itemBuilder: (context, index) {
                                final teacher = teachers[index];
                                return ListTile(
                                  title: Text(teacher.name),
                                  subtitle: Text('${teacher.subject} - ${teacher.email}'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => AddEditTeacherScreen(
                                                teacher: teacher,
                                                schoolId: school.id,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          schoolProvider.deleteTeacher(school.id, teacher.id);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        // Tab Học sinh
                        StreamBuilder<List<Student>>(
                          stream: schoolProvider.getStudents(school.id),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                            final students = snapshot.data!;
                            return ListView.builder(
                              itemCount: students.length,
                              itemBuilder: (context, index) {
                                final student = students[index];
                                return ListTile(
                                  title: Text(student.name),
                                  subtitle: Text('Lớp: ${student.className}, Tuổi: ${student.age}'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: schoolProvider.isLoggedIn
                                            ? () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => AddEditStudentScreen(
                                                      student: student,
                                                      schoolId: school.id,
                                                    ),
                                                  ),
                                                );
                                              }
                                            : null,
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: schoolProvider.isLoggedIn
                                            ? () {
                                                schoolProvider.deleteStudent(school.id, student.id);
                                              }
                                            : null,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEditTeacherScreen(schoolId: school.id),
                      ),
                    );
                  },
                  child: Text('Thêm giáo viên'),
                ),
                ElevatedButton(
                  onPressed: schoolProvider.isLoggedIn
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEditStudentScreen(schoolId: school.id),
                            ),
                          );
                        }
                      : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Vui lòng đăng nhập để thêm học sinh')),
                          );
                        },
                  child: Text('Thêm học sinh'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
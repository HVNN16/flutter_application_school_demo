import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/school.dart';
import '../providers/school_provider.dart';

class ClassroomScreen extends StatefulWidget {
  @override
  _ClassroomScreenState createState() => _ClassroomScreenState();
}

class _ClassroomScreenState extends State<ClassroomScreen> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController countController = TextEditingController();

  void openClassroomDialog({Classroom? classroom}) {
    if (classroom != null) {
      codeController.text = classroom.classCode;
      nameController.text = classroom.className;
      countController.text = classroom.studentCount.toString();
    } else {
      codeController.clear();
      nameController.clear();
      countController.clear();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(classroom == null ? 'Thêm Lớp Học' : 'Cập Nhật Lớp Học'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: codeController,
              decoration: InputDecoration(labelText: 'Mã Lớp'),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Tên Lớp'),
            ),
            TextField(
              controller: countController,
              decoration: InputDecoration(labelText: 'Sĩ Số'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (codeController.text.isEmpty ||
                  nameController.text.isEmpty ||
                  countController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')),
                );
                return;
              }

              try {
                final schoolProvider = Provider.of<SchoolProvider>(context, listen: false);

                if (classroom == null) {
                  // Thêm mới: Không cần truyền id, Firestore sẽ tự sinh
                  await schoolProvider.addClassroom(
                    Classroom(
                      id: '', // Để trống, Firestore sẽ tự sinh
                      classCode: codeController.text,
                      className: nameController.text,
                      studentCount: int.parse(countController.text),
                    ),
                  );
                } else {
                  // Cập nhật: Dùng id của classroom hiện tại
                  await schoolProvider.updateClassroom(
                    Classroom(
                      id: classroom.id,
                      classCode: codeController.text,
                      className: nameController.text,
                      studentCount: int.parse(countController.text),
                    ),
                  );
                }

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(classroom == null ? 'Đã thêm lớp học' : 'Đã cập nhật lớp học')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Lỗi: $e')),
                );
              }
            },
            child: Text(classroom == null ? 'Thêm' : 'Cập Nhật'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final schoolProvider = Provider.of<SchoolProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Quản Lý Lớp Học'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openClassroomDialog(),
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<List<Classroom>>(
        stream: schoolProvider.getClassrooms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Chưa có lớp học nào'));
          }
          final classrooms = snapshot.data!;
          return ListView.builder(
            itemCount: classrooms.length,
            itemBuilder: (context, index) {
              final classroom = classrooms[index];
              return ListTile(
                title: Text('${classroom.classCode} - ${classroom.className}'),
                subtitle: Text('Sĩ số: ${classroom.studentCount}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => openClassroomDialog(classroom: classroom),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        try {
                          await schoolProvider.deleteClassroom(classroom.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Đã xóa lớp học')),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Lỗi xóa lớp học: $e')),
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
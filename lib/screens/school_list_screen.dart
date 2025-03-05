// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../models/school.dart';
// import '../providers/school_provider.dart';
// import 'school_detail_screen.dart';
// import 'add_edit_school_screen.dart';
// import 'login_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class SchoolListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final schoolProvider = Provider.of<SchoolProvider>(context);
//     final user = FirebaseAuth.instance.currentUser; 

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('SCHOOLS'),
//         actions: [
//           if (schoolProvider.isLoggedIn) ...[
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: Center(
//                 child: Text(
//                   'Xin chào, ${user?.displayName ?? user?.email ?? "Người dùng"}',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//             IconButton(
//               icon: Icon(Icons.logout),
//               tooltip: 'Đăng xuất',
//               onPressed: () async {
//                 try {
//                   await schoolProvider.signOut();
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Đã đăng xuất')),
//                   );
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) => LoginScreen()),
//                   );
//                 } catch (e) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Đăng xuất thất bại: $e')),
//                   );
//                 }
//               },
//             ),
//           ] else ...[
//             IconButton(
//               icon: Icon(Icons.login),
//               tooltip: 'Đăng nhập',
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => LoginScreen()),
//                 );
//               },
//             ),
//           ],
//         ],
//       ),
//       body: StreamBuilder<List<School>>(
//         stream: schoolProvider.getSchools(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
//           final schools = snapshot.data!;
//           return ListView.builder(
//             itemCount: schools.length,
//             itemBuilder: (context, index) {
//               final school = schools[index];
//               return ListTile(
//                 title: Text(school.name),
//                 subtitle: Text(school.address),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => SchoolDetailScreen(school: school),
//                     ),
//                   );
//                 },
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.edit),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => AddEditSchoolScreen(school: school),
//                           ),
//                         );
//                       },
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.delete),
//                       onPressed: () {
//                         schoolProvider.deleteSchool(school.id);
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => AddEditSchoolScreen()),
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/school.dart';
import '../providers/school_provider.dart';
import 'school_detail_screen.dart';
import 'add_edit_school_screen.dart';
import 'login_screen.dart';
import 'classroom_screen.dart';

class SchoolListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final schoolProvider = Provider.of<SchoolProvider>(context);
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('SCHOOLS'),
        actions: [
          if (schoolProvider.isLoggedIn) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: Text(
                  'Xin chào, ${user?.displayName ?? user?.email ?? "Người dùng"}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.class_),
              tooltip: 'Lớp học',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClassroomScreen()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.logout),
              tooltip: 'Đăng xuất',
              onPressed: () async {
                try {
                  await schoolProvider.signOut();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Đã đăng xuất')),
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Đăng xuất thất bại: $e')),
                  );
                }
              },
            ),
          ] else ...[
            IconButton(
              icon: Icon(Icons.login),
              tooltip: 'Đăng nhập',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ],
      ),
      body: StreamBuilder<List<School>>(
        stream: schoolProvider.getSchools(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final schools = snapshot.data!;
          return ListView.builder(
            itemCount: schools.length,
            itemBuilder: (context, index) {
              final school = schools[index];
              return ListTile(
                title: Text(school.name),
                subtitle: Text(school.address),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SchoolDetailScreen(school: school),
                    ),
                  );
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEditSchoolScreen(school: school),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        schoolProvider.deleteSchool(school.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEditSchoolScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
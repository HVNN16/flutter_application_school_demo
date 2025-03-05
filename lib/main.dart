import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/school_provider.dart';
import 'screens/school_list_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      
      providers: [
        ChangeNotifierProvider(create: (_) => SchoolProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'School Management',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: SchoolListScreen(),
      ),
    );
  }
}

//demo 
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'providers/school_provider.dart';
// import 'screens/login_screen.dart';
// import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   // Tạo tài khoản giáo viên mặc định (chỉ chạy một lần khi khởi động)
//   final auth = FirebaseAuth.instance;
//   try {
//     await auth.createUserWithEmailAndPassword(
//       email: 'teacher@example.com',
//       password: '123456',
//     );
//     print('Tài khoản giáo viên mặc định đã được tạo: teacher@example.com / 123456');
//   } catch (e) {
//     print('Tài khoản đã tồn tại hoặc lỗi: $e');
//   }

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => SchoolProvider()),
//       ],
//       child: MaterialApp(
//         title: 'School Management',
//         theme: ThemeData(primarySwatch: Colors.blue),
//         home: LoginScreen(),
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'school_list_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        User? user = userCredential.user;
        if (user != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Xin chào, ${user.email}!'),
              duration: Duration(seconds: 2),
            ),
          );

          await Future.delayed(Duration(seconds: 2));

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SchoolListScreen()),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đăng nhập thất bại: $e')),
        );
      }
    }
  }
Future<void> _signup() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Vui Lòng Liên Hệ QTV!!!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Đăng nhập giáo viên')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Vui lòng nhập email' : null,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Mật khẩu'),
                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Vui lòng nhập mật khẩu' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _login, child: Text('Đăng nhập')),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _signup, child: Text('Đăng kí')),
            ],
          ),
        ),
      ),
    );
  }
}
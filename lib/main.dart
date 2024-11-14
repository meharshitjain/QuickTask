import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'login_page.dart'; // Import your login page file
import 'reg_page.dart'; // Import your registration page file
import 'todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const keyApplicationId = '3zhdfDs46mQFJsCunBc5Ert7zLAFRgLFdPRM7cKD';
  const keyClientKey = 'LX63Oc6K4HK3e6HdO5KPq5TeH7SLoRLSsvzTYneS';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, debug: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quick Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(), // Ensure HomePage is defined
      routes: {
        '/login_page': (context) => LoginPage(), // Define route for login page
        '/reg_page': (context) => RegistrationPage(), // Define route for registration page
        '/todo': (context) => TodoPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 30.0), // Add top padding here
          child: Text(
            'To-Do App',
            textAlign: TextAlign.center,
          ),
        ),
        centerTitle: true, // Aligns the title to the center
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login_page');
              },
              child: const Text('Login'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/reg_page');
              },
              child: const Text('Sign Up'),
            ),
            SizedBox(height: 40),
            Text(
              'Manage your tasks efficiently!\nCreated by Harshit Jain (2023MT93342)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}




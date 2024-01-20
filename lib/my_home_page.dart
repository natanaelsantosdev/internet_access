import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool visibilityText = false;
  late String userTexte = '';

  Future<Map> getUser() async {
    var url = Uri.https('jsonplaceholder.typicode.com', '/todos/1');
    var response = await http.get(url);

    return jsonDecode(response.body);
  }

  returnGetUser() async {
    final result = await getUser();
    final user = User.fromJson(result);
    String retorno = user.toString();

    if (visibilityText == false) {
      setState(() {
        visibilityText = true;
        userTexte = retorno;
      });
    }

    return retorno;
  }

  clearText() {
    if (visibilityText == true) {
      setState(() {
        userTexte;
        visibilityText = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF512ee9),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: visibilityText,
                child: Text(
                  userTexte,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: returnGetUser,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xFF4525d1),
                  ),
                ),
                child: const Text(
                  'Get',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: clearText,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xFF4525d1),
                  ),
                ),
                child: const Text(
                  'Limpar',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class User {
  final int id;
  final int userId;
  final String title;
  final bool completed;

  User({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed,
  });

  factory User.fromJson(Map json) {
    return User(
        id: json['id'],
        userId: json['userId'],
        title: json['title'],
        completed: json['completed']);
  }

  @override
  String toString() =>
      'Id: $id\n UserId: $userId\n Title: $title\n Completed: $completed';
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_page.dart';

const List<String> input = [
  'Test 1',
  'Test 2',
  'Test 3',
  'Test 4',
  'Test 5',
  'Test 6',
  'Test 7',
  // 'Test 8',
  // 'Test 9',
  // 'Test 10',
  // 'Test 11',
  // 'Test 12',
  // 'Test 13',
  // 'Test 14',
  // 'Test 15',
  // 'Test 16',
  // 'Test 17',
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Test project',
      home: HomePage(data: input),
    );
  }
}

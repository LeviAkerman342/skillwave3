import 'package:flutter/material.dart';
import 'package:skillwave/feature/course/local_storage/local_storage_curse.dart';
import 'package:skillwave/core/data/model/course.dart';
import 'package:skillwave/feature/course/widgets/custom_card/custom_card.dart';
import 'package:skillwave/feature/presentation/bottom_bar/bottom_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      textTheme: ThemeData.light().textTheme.apply(
            bodyColor: Colors.black,
            displayColor: Colors.black,
          ),
      colorScheme: const ColorScheme.light(
        surface: Colors.white,
      ),
    );

    final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      textTheme: ThemeData.dark().textTheme.apply(
            bodyColor: Colors.black,
            displayColor: Colors.black,
          ),
      colorScheme: const ColorScheme.dark(
        surface: Colors.black,
      ),
    );

    return MaterialApp(
      theme: _isDarkMode ? darkTheme : lightTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SkillWave Курсы'),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Поиск курса...',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: LocalStorageService.courses.length,
                  itemBuilder: (context, index) {
                    Course course = LocalStorageService.courses[index];
                    return CustomCard(
                      course: course,
                      backgroundColor:
                          _isDarkMode ? Colors.grey[800] : Colors.white,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _toggleTheme,
          backgroundColor: _isDarkMode ? Colors.grey[800] : Colors.white,
          child: const Icon(Icons.color_lens),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }
}

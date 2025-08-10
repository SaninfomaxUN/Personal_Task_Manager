import 'package:flutter/material.dart';
import 'package:mobile/layout/widgets/list_tasks.dart';

import '../../config/config.dart';
import '../widgets/task_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  int _currentPageIndex = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
      _currentPageIndex = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Personal Task Manager'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Config.clear();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        indicatorColor: Color(0xE0C3FD60),
        selectedIndex: _currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.check),
            label: 'Completadas',
          ),
          NavigationDestination(
            icon: Badge(
              /*label: Text('2'),*/
              child: Icon(Icons.article_rounded),
            ),
            label: 'Mis Tareas',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.add_circle_outline)),
            label: 'Nueva Tarea',
          ),
        ],
      ),
      body: <Widget>[
        const Padding(
          padding: EdgeInsets.all(8.0),
          key: ValueKey('completed_tasks'),
          child: ListTasks(isCompleted: true),
        ),

        const Padding(
          padding: EdgeInsets.all(8.0),
          key: ValueKey('pending_tasks'),
          child: ListTasks(isCompleted: false),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          key: const ValueKey('new_task'),
          child: TaskForm(
            isUpdateMode: false,
            onTaskCalled: () {
              setState(() {
                _currentPageIndex = 1;
              });
            },
            taskId: 0,
          ),
        ),
      ][_currentPageIndex],
    );
  }
}

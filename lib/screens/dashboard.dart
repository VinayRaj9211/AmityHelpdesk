
import 'package:flutter/material.dart';
import 'package:helpdesk/screens/teams.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'complaints.dart';



class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentPageIndex = 0;

  String? username;
  int? userId;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
      userId = prefs.getInt('userid');
    });
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(

      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          const NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.question_answer_outlined),
            label: 'Complaints',
          ),
          NavigationDestination(
            icon: const Badge(child: Icon(Icons.person_3_rounded)),
            label: 'My Team',
          ),
          const NavigationDestination(
            icon: Badge(label: Text('2'), child: Icon(Icons.assessment_rounded)),
            label: 'My Labs',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        Complaints(),
        MyTeam(managerId: userId ?? 0 ),
        Complaints(),
        //Democheck(),
        /*Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(child: Text('Home page', style: theme.textTheme.titleLarge)),
          ),
        ),*/

        /// Notifications page
        //MyTeam(),


        //MyLabs()

        /// Messages page
       /* ListView.builder(
          reverse: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Hello',
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              );
            }
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Hi!',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            );
          },
        ),*/
      ][currentPageIndex],
    );
  }
}

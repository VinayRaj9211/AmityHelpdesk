import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

import '../controllers/engineer_controller.dart';
import '../models/engineer.dart';
import '../widgets/colors.dart';

class MyTeam extends StatefulWidget {
  final int managerId;
  const MyTeam({super.key, required this.managerId});

  @override
  State<MyTeam> createState() => _MyTeamState();
}

class _MyTeamState extends State<MyTeam> {
  @override
  void initState() {
    super.initState();
    _fetchTeam(); // initial load
  }

  Future<void> _fetchTeam() async {
    await Provider.of<EngineerController>(context, listen: false)
        .fetchEngineers(widget.managerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.amity_blue,
        automaticallyImplyLeading: false,
        title: const Text(
          'My Team',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Consumer<EngineerController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.engineers.isEmpty) {
            return RefreshIndicator(
              onRefresh: _fetchTeam,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 200),
                  Center(child: Text("No engineers found.")),
                ],
              ),
            );
          }

          return LiquidPullToRefresh(
            onRefresh: _fetchTeam,
            color: AppColors.amity_yellow,
            backgroundColor: AppColors.amity_blue,
            springAnimationDurationInMilliseconds: 2000,
            height: 20,
            borderWidth: 0.5,
            child: ListView.builder(
              itemCount: controller.engineers.length,
              itemBuilder: (context, index) {
                Engineer engineer = controller.engineers[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.amity_yellow,
                      radius: 20,
                      child: Text(
                        engineer.engineerName[0],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    title: Text(engineer.engineerName),
                    subtitle: Text(engineer.campusName),
                    trailing: Text(engineer.contact),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_todo_app/app/constant/app_colors.dart';
import 'package:simple_todo_app/app/screen/settings/setting_screen.dart';
import 'package:simple_todo_app/app/screen/dashboard/dashboard_screen.dart';
import 'package:simple_todo_app/app/screen/project/project_screen.dart';
import 'package:simple_todo_app/app/screen/todo/simple_todo_screen.dart';
import 'package:simple_todo_app/app/widget/navbar/bottom_navbar_button.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const DashboardScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageStorage(
            bucket: bucket,
            child: currentScreen,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 170,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.lightGrey.withOpacity(0),
                    AppColors.lightGrey,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 35,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Card(
                clipBehavior: Clip.antiAlias,
                elevation: 20,
                color: AppColors.darkGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  height: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: IconBottomNavbarButton(
                          icon: Icons.grid_view_rounded,
                          isActivate: (_currentIndex == 0),
                          onPressed: () {
                            setState(() {
                              _currentIndex = 0;
                              currentScreen = const DashboardScreen();
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconBottomNavbarButton(
                          icon: FontAwesomeIcons.peopleGroup,
                          isActivate: (_currentIndex == 1),
                          onPressed: () {
                            setState(() {
                              _currentIndex = 1;
                              currentScreen = const ProjectScreen();
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconBottomNavbarButton(
                          icon: FontAwesomeIcons.chalkboardUser,
                          isActivate: (_currentIndex == 2),
                          onPressed: () {
                            setState(() {
                              _currentIndex = 2;
                              currentScreen = const SimpleTodoScreen();
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconBottomNavbarButton(
                          icon: FontAwesomeIcons.userGear,
                          isActivate: (_currentIndex == 3),
                          onPressed: () {
                            setState(() {
                              _currentIndex = 3;
                              currentScreen = const AccountSettingScreen();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

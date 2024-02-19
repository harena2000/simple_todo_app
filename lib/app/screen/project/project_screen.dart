import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_app/app/constant/app_colors.dart';
import 'package:simple_todo_app/app/provider/project_provider.dart';
import 'package:simple_todo_app/app/screen/project/create_project_screen.dart';
import 'package:simple_todo_app/app/screen/project/project_details.screen.dart';
import 'package:simple_todo_app/app/widget/card/project_card.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int tabIndex = 0;

  final database = FirebaseFirestore.instance;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Color tabBackgroundColor() {
    if (tabIndex == 1) {
      return AppColors.darkGrey;
    } else if (tabIndex == 2) {
      return Colors.green;
    }
    return AppColors.orange;
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations word = AppLocalizations.of(context)!;
    return Consumer<ProjectProvider>(builder: (context, projectProvider, _) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: Container(),
          leadingWidth: 10,
          toolbarHeight: 90,
          scrolledUnderElevation: 50,
          backgroundColor: AppColors.green,
          foregroundColor: Colors.white,
          title: MediaQuery(
            data: const MediaQueryData(
              textScaler: TextScaler.linear(0.8),
            ),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.lightGrey.withOpacity(0.5),
                  ),
                  child: const Icon(
                    FontAwesomeIcons.userGroup,
                    size: 18,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(word.projectMonitoring,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      word.myWorkspace,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            SizedBox(
              height: 50,
              width: 50,
              child: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    builder: (context) => SizedBox(
                      height: MediaQuery.of(context).size.height - 100,
                      child: const CreateProjectScreen(),
                    ),
                  );
                },
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.lightGrey.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                icon: const Icon(
                  FontAwesomeIcons.plus,
                  size: 18,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        body: MediaQuery(
          data: const MediaQueryData(
            textScaler: TextScaler.linear(0.8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                        color: tabBackgroundColor(),
                      ),
                      onTap: (value) {
                        setState(() {
                          tabIndex = value;
                        });
                      },
                      dividerColor: Colors.transparent,
                      splashBorderRadius: BorderRadius.circular(30),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(
                          text: word.progress,
                        ),
                        Tab(
                          text: word.paused,
                        ),
                        Tab(
                          text: word.done,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    clipBehavior: Clip.antiAlias,
                    children: [
                      // first tab bar view widget
                      projectProvider.projectListInProgress.isEmpty
                          ? const Center(
                              child: Text(
                                "No data set",
                              ),
                            )
                          : AnimatedList(
                              initialItemCount:
                                  projectProvider.projectListInProgress.length,
                              itemBuilder: (context, index, animation) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: ProjectCard(
                                    width: MediaQuery.of(context).size.width,
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => ProjectDetailsScreen(
                                            projectModel: projectProvider
                                                .projectListInProgress[index],
                                          ),
                                        ),
                                      );
                                    },
                                    projectModel: projectProvider
                                        .projectListInProgress[index],
                                  ),
                                );
                              }),

                      // second tab bar view widget
                      projectProvider.projectListOnPause.isEmpty
                          ? const Center(
                              child: Text(
                                "No data set",
                              ),
                            )
                          : ListView.builder(
                              itemCount:
                                  projectProvider.projectListOnPause.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: ProjectCard(
                                    width: MediaQuery.of(context).size.width,
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => ProjectDetailsScreen(
                                            projectModel: projectProvider
                                                .projectListOnPause[index],
                                          ),
                                        ),
                                      );
                                    },
                                    projectModel: projectProvider
                                        .projectListOnPause[index],
                                  ),
                                );
                              }),

                      projectProvider.projectListClosed.isEmpty
                          ? const Center(
                              child: Text(
                                "No data set",
                              ),
                            )
                          : ListView.builder(
                              itemCount:
                                  projectProvider.projectListClosed.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: ProjectCard(
                                    width: MediaQuery.of(context).size.width,
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => ProjectDetailsScreen(
                                            projectModel: projectProvider
                                                .projectListClosed[index],
                                          ),
                                        ),
                                      );
                                    },
                                    projectModel: projectProvider
                                        .projectListClosed[index],
                                  ),
                                );
                              }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

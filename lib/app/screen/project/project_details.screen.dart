import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simple_todo_app/app/constant/app_colors.dart';
import 'package:simple_todo_app/app/model/project_model.dart';
import 'package:simple_todo_app/app/widget/card/project_card.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final ProjectModel projectModel;

  const ProjectDetailsScreen({
    super.key,
    required this.projectModel,
  });

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations word = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: Container(),
        leadingWidth: 10,
        toolbarHeight: 90,
        scrolledUnderElevation: 50,
        backgroundColor: AppColors.green,
        foregroundColor: Colors.white,
        title: Row(
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
                Text(word.teamWorkspace,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  "Mahefaniaina Harena Rico",
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w100),
                ),
              ],
            ),
          ],
        ),
        actions: [
          SizedBox(
            height: 50,
            width: 50,
            child: IconButton(
              onPressed: () {},
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            bottom: TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  15,
                ),
                color: Colors.green,
              ),
              dividerColor: Colors.transparent,
              splashBorderRadius: BorderRadius.circular(30),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: [
                // first tab [you can add an icon using the icon property]
                Tab(
                  text: word.projectAssigned,
                ),

                // second tab [you can add an icon using the icon property]
                Tab(
                  text: word.projectCreated,
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              clipBehavior: Clip.antiAlias,
              children: [
                // first tab bar view widget
                ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ProjectCard(
                        width: MediaQuery.of(context).size.width,
                        projectModel: ProjectModel(
                          title: "Bonjour Title",
                          description: "Voici le description du projet",
                          projectCreator: "Me",
                          projectId: "eefsge",
                        ),
                      ),
                    );
                  },
                ),

                // second tab bar view widget
                ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ProjectCard(
                        width: MediaQuery.of(context).size.width,
                        projectModel: ProjectModel(
                          title: "Bonjour Title",
                          description: "Voici le description du projet",
                          projectCreator: "Me",
                          projectId: "eefsge",
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

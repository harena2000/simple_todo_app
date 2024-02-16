import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_todo_app/app/constant/app_colors.dart';
import 'package:simple_todo_app/app/model/project_model.dart';
import 'package:simple_todo_app/app/model/todo_model.dart';
import 'package:simple_todo_app/app/widget/card/project_card.dart';
import 'package:simple_todo_app/app/widget/card/todo_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations word = AppLocalizations.of(context)!;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          leading: Container(),
          leadingWidth: 10,
          toolbarHeight: 90,
          scrolledUnderElevation: 50,
          pinned: true,
          stretch: true,
          backgroundColor: AppColors.green,
          foregroundColor: Colors.white,
          title: FadeIn(
            duration: const Duration(milliseconds: 300),
            child: Row(
              children: [
                SlideInLeft(
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.lightGrey.withOpacity(0.5),
                    ),
                    child: Icon(FontAwesomeIcons.user),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                SlideInRight(
                  duration: const Duration(milliseconds: 300),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(word.welcome,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        "Mahefaniaina Harena Rico",
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w100),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              FadeIn(
                duration: const Duration(milliseconds: 300),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, top: 25, bottom: 10),
                  child: Text(
                    word.projectMonitoring,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              FadeIn(
                duration: const Duration(milliseconds: 300),
                child: SizedBox(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      5,
                      (index) => Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: ProjectCard(
                          onTap: () {},
                          projectModel: ProjectModel(
                            title: "My Project Name is Long",
                            description: 'Project Description',
                            projectCreator: "Harena Rico",
                            projectId: "",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FadeIn(
                duration: const Duration(milliseconds: 300),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, top: 25, bottom: 10),
                  child: Text(
                    word.todaysTask,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FadeIn(
                duration: const Duration(milliseconds: 300),
                child: Wrap(
                  direction: Axis.horizontal,
                  children: List.generate(
                    5,
                    (index) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: TodoCard(
                        todoModel: TodoModel(
                          title: "Task title $index",
                          taskStart: DateTime.tryParse("2024-01-12"),
                          description:
                              "An on the Flutter SDK's standard ExpansionTile, to create a Google Material Theme inspired raised widget, ExpansionTileCard, instead.",
                          flag: TodoFlag.urgently,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 150,
              )
            ],
          ),
        ),
      ],
    );
  }
}

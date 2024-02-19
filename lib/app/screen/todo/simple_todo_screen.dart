import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simple_todo_app/app/constant/app_colors.dart';
import 'package:simple_todo_app/app/model/todo_model.dart';
import 'package:simple_todo_app/app/screen/todo/create_todo_task_screen.dart';
import 'package:simple_todo_app/app/widget/card/todo_card.dart';

class SimpleTodoScreen extends StatefulWidget {
  const SimpleTodoScreen({super.key});

  @override
  State<SimpleTodoScreen> createState() => _SimpleTodoScreenState();
}

class _SimpleTodoScreenState extends State<SimpleTodoScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int tabIndex = 0;

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

  Color tabBackgroundColor() {
    if (tabIndex == 1) {
      return Colors.green;
    }
    return AppColors.orange;
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations word = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
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
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.lightGrey.withOpacity(0.5),
                  ),
                  child: const Icon(
                    FontAwesomeIcons.chevronLeft,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Project Name",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    word.teamWorkspace,
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
                    child: const CreateTodoTaskScreen(),
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
                    ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: TodoCard(
                            todoModel: TodoModel(
                              title: "Task title $index",
                              description:
                                  "An on the Flutter SDK's standard ExpansionTile, to create a Google Material Theme inspired raised widget, ExpansionTileCard, instead.",
                              flag: TodoFlag.urgently,
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
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: TodoCard(
                            todoModel: TodoModel(
                              title: "Task title $index",
                              description:
                                  "An on the Flutter SDK's standard ExpansionTile, to create a Google Material Theme inspired raised widget, ExpansionTileCard, instead.",
                              flag: TodoFlag.urgently,
                              status: true,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_app/app/constant/app_colors.dart';
import 'package:simple_todo_app/app/model/project_model.dart';
import 'package:simple_todo_app/app/model/todo_model.dart';
import 'package:simple_todo_app/app/provider/project_provider.dart';
import 'package:simple_todo_app/app/screen/create_todo_task_screen.dart';
import 'package:simple_todo_app/app/widget/button/simple_button.dart';
import 'package:simple_todo_app/app/widget/card/todo_card.dart';
import 'package:simple_todo_app/app/widget/loader/loader.dart';

class ProjectDetailsScreen extends StatefulWidget {
  const ProjectDetailsScreen({
    super.key,
  });

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int tabIndex = 0;
  List<TodoModel> taskListInProgress = [];
  List<TodoModel> taskListClosed = [];
  bool isLoading = false;

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

  void sortProjectTaskByStatus(List<TodoModel> todoList) {
    taskListInProgress.clear();
    taskListClosed.clear();
    taskListInProgress.addAll(todoList.where((element) => !element.status!));
    taskListClosed.addAll(todoList.where((element) => element.status!));
  }

  Future<void> onChecked(
    ProjectProvider projectProvider,
    List<TodoModel> todoList,
    int index,
    bool value,
  ) async {
    setState(() {
      isLoading = true;
    });
    await projectProvider.toggleTask(
      index,
      todoList[index],
      value,
    );
    setState(() {
      todoList.removeAt(index);
      isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: AppColors.green,
        content: Text(
          "The task is changed successfully",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<void> onDelete(
    ProjectProvider projectProvider,
    List<TodoModel> todoList,
    int index,
  ) async {
    setState(() {
      isLoading = true;
    });
    await projectProvider.deleteTask(
      todoList[index],
    );
    setState(() {
      todoList.removeAt(index);
      isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: AppColors.green,
        content: Text(
          "The task has been deleted successfully",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations word = AppLocalizations.of(context)!;
    return Consumer<ProjectProvider>(builder: (context, projectProvider, _) {
      sortProjectTaskByStatus(projectProvider.selectedProject.todoTaskList!);
      return ModalProgressHUD(
        inAsyncCall: isLoading,
        progressIndicator: const Loader(),
        child: Scaffold(
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
                    borderRadius: BorderRadius.circular(15),
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
                      Text(
                        word.projectMonitoring,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
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
                        child: CreateTodoTaskScreen(
                          projectModel: projectProvider.selectedProject,
                        ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          projectProvider.selectedProject.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          projectProvider.selectedProject.description,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: projectProvider.selectedProject.status !=
                              ProjectStatus.closed,
                          child: IgnorePointer(
                            ignoring: taskListInProgress.isNotEmpty,
                            child: SizedBox(
                              width: 150,
                              height: 40,
                              child: SimpleButton(
                                onPressed: () async {
                                  try {
                                    await projectProvider.closeProject();
                                    Navigator.of(context).pop();
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                backgroundColor: taskListInProgress.isNotEmpty
                                    ? AppColors.grey
                                    : AppColors.green,
                                text: word.closeProject,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: projectProvider.selectedProject.status ==
                              ProjectStatus.closed,
                          child: Text(
                            word.projectAlreadyClosed,
                            style: const TextStyle(
                              color: AppColors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
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
                        taskListInProgress.isEmpty
                            ? const Center(
                                child: Text("No Data Set"),
                              )
                            : ListView.builder(
                                itemCount: taskListInProgress.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: TodoCard(
                                      todoModel: taskListInProgress[index],
                                      onChecked: (value) async {
                                        await onChecked(
                                          projectProvider,
                                          taskListInProgress,
                                          index,
                                          value,
                                        );
                                      },
                                      onDelete: () async {
                                        await onDelete(
                                          projectProvider,
                                          taskListInProgress,
                                          index,
                                        );
                                      },
                                      onEdit: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          useSafeArea: true,
                                          builder: (context) => SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height -
                                                100,
                                            child: CreateTodoTaskScreen(
                                              projectModel: projectProvider
                                                  .selectedProject,
                                              todoModel:
                                                  taskListInProgress[index],
                                              index: index,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),

                        // second tab bar view widget
                        taskListClosed.isEmpty
                            ? const Center(
                                child: Text("No Data Set"),
                              )
                            : ListView.builder(
                                itemCount: taskListClosed.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: TodoCard(
                                      todoModel: taskListClosed[index],
                                      onDelete: () async {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            backgroundColor: AppColors.orange,
                                            content: Text(
                                              "Once a task is mark as done, you can't delete it!",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      onEdit: () async {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            backgroundColor: AppColors.orange,
                                            content: Text(
                                              "Once a task is mark as done, you can't edit it!",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
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
        ),
      );
    });
  }
}

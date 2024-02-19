import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_app/app/constant/app_colors.dart';
import 'package:simple_todo_app/app/model/project_model.dart';
import 'package:simple_todo_app/app/model/todo_model.dart';
import 'package:simple_todo_app/app/provider/project_provider.dart';
import 'package:simple_todo_app/app/widget/button/simple_button.dart';
import 'package:simple_todo_app/app/widget/loader/loader.dart';
import 'package:simple_todo_app/app/widget/text_field/custom_text_field.dart';

class CreateTodoTaskScreen extends StatefulWidget {
  final ProjectModel? projectModel;
  final TodoModel? todoModel;
  final int? index;

  const CreateTodoTaskScreen({
    super.key,
    this.projectModel,
    this.todoModel,
    this.index,
  });

  @override
  State<CreateTodoTaskScreen> createState() => _CreateTodoTaskScreenState();
}

class _CreateTodoTaskScreenState extends State<CreateTodoTaskScreen> {
  String title = "";
  String description = "";
  TodoFlag flag = TodoFlag.none;
  final _inputFormKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isEditForm = false;

  void editForm() {
    if (widget.todoModel != null) {
      setState(() {
        flag = widget.todoModel!.flag!;
        title = widget.todoModel!.title;
        description = widget.todoModel!.description;
        isEditForm = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    editForm();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations word = AppLocalizations.of(context)!;
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        progressIndicator: const Loader(),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      word.createTask,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(FontAwesomeIcons.xmark),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Tag",
                      ),
                      SizedBox(
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  flag = TodoFlag.none;
                                });
                              },
                              child: Chip(
                                labelStyle: TextStyle(
                                  color: flag == TodoFlag.none
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 11,
                                  fontWeight: flag == TodoFlag.none
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                                side: const BorderSide(color: AppColors.blue),
                                backgroundColor: flag == TodoFlag.none
                                    ? AppColors.blue
                                    : Colors.transparent,
                                label: Text(
                                  word.calm,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  flag = TodoFlag.medium;
                                });
                              },
                              child: Chip(
                                labelStyle: TextStyle(
                                  color: flag == TodoFlag.medium
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 11,
                                  fontWeight: flag == TodoFlag.medium
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                                side: const BorderSide(color: AppColors.orange),
                                backgroundColor: flag == TodoFlag.medium
                                    ? AppColors.orange
                                    : Colors.transparent,
                                label: Text(
                                  word.medium,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  flag = TodoFlag.important;
                                });
                              },
                              child: Chip(
                                labelStyle: TextStyle(
                                  color: flag == TodoFlag.important
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 11,
                                  fontWeight: flag == TodoFlag.important
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                                side: const BorderSide(
                                    color: AppColors.darkGreen),
                                backgroundColor: flag == TodoFlag.important
                                    ? AppColors.darkGreen
                                    : Colors.transparent,
                                label: Text(
                                  word.important,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  flag = TodoFlag.urgently;
                                });
                              },
                              child: Chip(
                                labelStyle: TextStyle(
                                  color: flag == TodoFlag.urgently
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 11,
                                  fontWeight: flag == TodoFlag.urgently
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                                side: const BorderSide(color: AppColors.red),
                                backgroundColor: flag == TodoFlag.urgently
                                    ? AppColors.red
                                    : Colors.transparent,
                                label: Text(
                                  word.urgently,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      textInputForm(word),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: SimpleButton(
                  text: isEditForm ? word.edit : word.save,
                  backgroundColor:
                      isEditForm ? AppColors.orange : AppColors.green,
                  onPressed: () async {
                    if (_inputFormKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      TodoModel todoModel = TodoModel(
                        title: title,
                        description: description,
                        flag: flag,
                      );
                      if (widget.projectModel != null) {
                        try {
                          if (isEditForm) {
                            await Provider.of<ProjectProvider>(context,
                                    listen: false)
                                .editTask(
                              virtualIndex: widget.index!,
                              editedTask: todoModel,
                              oldTask: widget.todoModel!,
                            );
                          } else {
                            await Provider.of<ProjectProvider>(context,
                                    listen: false)
                                .addTask(todoModel);
                          }
                          Navigator.of(context).pop();
                        } catch (e) {
                          print(e);
                        }
                      }
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textInputForm(AppLocalizations word) {
    return Form(
      key: _inputFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            word.title,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            hintText: word.enterTitle,
            icon: FontAwesomeIcons.t,
            initialValue:
                widget.todoModel != null ? widget.todoModel!.title : "",
            validator: (value) {
              if (value!.isEmpty) {
                return word.inputEmptyError;
              }
              return null;
            },
            onChange: (value) {
              setState(() {
                title = value;
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            word.description,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            hintText: word.enterDescription,
            maxLines: 8,
            initialValue:
                widget.todoModel != null ? widget.todoModel!.description : "",
            onChange: (value) {
              setState(() {
                description = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_todo_app/app/constant/app_colors.dart';
import 'package:simple_todo_app/app/model/todo_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TodoCard extends StatefulWidget {
  final TodoModel todoModel;
  const TodoCard({super.key, required this.todoModel});

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();

    isChecked = widget.todoModel.status!;
    print(DateTime.now().toString());
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations word = AppLocalizations.of(context)!;

    return ExpansionTileCard(
      borderRadius: BorderRadius.circular(30),
      heightFactorCurve: Curves.easeInOut,
      paddingCurve: Curves.easeInOut,
      leading: Container(
        height: 40,
        width: 5,
        decoration: BoxDecoration(
          color: AppColors.green,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      title: Text(
        widget.todoModel.title,
        maxLines: 2,
        overflow: TextOverflow.fade,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                FontAwesomeIcons.calendarCheck,
                size: 13,
              ),
              Container(
                  margin: const EdgeInsets.only(top: 1, left: 5),
                  child: Text(
                      taskStartingStatus(widget.todoModel.taskStart!, word))),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Chip(
                labelStyle: TextStyle(color: Colors.white, fontSize: 11),
                side: BorderSide.none,
                backgroundColor: widget.todoModel.flag.flagColor,
                label: Text(
                  flagString(widget.todoModel.flag, word),
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: Transform.scale(
        scale: 1.5,
        child: Checkbox(
          value: isChecked,
          checkColor: Colors.white,
          activeColor: AppColors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          side: const BorderSide(color: AppColors.green, width: 1.5),
          onChanged: (value) {
            print(value);
            setState(() {
              isChecked = value!;
            });
          },
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                word.descriptionTask,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.todoModel.description,
              ),
            ],
          ),
        )
      ],
    );
  }

  String taskStartingStatus(DateTime taskDateTime, AppLocalizations word) {
    DateTime dateNow = DateTime.now();
    Duration differenceInDays = dateNow.difference(taskDateTime);
    if (differenceInDays.inDays == 0 && differenceInDays.inHours >= 0) {
      return word.today;
    } else if (differenceInDays.inDays == 1) {
      return word.tomorrowTask;
    } else if (differenceInDays.inDays <= 0 && differenceInDays.inHours < 0) {
      return word.taskLate((differenceInDays.inDays.abs() + 1),
          (differenceInDays.inDays.abs() + 1) > 1 ? "s" : "");
    } else {
      return word.taskDaysLeft(differenceInDays.inDays);
    }
  }

  String flagString(TodoFlag flag, AppLocalizations word) {
    if (flag == TodoFlag.urgently) {
      return word.urgently;
    } else if (flag == TodoFlag.important) {
      return word.important;
    } else if (flag == TodoFlag.medium) {
      return word.medium;
    }
    return word.calm;
  }
}

extension TodoFlagColor on TodoFlag {
  Color get flagColor {
    switch (this) {
      case TodoFlag.urgently:
        return AppColors.red;
      case TodoFlag.important:
        return AppColors.darkGreen;
      case TodoFlag.medium:
        return AppColors.orange;
      default:
        return AppColors.blue;
    }
  }
}

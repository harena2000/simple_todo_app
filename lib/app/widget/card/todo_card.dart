import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_todo_app/app/constant/app_colors.dart';
import 'package:simple_todo_app/app/model/todo_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoCard extends StatefulWidget {
  final TodoModel todoModel;
  final void Function(bool value)? onChecked;
  final void Function()? onDelete;
  final void Function()? onEdit;
  const TodoCard(
      {super.key,
      required this.todoModel,
      this.onChecked,
      this.onDelete,
      this.onEdit});

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();

    isChecked = widget.todoModel.status!;
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations word = AppLocalizations.of(context)!;

    return Slidable(
      key: UniqueKey(),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dragDismissible: false,
        openThreshold: 0.5,
        children: [
          SlidableAction(
            onPressed: (context) {
              if (widget.onDelete != null) {
                widget.onDelete!();
              }
            },
            backgroundColor: Colors.transparent,
            foregroundColor: const Color(0xFFEE6258),
            icon: FontAwesomeIcons.trash,
            label: word.delete,
          ),
          SlidableAction(
            onPressed: (context) {
              if (widget.onEdit != null) {
                widget.onEdit!();
              }
            },
            foregroundColor: AppColors.grey,
            backgroundColor: Colors.transparent,
            icon: FontAwesomeIcons.squarePen,
            label: word.edit,
          ),
        ],
      ),
      child: ExpansionTileCard(
        initiallyExpanded: true,
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
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Chip(
              labelStyle: const TextStyle(color: Colors.white, fontSize: 11),
              side: BorderSide.none,
              backgroundColor: widget.todoModel.flag!.flagColor,
              label: Text(
                flagString(widget.todoModel.flag!, word),
              ),
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
              if (widget.onChecked != null) {
                setState(() {
                  isChecked = value!;
                });
                widget.onChecked!(value!);
              }
            },
          ),
        ),
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    word.descriptionTask,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.todoModel.description,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
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

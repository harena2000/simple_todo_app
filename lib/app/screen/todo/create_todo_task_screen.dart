import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_todo_app/app/widget/button/simple_button.dart';
import 'package:simple_todo_app/app/widget/text_field/custom_text_field.dart';

class CreateTodoTaskScreen extends StatefulWidget {
  const CreateTodoTaskScreen({super.key});

  @override
  State<CreateTodoTaskScreen> createState() => _CreateTodoTaskScreenState();
}

class _CreateTodoTaskScreenState extends State<CreateTodoTaskScreen> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations word = AppLocalizations.of(context)!;
    return SafeArea(
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
                child: textInputForm(word),
              ),
            ),
            SizedBox(
              height: 50,
              child: SimpleButton(
                text: word.createProject,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textInputForm(AppLocalizations word) {
    return Column(
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
          validator: (value) {
            if (value!.isEmpty) {
              return word.inputEmptyError;
            }
            return null;
          },
          onChange: (value) {},
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
          onChange: (value) {},
        ),
      ],
    );
  }
}

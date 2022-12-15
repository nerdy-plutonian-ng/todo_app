import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/common_functions/app_ops.dart';
import 'package:todo_app/utilities/app_enums.dart';
import 'package:todo_app/widgets/stadium_button.dart';

class NoTodos extends StatelessWidget {
  const NoTodos({Key? key, required this.isMobile}) : super(key: key);

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 256,
            child: Text(
              AppLocalizations.of(context)!.addOneDesc,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          StadiumButton(
              text: AppLocalizations.of(context)!.addOne,
              action: () =>
                  createEditTodo(context, isMobile, CurrentAction.creating))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todo_app/layouts/mobile/mobile_home_layout.dart';
import 'package:todo_app/layouts/tablet/tablet_home_layout.dart';
import 'package:todo_app/widgets/my_layout_builder.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyLayoutBuilder(
        mobileLayout: MobileHomeLayout(), tabletLayout: TabletHomeLayout());
  }
}

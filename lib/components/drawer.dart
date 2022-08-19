import 'package:flutter/material.dart';
import 'package:sumry_app/components/images.dart';

import '../data/models/pair.dart';
import '../utils/res/res_profile.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var selected = 0;

  @override
  Widget build(BuildContext context) {
    final items = [
      Pair(Icons.home, ResDrawer.home),
      Pair(Icons.info, ResDrawer.about),
      Pair(Icons.login, ResDrawer.login),
      Pair(Icons.comment, ResDrawer.comment),
    ].asMap().entries;
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            accountName: null,
            accountEmail: null,
            currentAccountPicture: UserImage(null),
            decoration: BoxDecoration(color: Colors.transparent),
          ),
          ...items
              .map(
                (e) => DrawerItem(
                  icon: e.value.first,
                  title: e.value.second,
                  selected: e.key == selected,
                ),
              )
              .toList()
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function()? onClicked;
  final bool selected;

  const DrawerItem({
    Key? key,
    required this.icon,
    required this.title,
    this.onClicked,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      selectedColor: theme.colorScheme.secondary,
      selected: selected,
      onTap: onClicked,
      leading: Icon(
        icon,
        color: theme.colorScheme.primary,
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyText1?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

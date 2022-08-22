import 'package:flutter/material.dart';

import '../utils/designs/routes.dart';
import '../utils/res/res_profile.dart';
import 'images.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  static const _items = [
    [
      Icons.home,
      ResDrawer.home,
      Routes.home,
    ],
    [
      Icons.info,
      ResDrawer.about,
      Routes.about,
    ],
    [
      Icons.login,
      ResDrawer.login,
      Routes.login,
    ],
    [
      Icons.comment,
      ResDrawer.comment,
      Routes.comment,
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            accountName: null,
            accountEmail: null,
            currentAccountPicture: UserImage(null),
            decoration: BoxDecoration(color: Colors.transparent),
          ),
          ..._items
              .asMap()
              .entries
              .map(
                (e) => DrawerItem(
                  icon: e.value[0] as IconData,
                  title: e.value[1] as String,
                  onClick: () {
                    _navigate(e.value[2] as String, context);
                  },
                  selected: _currentRoute(e.value[2] as String, context),
                ),
              )
              .toList()
        ],
      ),
    );
  }

  void _navigate(String route, BuildContext context) {
    final navigator = Navigator.of(context);
    navigator.pop();

    if (route != ModalRoute.of(context)?.settings.name) {
      navigator.pushNamed(route);
    }
  }

  bool _currentRoute(String route, BuildContext context) {
    return route == ModalRoute.of(context)?.settings.name;
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function()? onClick;
  final bool selected;

  const DrawerItem({
    Key? key,
    required this.icon,
    required this.title,
    this.onClick,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      tileColor: selected ? theme.colorScheme.secondary : Colors.transparent,
      onTap: onClick,
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

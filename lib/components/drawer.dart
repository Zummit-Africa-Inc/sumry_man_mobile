import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repository/user_repository.dart';
import '../utils/designs/routes.dart';
import '../utils/res/res_profile.dart';
import 'images.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(userRepository.notifier);
    final user = ref.watch(userRepository);
    final username = user?.displayName;
    final email = user?.email;
    final theme = Theme.of(context);

    final items = [
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
      if (!repo.authenticated)
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
      if (repo.authenticated)
        [
          Icons.logout,
          ResDrawer.logout,
          Routes.login,
        ],
    ];
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: username == null
                ? null
                : Text(
                    username,
                    style: theme.textTheme.headline6,
                  ),
            accountEmail: email == null
                ? null
                : Text(
                    email,
                    style: theme.textTheme.bodyText2,
                  ),
            currentAccountPicture: const UserImage(),
            decoration: const BoxDecoration(color: Colors.transparent),
          ),
          ...items.asMap().entries.map(
            (e) {
              final icon = e.value[0] as IconData;
              final title = e.value[1] as String;
              final route = e.value[2] as String;
              return DrawerItem(
                icon: icon,
                title: title,
                onClick: () {
                  if (title == ResDrawer.logout) {
                    repo.logout();
                  }
                  _navigate(route, context);
                },
                selected: _currentRoute(route, context),
              );
            },
          ).toList()
        ],
      ),
    );
  }

  void _navigate(String route, BuildContext context) {
    final navigator = Navigator.of(context);
    navigator.pop();

    if (route == Routes.login) {
      navigator.pushNamedAndRemoveUntil(
        route,
        ModalRoute.withName(
          Routes.splash,
        ),
      );
      return;
    }

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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:retcon_frontend/providers/providers.dart';
import 'package:yaru/yaru.dart';

import '../core/app_theme.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

class NavLayout extends ConsumerWidget {

  final Widget? child;

  final _items = <String, (Widget, Widget, String)> {
    "/apps/": (
    const Icon(YaruIcons.application_bag),
    const Icon(YaruIcons.application_bag_filled),
    'Applications'
    ),
    "/users/": (
    const Icon(YaruIcons.users),
    const Icon(YaruIcons.users_filled),
    'Users'
    ),
  };

  NavLayout({super.key, this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navValue = ref.watch(navSelectionProvider);
    return Scaffold(
      key: _scaffoldKey,
      drawer: _Drawer(
        selectedIndex: navValue,
        onSelected: (index) {
          ref.watch(navSelectionProvider.notifier).update(index);
          context.go(_items.entries.elementAt(index).key);
        },
        items: _items,
      ),
      appBar: AppBar(
        leading: Center(
          child: IconButton(
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            icon: const Icon(YaruIcons.menu),
          ),
        ),
        title: const _Title(),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return Row(
              children: [
                NavigationRail(
                    destinations: [
                      for (final item in _items.entries)
                        NavigationRailDestination(
                          icon: item.value.$1,
                          selectedIcon: item.value.$2,
                          label: Text(item.value.$3),
                        ),
                    ],
                    selectedIndex: navValue,
                    onDestinationSelected: (index) {
                      ref.watch(navSelectionProvider.notifier).update(index);
                      context.go(_items.entries.elementAt(index).key);
                    },
                ),
                const VerticalDivider(
                  width: 0.0,
                ),
                Expanded(
                  child: Center(
                    child: child,
                  ),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: child,
                  ),
                ),
                const Divider(
                  height: 0.0,
                ),
                NavigationBar(
                  destinations: [
                    for (final item in _items.entries)
                      NavigationDestination(
                        icon: item.value.$1,
                        selectedIcon: item.value.$2,
                        label: item.value.$3,
                      ),
                  ],
                  selectedIndex: navValue,
                  onDestinationSelected: (index) {
                    ref.watch(navSelectionProvider.notifier).update(index);
                    context.go(_items.entries.elementAt(index).key);
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    final theme = YaruTheme.of(context);
    var light = theme.themeMode == ThemeMode.light;

    return IconButton(
      onPressed: () {
        return AppTheme.apply(
          context,
          themeMode: light ? ThemeMode.dark : ThemeMode.light,
        );
      },
      icon: Icon(
        light ? YaruIcons.sun_filled : YaruIcons.clear_night_filled,
      ),
    );
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer({
    required this.items,
    required this.onSelected,
    required this.selectedIndex,
  });

  final Map<String, (Widget, Widget, String)> items;
  final Function(int index) onSelected;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Text('retcon'),
          ),
          for (var i = 0; i < items.length; i++)
            ListTile(
              selected: i == selectedIndex,
              leading: i == selectedIndex
                  ? items.entries.elementAt(i).value.$2
                  : items.entries.elementAt(i).value.$1,
              title: Text(items.entries.elementAt(i).value.$3),
              onTap: () => onSelected(i),
            ),
        ],
      ),
    );
  }
}

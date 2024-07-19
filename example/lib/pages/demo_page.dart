import 'package:example/pages/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';

Map<String, ContextMenu> _contextMenus() => {
      "Default (built-in)": ContextMenu(entries: defaultContextMenuItems),
      "Custom\n\nmax width: 200\npadding: 0": ContextMenu(
        entries: customContextMenuItems,
        maxHeight: 200,
        padding: EdgeInsets.zero,
      ),
      "Custom with box decoration\n\npadding: horizontal(8)": ContextMenu(
        entries: customContextMenuItems,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        boxDecoration: BoxDecoration(
          color: Colors.blue.shade900,
          borderRadius: BorderRadius.zero,
          boxShadow: const [
            BoxShadow(
              offset: Offset(5, 5),
              blurRadius: 0.5,
            )
          ],
        ),
      ),
      "Default\n\nposition (x: 50, y: 30)\npadding: 0": ContextMenu(
        entries: defaultContextMenuItems,
        padding: EdgeInsets.zero,
        position: const Offset(50, 30),
      )
    };

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Flutter Context Menu Demo"),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 16 / 9,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          final colorScheme = Theme.of(context).colorScheme;
          final color = Colors.primaries[index % Colors.primaries.length];

          final entry = _contextMenus().entries.toList()[index];
          return ContextMenuRegion(
            contextMenu: entry.value,
            onItemSelected: (value) => onItemSelected(context, value),
            child: Container(
              color: color,
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  entry.key,
                  style: TextStyle(color: colorScheme.surface),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void onItemSelected(BuildContext context, dynamic value) {
    if (value == null) return;
    ScaffoldMessenger.maybeOf(context)?.clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("[ $value ] Selected")),
    );
  }
}

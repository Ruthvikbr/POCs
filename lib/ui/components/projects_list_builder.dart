import 'package:flutter/material.dart';
import 'package:pocs/ui/components/empty_list_view.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemBuilder<T> extends StatelessWidget {
  const ListItemBuilder({
    Key? key,
    required this.snapshot,
    required this.itemWidgetBuilder,
  }) : super(key: key);

  final ItemWidgetBuilder<T> itemWidgetBuilder;
  final AsyncSnapshot<List<T>> snapshot;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData && snapshot.data != null) {
      final List<T> items = snapshot.data!;
      if (items.isNotEmpty) {
        return _buildList(items);
      } else {
        return const EmptyListContent();
      }
    } else if (snapshot.hasError) {
      return const EmptyListContent(
        message: "Something went wrong",
      );
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildList(List<T> items) {
    return ListView.separated(
      itemCount: items.length + 2,
      separatorBuilder: (context, index) => const Divider(
        height: 0.5,
      ),
      itemBuilder: (context, index) {
        if (index == 0 || index == items.length + 1) {
          return Container();
        }
        return itemWidgetBuilder(context, items[index - 1]);
      },
    );
  }
}

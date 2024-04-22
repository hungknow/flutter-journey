import 'package:flutter/material.dart';

// https://api.flutter.dev/flutter/widgets/AnimatedGrid-class.html

class AnimatedGridWidget extends StatefulWidget {
  const AnimatedGridWidget({super.key});

  @override
  State<StatefulWidget> createState() => AnimatedGridWidgetState();
}

class AnimatedGridWidgetState extends State<AnimatedGridWidget> {
  final GlobalKey<AnimatedGridState> _gridKey = GlobalKey<AnimatedGridState>();
  late ListModel<int> _list;
  int? _selectedItem;
  // The next item inserted when the user presses the '+' button.
  late int _nextItem;

  void _insert() {
    final int index =
        _selectedItem == null ? _list.length : _list.indexOf(_selectedItem!);
    setState(() {
      _list.insert(index, _nextItem++);
    });
  }

  void _remove() {
    if (_selectedItem != null) {
      setState(() {
        _list.removeAt(_list.indexOf(_selectedItem!));
        _selectedItem = null;
      });
    } else if (_list.length > 0) {
      setState(() {
        _list.removeAt(_list.length - 1);
      });
    }
  }

  Widget _buildRemovedItem(
      int item, BuildContext context, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: item,
      removing: true,
      // No gesture detector here: we don't want removed items to be interactive.
    );
  }

  @override
  void initState() {
    super.initState();
    _list = ListModel<int>(
      listKey: _gridKey,
      initialItems: <int>[0, 1, 2, 3, 4, 5],
      removedItemBuilder: _buildRemovedItem,
    );
    _nextItem = 6;
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: _list[index],
      selected: _selectedItem == _list[index],
      onTap: () {
        setState(() {
          _selectedItem = _selectedItem == _list[index] ? null : _list[index];
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle),
              iconSize: 32,
              onPressed: (_list.length > 0) ? _remove : null,
              tooltip: 'remove the selected item',
            ),
            IconButton(
              icon: const Icon(Icons.add_circle),
              iconSize: 32,
              onPressed: _insert,
              tooltip: 'insert a new item',
            ),
          ],
        ),
        Flexible(
            // padding: const EdgeInsets.all(16.0),
            // height: 501,
            child: AnimatedGrid(
          key: _gridKey,
          initialItemCount: _list.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          itemBuilder: _buildItem,
        ))
      ],
    );
  }
}

typedef RemovedItemBuilder<T> = Widget Function(
    T item, BuildContext context, Animation<double> animation);

class ListModel<E> {
  ListModel({
    required this.listKey,
    required this.removedItemBuilder,
    Iterable<E>? initialItems,
  }) : _items = List<E>.from(initialItems ?? <E>[]);
  final GlobalKey<AnimatedGridState> listKey;
  final RemovedItemBuilder<E> removedItemBuilder;

  final List<E> _items;
  AnimatedGridState? get _animatedGrid => listKey.currentState;

  int get length => _items.length;

  E operator [](int index) => _items[index];
  int indexOf(E item) => _items.indexOf(item);

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedGrid!.insertItem(
      index,
      duration: const Duration(milliseconds: 500),
    );
  }

  void removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedGrid!.removeItem(index, (context, animation) {
        return removedItemBuilder(removedItem, context, animation);
      });
    }
  }
}

class CardItem extends StatelessWidget {
  final VoidCallback? onTap;
  final Animation<double> animation;
  final int item;
  final bool selected;
  final bool removing;

  const CardItem({
    super.key,
    this.onTap,
    this.selected = false,
    this.removing = false,
    required this.animation,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headlineMedium!;
    if (selected) {
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    }
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ScaleTransition(
          scale: CurvedAnimation(
              parent: animation,
              curve: removing ? Curves.easeInOut : Curves.bounceOut),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: SizedBox(
              height: 80.0,
              child: Card(
                color: Colors.primaries[item % Colors.primaries.length],
                child: Center(
                  child: Text('${item + 1}', style: textStyle),
                ),
              ),
            ),
          )),
    );
  }
}

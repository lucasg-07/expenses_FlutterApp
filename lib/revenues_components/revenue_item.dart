import 'dart:math';

import 'package:expenses/models/revenue.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RevenueItem extends StatefulWidget {
  final Revenue re;
  final void Function(String) onRemove;

  const RevenueItem({
    Key? key,
    required this.re,
    required this.onRemove,
  }) : super(key: key);

  @override
  State<RevenueItem> createState() => _RevenuesItemState();
}

class _RevenuesItemState extends State<RevenueItem> {
  static const colors = [
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.blue,
    Colors.black,
  ];

  Color? _backgroundColor;

  @override
  void initState() {
    super.initState();

    int i = Random().nextInt(5);
    _backgroundColor = colors[i];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _backgroundColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                'R\$${widget.re.value}',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          widget.re.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          DateFormat('d MMM y').format(widget.re.date),
        ),
        trailing: MediaQuery.of(context).size.width > 480
            ? TextButton.icon(
                onPressed: () => widget.onRemove(widget.re.id),
                icon: Icon(Icons.delete,
                    color: Theme.of(context).colorScheme.error),
                label: Text(
                  'Excluir',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
                onPressed: () => widget.onRemove(widget.re.id),
              ),
      ),
    );
  }
}

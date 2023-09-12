import 'package:flutter/material.dart';
import '../models/revenue.dart';
import 'revenue_item.dart';

class RevenuesList extends StatelessWidget {
  final List<Revenue> revenue;
  final void Function(String) onRemove;

  const RevenuesList(this.revenue, this.onRemove, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return revenue.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Cadastre seus primeiros ganhos!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: revenue.length,
            itemBuilder: (ctx, index) {
              final re = revenue[index];
              return RevenueItem(
                key: GlobalObjectKey(re),
                re: re,
                onRemove: onRemove,
              );
            },
          );
  }
}

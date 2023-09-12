import 'dart:math';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../revenue_provider.dart';
import 'chart_revenue.dart';
import 'revenue_form.dart';
import 'revenue_list.dart';
import '../models/revenue.dart';

class RevenuePage extends StatefulWidget {
  const RevenuePage({Key? key}) : super(key: key);

  @override
  State<RevenuePage> createState() => _RevenuePageState();
}

class _RevenuePageState extends State<RevenuePage> {
  bool _showChart = false;

  List<Revenue> get _recentRevenues {
    final revenueProvider = Provider.of<RevenueProvider>(context);
    return revenueProvider.recentRevenues;
  }

  _addRevenue(String title, double value, DateTime date) {
    final revenueProvider =
        Provider.of<RevenueProvider>(context, listen: false);

    final newRevenue = Revenue(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    revenueProvider.addRevenue(newRevenue);

    Navigator.of(context).pop();
  }

  _removeRevenue(String id) {
    final revenueProvider =
        Provider.of<RevenueProvider>(context, listen: false);
    revenueProvider.removeRevenue(id);
  }

  _openRevenueFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return RevenueForm(_addRevenue);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final iconList = Platform.isIOS ? CupertinoIcons.refresh : Icons.list;
    final chartList =
        Platform.isIOS ? CupertinoIcons.refresh : Icons.show_chart;

    final actions = [
      if (isLandscape)
        GestureDetector(
          onTap: () {
            setState(() {
              _showChart = !_showChart;
            });
          },
          child: Icon(_showChart ? iconList : chartList),
        ),
      GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(
          Platform.isIOS ? CupertinoIcons.money_dollar : Icons.attach_money,
        ),
      ),
      GestureDetector(
        onTap: () => _openRevenueFormModal(context),
        child: Icon(
          Platform.isIOS ? CupertinoIcons.add : Icons.add,
        ),
      ),
    ];

    final PreferredSizeWidget appBar = AppBar(
      title: const Text(
        'Receitas Pessoais',
      ),
      actions: actions.map((action) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: action,
        );
      }).toList(),
    );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * (isLandscape ? 0.8 : 0.3),
                child: RevenueChart(_recentRevenues),
              ),
            if (!_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * (isLandscape ? 1 : 0.7),
                child: RevenuesList(_recentRevenues, (String id) {
                  _removeRevenue(id);
                }),
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('Receitas Pessoais'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions.map((action) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: action,
                  );
                }).toList(),
              ),
            ),
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => _openRevenueFormModal(context),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}

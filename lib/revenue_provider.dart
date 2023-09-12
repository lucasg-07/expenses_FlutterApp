import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/revenue.dart';

class RevenueProvider with ChangeNotifier {
  final List<Revenue> _revenues = [];

  List<Revenue> get revenues => [..._revenues];

  List<Revenue> get recentRevenues {
    final cutoffDate = DateTime.now().subtract(const Duration(days: 7));
    return _revenues
        .where((revenue) => revenue.date.isAfter(cutoffDate))
        .toList();
  }

  void addRevenue(Revenue newRevenue) {
    _revenues.add(newRevenue);
    notifyListeners();
  }

  void removeRevenue(String revenueId) {
    _revenues.removeWhere((revenue) => revenue.id == revenueId);
    notifyListeners();
  }
}

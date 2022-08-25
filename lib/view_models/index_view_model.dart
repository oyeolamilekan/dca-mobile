import 'package:dca_mobile/services/market_service.dart';
import 'package:dca_mobile/services/utils/storage.dart';
import 'package:stacked/stacked.dart';

import '../set_up.dart';

class IndexViewModel extends BaseViewModel {
  final MarketService _market = locator<MarketService>();

  final Storage _storage = locator<Storage>();

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  Future<void> fetchAllMarketsAction() async {
    final response = await _market.fetchMarkets();
    await _storage.setString("markets", response.body);
  }

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}

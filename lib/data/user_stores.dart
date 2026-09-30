import 'package:flutter/foundation.dart';

import '../models/seller.dart';
import '../models/store.dart';

// Lojas criadas pelo usuário e o cadastro dele como vendedor.
// Os dados ficam só na memória: são perdidos quando o app é fechado.
class UserStores {
  UserStores._();

  // As telas escutam esta lista para atualizar quando uma loja muda
  static final ValueNotifier<List<Store>> stores = ValueNotifier([]);

  static Seller? seller;

  static void saveSeller(Seller newSeller) {
    seller = newSeller;
  }

  static void add(Store store) {
    stores.value = [...stores.value, store];
  }

  static void update(Store store) {
    stores.value = [
      for (final current in stores.value)
        if (current.id == store.id) store else current,
    ];
  }

  static void remove(String storeId) {
    stores.value = stores.value.where((store) => store.id != storeId).toList();
  }
}

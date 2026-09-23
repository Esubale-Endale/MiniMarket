// A small smoke test: it opens the app and taps the first product.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_market/bloc/cartBloc/cart_bloc.dart';
import 'package:mini_market/bloc/productBloc/products_bloc.dart';
import 'package:mini_market/data/market_store.dart';
import 'package:mini_market/main.dart';
import 'package:mini_market/models/product.dart';

void main() {
  testWidgets('tapping a product opens its detail screen', (tester) async {
    await tester.pumpWidget(const MiniMarketApp());

    // The home screen shows the products.
    expect(find.text('Mini Market'), findsOneWidget);
    expect(find.text('Phone X'), findsOneWidget);

    // Tapping a product opens the detail screen with the "Add to cart" button.
    await tester.tap(find.text('Phone X'));
    await tester.pumpAndSettle();

    expect(find.text('Add to cart'), findsOneWidget);
  });

  testWidgets('the add form shows errors for empty input', (tester) async {
    await tester.pumpWidget(const MiniMarketApp());

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Save product'));
    await tester.pumpAndSettle();

    expect(find.text('Enter a title'), findsOneWidget);
    expect(find.text('Enter a price'), findsOneWidget);
  });

  test('products bloc loads the current store list', () async {
    final bloc = ProductsBloc();
    bloc.add(LoadProducts());

    final state = await bloc.stream.firstWhere(
      (state) => state is ProductsLoaded,
    );

    expect(state, isA<ProductsLoaded>());
    expect((state as ProductsLoaded).products.first.title, 'Phone X');
  });

  test('cart bloc merges quantities for the same product', () async {
    MarketStore.clearCart();
    final product = MarketStore.products.first;
    final bloc = CartBloc();

    bloc.add(AddToCart(CartItem(product: product, quantity: 1)));
    bloc.add(AddToCart(CartItem(product: product, quantity: 2)));

    final states = <CartState>[];
    final sub = bloc.stream.listen(states.add);
    await Future<void>.delayed(const Duration(milliseconds: 30));
    await sub.cancel();

    expect(states.isNotEmpty, isTrue);
    final lastState = states.last;
    expect(lastState, isA<CartLoaded>());
    final loadedState = lastState as CartLoaded;
    expect(loadedState.cartItems.single.quantity, 3);
    expect(loadedState.cartItems.single.product.id, product.id);

    MarketStore.clearCart();
  });
}

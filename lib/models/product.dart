/// A single item that is for sale in the market.
class Product {
  final String id;
  final String title;
  final double price;
  final String category;
  final String description;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> product) {
    return Product(
      id: product['id'] as String,
      title: product['title'] as String,
      price: (product['price'] as num).toDouble(),
      category: product['category'] as String,
      description: product['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'category': category,
      'description': description,
    };
  }

  /// Returns a copy of this product with some fields replaced.
  /// Used by the edit screen so we never change a product in place.
  Product copyWith({
    String? title,
    double? price,
    String? category,
    String? description,
  }) {
    return Product(
      id: id,
      title: title ?? this.title,
      price: price ?? this.price,
      category: category ?? this.category,
      description: description ?? this.description,
    );
  }
}

/// One line in the shopping cart: a product plus how many of it.
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});

  double get total => product.price * quantity;
}

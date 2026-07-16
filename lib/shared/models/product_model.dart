enum ProductType {
  general,
  pharmacy,
  pharmacistOnly,
  prescription,
}

class ProductModel {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String unit;
  final String category;
  final bool isWishlisted;
  final double? discountPercent;
  final String description;
  final ProductType type;

  const ProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.unit,
    required this.category,
    this.isWishlisted = false,
    this.discountPercent,
    this.description = '',
    this.type = ProductType.general,
  });

  ProductModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
    double? price,
    String? unit,
    String? category,
    bool? isWishlisted,
    double? discountPercent,
    String? description,
    ProductType? type,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      unit: unit ?? this.unit,
      category: category ?? this.category,
      isWishlisted: isWishlisted ?? this.isWishlisted,
      discountPercent: discountPercent ?? this.discountPercent,
      description: description ?? this.description,
      type: type ?? this.type,
    );
  }
}

class CartItemModel {
  final ProductModel product;
  final int quantity;

  const CartItemModel({
    required this.product,
    required this.quantity,
  });

  CartItemModel copyWith({
    ProductModel? product,
    int? quantity,
  }) {
    return CartItemModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  double get totalPrice => product.price * quantity;
}

class SymptomModel {
  final String id;
  final String name;
  final String imageUrl;

  const SymptomModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });
}

// Sample data with high-resolution stable Pexels URLs
class SampleData {
  static List<ProductModel> wishlistProducts = [
    const ProductModel(
      id: '1',
      name: 'Moxal Plus Oral Suspension',
      imageUrl: 'https://images.pexels.com/photos/5910965/pexels-photo-5910965.jpeg?auto=compress&cs=tinysrgb&w=400',
      price: 89.50,
      unit: '200ml',
      category: 'General',
      isWishlisted: true,
    ),
    const ProductModel(
      id: '2',
      name: 'Adol 500mg Tablets',
      imageUrl: 'https://images.pexels.com/photos/3652103/pexels-photo-3652103.jpeg?auto=compress&cs=tinysrgb&w=400',
      price: 25.50,
      unit: '500mg',
      category: 'General',
      isWishlisted: true,
    ),
    const ProductModel(
      id: '3',
      name: 'Orofar Plus Throat Spray',
      imageUrl: 'https://images.pexels.com/photos/4021775/pexels-photo-4021775.jpeg?auto=compress&cs=tinysrgb&w=400',
      price: 34.00,
      unit: '200ml',
      category: 'General',
      isWishlisted: true,
    ),
    const ProductModel(
      id: '4',
      name: 'Proflora Daily Probiotic',
      imageUrl: 'https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?auto=compress&cs=tinysrgb&w=400',
      price: 50.00,
      unit: '30 caps',
      category: 'General',
      isWishlisted: true,
    ),
  ];

  static List<CartItemModel> cartItems = [
    CartItemModel(
      product: const ProductModel(
        id: '5',
        name: 'Immune Support Syrup',
        imageUrl: 'https://images.pexels.com/photos/1435495/pexels-photo-1435495.jpeg?auto=compress&cs=tinysrgb&w=400',
        price: 89.00,
        unit: '250 ml',
        category: 'Supplements',
      ),
      quantity: 1,
    ),
  ];

  static List<SymptomModel> symptoms = [
    const SymptomModel(
      id: 's1',
      name: 'Heart Burn',
      imageUrl: 'https://images.pexels.com/photos/6624178/pexels-photo-6624178.jpeg?auto=compress&cs=tinysrgb&w=300',
    ),
    const SymptomModel(
      id: 's2',
      name: 'Runny Nose',
      imageUrl: 'https://images.pexels.com/photos/3807629/pexels-photo-3807629.jpeg?auto=compress&cs=tinysrgb&w=300',
    ),
    const SymptomModel(
      id: 's3',
      name: 'Headache',
      imageUrl: 'https://images.pexels.com/photos/3771110/pexels-photo-3771110.jpeg?auto=compress&cs=tinysrgb&w=300',
    ),
    const SymptomModel(
      id: 's4',
      name: 'Fever',
      imageUrl: 'https://images.pexels.com/photos/3759664/pexels-photo-3759664.jpeg?auto=compress&cs=tinysrgb&w=300',
    ),
  ];

  static List<ProductModel> featuredProducts = [
    const ProductModel(
      id: '7',
      name: 'Vitamin C 1000mg',
      imageUrl: 'https://images.pexels.com/photos/1435495/pexels-photo-1435495.jpeg?auto=compress&cs=tinysrgb&w=400',
      price: 45.00,
      unit: '60 tabs',
      category: 'Vitamins',
      discountPercent: 20,
    ),
    const ProductModel(
      id: '8',
      name: 'Omega 3 Fish Oil',
      imageUrl: 'https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?auto=compress&cs=tinysrgb&w=400',
      price: 79.00,
      unit: '90 caps',
      category: 'Supplements',
    ),
    const ProductModel(
      id: '9',
      name: 'Zinc Tablets',
      imageUrl: 'https://images.pexels.com/photos/2563339/pexels-photo-2563339.jpeg?auto=compress&cs=tinysrgb&w=400',
      price: 32.00,
      unit: '60 tabs',
      category: 'Minerals',
      discountPercent: 15,
    ),
    const ProductModel(
      id: '10',
      name: 'Paracetamol 500mg',
      imageUrl: 'https://images.pexels.com/photos/3652103/pexels-photo-3652103.jpeg?auto=compress&cs=tinysrgb&w=400',
      price: 12.50,
      unit: '20 tabs',
      category: 'Pain Relief',
      type: ProductType.pharmacy,
      description: 'Temporary relief of pain and fever.',
    ),
    const ProductModel(
      id: '11',
      name: 'Stronger Pain Relief',
      imageUrl: 'https://images.pexels.com/photos/4021775/pexels-photo-4021775.jpeg?auto=compress&cs=tinysrgb&w=400',
      price: 18.00,
      unit: '12 tabs',
      category: 'Pain Relief',
      type: ProductType.pharmacistOnly,
      description: 'Pharmacist-only medicine for intense pain.',
    ),
    const ProductModel(
      id: '12',
      name: 'Prescription Heart Medicine',
      imageUrl: 'https://images.pexels.com/photos/5910965/pexels-photo-5910965.jpeg?auto=compress&cs=tinysrgb&w=400',
      price: 0.00,
      unit: '28 tabs',
      category: 'Heart Health',
      type: ProductType.prescription,
      description: 'Requires a valid prescription from an Australian doctor.',
    ),
  ];
}

enum ProductType {
  general,
  pharmacy,
  pharmacistOnly,
  prescription,
}

enum ComplianceReviewStatus {
  draft,
  legalReview,
  pharmacistReview,
  approved,
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
  
  // Stage 2 Compliance Fields
  final String? activeIngredient;
  final String? artgId;
  final String? cmiLink;
  final ComplianceReviewStatus reviewStatus;
  final bool isIndexed;
  final bool isOrderable;

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
    this.activeIngredient,
    this.artgId,
    this.cmiLink,
    this.reviewStatus = ComplianceReviewStatus.approved,
    this.isIndexed = true,
    this.isOrderable = true,
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
    String? activeIngredient,
    String? artgId,
    String? cmiLink,
    ComplianceReviewStatus? reviewStatus,
    bool? isIndexed,
    bool? isOrderable,
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
      activeIngredient: activeIngredient ?? this.activeIngredient,
      artgId: artgId ?? this.artgId,
      cmiLink: cmiLink ?? this.cmiLink,
      reviewStatus: reviewStatus ?? this.reviewStatus,
      isIndexed: isIndexed ?? this.isIndexed,
      isOrderable: isOrderable ?? this.isOrderable,
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

class SampleData {
  static List<ProductModel> wishlistProducts = [
    const ProductModel(
      id: '1',
      name: 'Panadol Optizorb 500mg',
      imageUrl: 'https://images.pexels.com/photos/5910965/pexels-photo-5910965.jpeg?auto=compress&cs=tinysrgb&w=400',
      price: 6.50,
      unit: '20 Caplets',
      category: 'Pain Relief',
      isWishlisted: true,
      type: ProductType.general,
    ),
    const ProductModel(
      id: '2',
      name: 'Nurofen Zavance Tablets',
      imageUrl: 'https://images.pexels.com/photos/3652103/pexels-photo-3652103.jpeg?auto=compress&cs=tinysrgb&w=400',
      price: 8.99,
      unit: '24 Tablets',
      category: 'Pain Relief',
      isWishlisted: true,
      type: ProductType.general,
    ),
    const ProductModel(
      id: '3',
      name: 'Difflam Plus Anaesthetic Lozenge',
      imageUrl: 'https://images.pexels.com/photos/4021775/pexels-photo-4021775.jpeg?auto=compress&cs=tinysrgb&w=400',
      price: 15.50,
      unit: '16 Lozenges',
      category: 'Cold & Flu',
      isWishlisted: true,
      type: ProductType.pharmacy,
      description: 'Schedule 2 Pharmacy Medicine for sore throats.',
    ),
    const ProductModel(
      id: '4',
      name: 'Inner Health Plus Double Strength',
      imageUrl: 'https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?auto=compress&cs=tinysrgb&w=400',
      price: 49.99,
      unit: '30 Capsules',
      category: 'Vitamins',
      isWishlisted: true,
      type: ProductType.general,
    ),
  ];

  static List<CartItemModel> cartItems = [
    CartItemModel(
      product: const ProductModel(
        id: '5',
        name: 'Blackmores Odourless Fish Oil 1000',
        imageUrl: 'https://images.pexels.com/photos/1435495/pexels-photo-1435495.jpeg?auto=compress&cs=tinysrgb&w=400',
        price: 24.50,
        unit: '400 Capsules',
        category: 'Supplements',
        type: ProductType.general,
      ),
      quantity: 1,
    ),
  ];

  static List<SymptomModel> symptoms = [
    const SymptomModel(
      id: 's1',
      name: 'Pain Relief',
      imageUrl: 'https://images.pexels.com/photos/6624178/pexels-photo-6624178.jpeg?auto=compress&cs=tinysrgb&w=300',
    ),
    const SymptomModel(
      id: 's2',
      name: 'Cold & Flu',
      imageUrl: 'https://images.pexels.com/photos/3807629/pexels-photo-3807629.jpeg?auto=compress&cs=tinysrgb&w=300',
    ),
    const SymptomModel(
      id: 's3',
      name: 'Allergies',
      imageUrl: 'https://images.pexels.com/photos/3771110/pexels-photo-3771110.jpeg?auto=compress&cs=tinysrgb&w=300',
    ),
    const SymptomModel(
      id: 's4',
      name: 'First Aid',
      imageUrl: 'https://images.pexels.com/photos/3759664/pexels-photo-3759664.jpeg?auto=compress&cs=tinysrgb&w=300',
    ),
  ];

  static List<ProductModel> featuredProducts = [
    const ProductModel(
      id: '7',
      name: 'Swisse Men\'s Ultivite',
      imageUrl: 'https://images.pexels.com/photos/1435495/pexels-photo-1435495.jpeg?auto=compress&cs=tinysrgb&w=400',
      price: 39.99,
      unit: '120 Tablets',
      category: 'Vitamins',
      discountPercent: 15,
      type: ProductType.general,
    ),
    const ProductModel(
      id: '8',
      name: 'Blackmores Vitamin D3 1000 IU',
      imageUrl: 'https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?auto=compress&cs=tinysrgb&w=400',
      price: 22.00,
      unit: '200 Capsules',
      category: 'Vitamins',
      type: ProductType.general,
    ),
    const ProductModel(
      id: '9',
      name: 'Sudafed Sinus + Pain Relief',
      imageUrl: 'https://images.pexels.com/photos/2563339/pexels-photo-2563339.jpeg?auto=compress&cs=tinysrgb&w=400',
      price: 18.50,
      unit: '24 Tablets',
      category: 'Cold & Flu',
      type: ProductType.pharmacistOnly,
      description: 'Pharmacist Only Medicine (Schedule 3). Contains Pseudoephedrine. ID required upon collection/delivery.',
    ),
    const ProductModel(
      id: '10',
      name: 'Telfast 180mg Tablets',
      imageUrl: 'https://images.pexels.com/photos/3652103/pexels-photo-3652103.jpeg?auto=compress&cs=tinysrgb&w=400',
      price: 39.50,
      unit: '50 Tablets',
      category: 'Allergies',
      type: ProductType.pharmacy,
      description: 'Pharmacy Medicine for hayfever and allergy relief.',
    ),
    const ProductModel(
      id: '11',
      name: 'Voltaren Emulgel Joint Pain Relief',
      imageUrl: 'https://images.pexels.com/photos/4021775/pexels-photo-4021775.jpeg?auto=compress&cs=tinysrgb&w=400',
      price: 26.99,
      unit: '150g Tube',
      category: 'Pain Relief',
      type: ProductType.general,
    ),
    const ProductModel(
      id: '12',
      name: 'Amoxicillin 500mg (Antibiotic)',
      imageUrl: 'https://images.pexels.com/photos/5910965/pexels-photo-5910965.jpeg?auto=compress&cs=tinysrgb&w=400',
      price: 0.00,
      unit: '20 Capsules',
      category: 'Prescription',
      type: ProductType.prescription,
      description: 'Prescription Only Medicine (Schedule 4). Requires a valid Australian prescription from a registered doctor.',
      activeIngredient: 'Amoxicillin trihydrate',
      artgId: 'AUST R 123456',
      cmiLink: 'https://www.ebs.tga.gov.au/ebs/picmi/picmirepository.nsf/pdf?OpenAgent&id=CP-2010-CMI-01234-5',
      reviewStatus: ComplianceReviewStatus.approved,
      isIndexed: false,
      isOrderable: false, // Prevents "Add to Cart" directly
    ),
  ];
}

// Shop model
class ShopModel {
  final String id;
  final String name;
  final String tagline;
  final String address;
  final String phone;
  final String logoPath;
  final String bannerColor;

  const ShopModel({
    required this.id,
    required this.name,
    required this.tagline,
    required this.address,
    required this.phone,
    required this.logoPath,
    required this.bannerColor,
  });

  static const List<ShopModel> shops = [
    ShopModel(
      id: 'kersbrook',
      name: 'Kersbrook Pharmacy',
      tagline: 'Your trusted local pharmacy',
      address: 'Kersbrook SA 5231, Australia',
      phone: '+61 8 8389 3232',
      logoPath: '',
      bannerColor: '16B8A8',
    ),
    ShopModel(
      id: 'ecompounding',
      name: 'Ecompounding Chemist',
      tagline: 'Personalised compounding solutions',
      address: 'Australia',
      phone: '+61 1800 000 000',
      logoPath: '',
      bannerColor: '101B1A',
    ),
  ];
}

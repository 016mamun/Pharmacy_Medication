import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';

class SavedAddressesScreen extends StatefulWidget {
  const SavedAddressesScreen({super.key});

  @override
  State<SavedAddressesScreen> createState() => _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends State<SavedAddressesScreen> {
  final List<Map<String, String>> _addresses = [];

  void _showAddressForm({Map<String, String>? existing, int? index}) {
    final labelCtrl = TextEditingController(text: existing?['label'] ?? '');
    final streetCtrl = TextEditingController(text: existing?['street'] ?? '');
    final suburbCtrl = TextEditingController(text: existing?['suburb'] ?? '');
    final stateCtrl = TextEditingController(text: existing?['state'] ?? '');
    final postcodeCtrl = TextEditingController(text: existing?['postcode'] ?? '');
    String selectedType = existing?['type'] ?? 'Home';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setModalState) => Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(ctx).viewInsets.bottom + 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 40, height: 4,
                    decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(2)),
                  ),
                ),
                const SizedBox(height: 16),
                Text(existing == null ? 'Add New Address' : 'Edit Address',
                    style: GoogleFonts.manrope(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textDark)),
                const SizedBox(height: 20),
                // Address type selector
                Text('Address Type', style: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textLight)),
                const SizedBox(height: 8),
                Row(
                  children: ['Home', 'Work', 'Other'].map((type) {
                    final selected = selectedType == type;
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () => setModalState(() => selectedType = type),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: selected ? AppColors.primary : AppColors.background,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: selected ? AppColors.primary : AppColors.divider),
                          ),
                          child: Text(type, style: GoogleFonts.manrope(
                            fontSize: 13, fontWeight: FontWeight.w600,
                            color: selected ? Colors.white : AppColors.textLight,
                          )),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                _modalField('Label (e.g. My Home)', labelCtrl, Icons.label_outline),
                _modalField('Street / Unit Number', streetCtrl, Icons.home_outlined),
                _modalField('Suburb', suburbCtrl, Icons.location_city_outlined),
                Row(children: [
                  Expanded(child: _modalField('State', stateCtrl, Icons.map_outlined)),
                  const SizedBox(width: 12),
                  Expanded(child: _modalField('Postcode', postcodeCtrl, Icons.pin_outlined, keyboardType: TextInputType.number)),
                ]),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final addr = {
                        'type': selectedType,
                        'label': labelCtrl.text.isEmpty ? selectedType : labelCtrl.text,
                        'street': streetCtrl.text,
                        'suburb': suburbCtrl.text,
                        'state': stateCtrl.text,
                        'postcode': postcodeCtrl.text,
                      };
                      setState(() {
                        if (index != null) {
                          _addresses[index] = addr;
                        } else {
                          _addresses.add(addr);
                        }
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text('Save Address', style: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _modalField(String label, TextEditingController ctrl, IconData icon, {TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: ctrl,
        keyboardType: keyboardType,
        style: GoogleFonts.manrope(fontSize: 14, color: AppColors.textDark),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.manrope(fontSize: 12, color: AppColors.textLight),
          prefixIcon: Icon(icon, color: AppColors.primary, size: 18),
          filled: true,
          fillColor: AppColors.background,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.divider)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.divider)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddressForm,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: Text('Add Address', style: GoogleFonts.manrope(fontWeight: FontWeight.w700)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.primary, AppColors.darkGreen],
                ),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 12),
                  Text('Saved Addresses', style: GoogleFonts.manrope(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
                ],
              ),
            ),
            Expanded(
              child: _addresses.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100, height: 100,
                            decoration: BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle),
                            child: const Icon(Icons.location_on_outlined, color: AppColors.primary, size: 48),
                          ),
                          const SizedBox(height: 24),
                          Text('No Saved Addresses', style: GoogleFonts.manrope(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textDark)),
                          const SizedBox(height: 8),
                          Text('Tap the button below to add\na delivery address.', textAlign: TextAlign.center, style: GoogleFonts.manrope(fontSize: 14, color: AppColors.textLight, height: 1.5)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: _addresses.length,
                      itemBuilder: (_, i) {
                        final addr = _addresses[i];
                        final typeIcons = {'Home': Icons.home_rounded, 'Work': Icons.work_rounded, 'Other': Icons.place_rounded};
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 44, height: 44,
                                decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(12)),
                                child: Icon(typeIcons[addr['type']] ?? Icons.place_rounded, color: AppColors.primary, size: 22),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(addr['label'] ?? '', style: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textDark)),
                                    const SizedBox(height: 4),
                                    Text('${addr['street']}, ${addr['suburb']} ${addr['state']} ${addr['postcode']}',
                                        style: GoogleFonts.manrope(fontSize: 12, color: AppColors.textLight, height: 1.4)),
                                  ],
                                ),
                              ),
                              PopupMenuButton<String>(
                                onSelected: (v) {
                                  if (v == 'edit') _showAddressForm(existing: addr, index: i);
                                  if (v == 'delete') setState(() => _addresses.removeAt(i));
                                },
                                itemBuilder: (_) => [
                                  const PopupMenuItem(value: 'edit', child: Text('Edit')),
                                  const PopupMenuItem(value: 'delete', child: Text('Delete')),
                                ],
                                icon: const Icon(Icons.more_vert, color: AppColors.grey),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

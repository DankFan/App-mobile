import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final Map<String, bool> _categories = {
    'Trứng': true,
    'Mì & Thực Phẩm Đóng Gói': false,
    'Đồ Ăn Vặt': false,
    'Đồ Giảm Giá': false,
  };

  // Selected brands
  final Map<String, bool> _brands = {
    'Skibidi': false,
    'Cocola': true,
    'Skibidi 2': false,
    'Khác': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Bộ lọc',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),

          _buildSectionTitle('Danh Mục'),
          ..._buildCheckboxList(_categories),

          const SizedBox(height: 16,),

          _buildSectionTitle('Hãng'),
          ..._buildCheckboxList(_brands),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop({
                    'categories' : _categories.entries.where((entry) => entry.value).map((entry) => entry.value).toList(),
                    'brand' :  _brands.entries.where((entry) => entry.value).map((entry) => entry.value).toList(),
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                  ),
                ),
                child: const Text(
                  'Áp dụng bộ lọc',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
          ),
           
          const SizedBox(height: 16,)
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );
}

List<Widget> _buildCheckboxList(Map<String, bool> items) {
  return items.entries.map((entry) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: entry.value,
              onChanged: (bool? value) {
                setState(() {
                  items[entry.key] = value ?? false;
                });
              },
              activeColor: const Color(0xFF4CAF50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            entry.key,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }).toList();
}

}


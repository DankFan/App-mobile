import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/provider/countriese.dart';
import 'verifypage.dart'; // Import Verifypage
import 'loginwithphonepage.dart'; // Import Loginwithphonepage

class PhoneInputPage extends StatefulWidget {
  final String? initialPhoneNumber; // Thêm tham số để nhận số điện thoại
  final String? initialCountryCode; // Thêm tham số để nhận mã quốc gia

  const PhoneInputPage({
    Key? key,
    this.initialPhoneNumber,
    this.initialCountryCode,
  }) : super(key: key);

  @override
  State<PhoneInputPage> createState() => _PhoneInputPageState();
}

class _PhoneInputPageState extends State<PhoneInputPage> {
  String phoneNumber = '';
  String selectedCountryCode = '+84'; // Default to Vietnam
  final ReadData _readData = ReadData();
  List<Map<String, String>> countries = [];
  bool isLoading = true;
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Khởi tạo giá trị ban đầu nếu có
    if (widget.initialPhoneNumber != null) {
      phoneNumber = widget.initialPhoneNumber!;
      _phoneController.text = phoneNumber; // Hiển thị số trong TextField
    }
    if (widget.initialCountryCode != null) {
      selectedCountryCode = widget.initialCountryCode!;
    }
    loadCountries();
  }

  Future<void> loadCountries() async {
    try {
      countries = await _readData.loadData();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error loading countries: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void showCountryPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select Country Code",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  // Implement search functionality here if needed
                },
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: countries.length,
                  itemBuilder: (context, index) {
                    final country = countries[index];
                    return ListTile(
                      title: Text(country['name']!),
                      trailing: Text(country['code']!),
                      onTap: () {
                        setState(() {
                          selectedCountryCode = country['code']!;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 0,
                                  child: Icon(
                                    Icons.spa,
                                    color: const Color(0xFF009432),
                                    size: 40,
                                  ),
                                ),
                                Positioned(
                                  top: 2,
                                  right: 10,
                                  child: Icon(
                                    Icons.restaurant,
                                    color: Colors.orange,
                                    size: 20,
                                  ),
                                ),
                                Positioned(
                                  top: 2,
                                  left: 12,
                                  child: Icon(
                                    Icons.fork_right,
                                    color: Colors.orange,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Luigi's ",
                                    style: TextStyle(
                                      color: Color(0xFF009432),
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "MART",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Đi chợ tại nhà",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const FeatureItem(
                        icon: Icons.eco,
                        text: "Thực phẩm hữu cơ",
                        color: Color(0xFF009432),
                      ),
                      const Divider(),
                      const FeatureItem(
                        icon: Icons.restaurant,
                        text: "Thức ăn và rau củ",
                        color: Colors.orange,
                      ),
                      const Divider(),
                      const FeatureItem(
                        icon: Icons.local_shipping_outlined,
                        text: "Giao Hàng Nhanh",
                        color: Colors.orange,
                      ),
                      const Divider(),
                      const FeatureItem(
                        icon: Icons.badge,
                        text: "Trả hàng dễ dàng",
                        color: Colors.green,
                      ),
                      const Divider(),
                      const FeatureItem(
                        icon: Icons.security,
                        text: "Bảo mật và an toàn",
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Column(
                children: [
                  const Text(
                    "Đăng nhập với SDT",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Nhập SĐT của bạn dưới đây, chúng tôi\nsẽ gửi mã xác nhận SMS 4 số",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: showCountryPicker,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 16),
                            child: Text(
                              selectedCountryCode,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              hintText: "23456789",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(9),
                            ],
                            onChanged: (value) {
                              setState(() {
                                phoneNumber = value;
                              });
                            },
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Loginwithphonepage(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (phoneNumber.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Verifypage(
                              phoneNumber: phoneNumber,
                              countryCode: selectedCountryCode,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Vui lòng nhập số điện thoại")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      "Đăng Nhập Nhanh",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const FeatureItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            text,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
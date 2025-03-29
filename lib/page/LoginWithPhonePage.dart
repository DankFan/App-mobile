import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/provider/countriese.dart';
import 'PhoneInputPage.dart';

class Loginwithphonepage extends StatefulWidget {
  const Loginwithphonepage({Key? key}) : super(key: key);

  @override
  _Loginwithphonepage createState() => _Loginwithphonepage();
}

class _Loginwithphonepage extends State<Loginwithphonepage> {
  String selectedCountryCode = "+84"; // Default to Vietnam
  String phoneNumber = ''; // Lưu số điện thoại
  final ReadData _readData = ReadData();
  List<Map<String, String>> countries = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
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
                  // Implement search functionality here
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

  void addDigit(String digit) {
    setState(() {
      if (phoneNumber.length < 10) {
        phoneNumber += digit;
      }
    });
  }

  void removeDigit() {
    setState(() {
      if (phoneNumber.isNotEmpty) {
        phoneNumber = phoneNumber.substring(0, phoneNumber.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Định nghĩa màu xanh lá
    const greenColor = Color(0xFF4CAF50);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thanh tiêu đề với nút quay lại
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      // Quay về PhoneInputPage và truyền dữ liệu
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhoneInputPage(
                            initialPhoneNumber: phoneNumber,
                            initialCountryCode: selectedCountryCode,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Tiêu đề "Nhập Số Điện Thoại Của Bạn"
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: const Text(
                'Nhập Số Điện Thoại Của Bạn',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            // Phụ đề "Số Điện Thoại Di Động"
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Text(
                'Số Điện Thoại Di Động',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),

            // Vùng hiển thị mã quốc gia và số điện thoại
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Mã quốc gia
                  InkWell(
                    onTap: showCountryPicker,
                    child: Row(
                      children: [
                        Text(
                          selectedCountryCode,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          phoneNumber,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Đường phân cách
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Divider(color: Colors.grey[400]),
            ),

            const Spacer(), // Đẩy nội dung bên dưới xuống dưới

            Expanded(
              child: Column(
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 56,
                          height: 56,
                          child: FloatingActionButton(
                            onPressed: phoneNumber.length == 10
                                ? () {
                                    // Quay về PhoneInputPage và truyền dữ liệu
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PhoneInputPage(
                                          initialPhoneNumber: phoneNumber,
                                          initialCountryCode: selectedCountryCode,
                                        ),
                                      ),
                                    );
                                  }
                                : null,
                            backgroundColor: phoneNumber.length == 10
                                ? greenColor
                                : Colors.grey,
                            child: const Icon(Icons.arrow_forward,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Bàn phím tùy chỉnh
            Container(
              color: Colors.grey[200], // Nền xám nhạt cho bàn phím
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildKeyButton('1', null, screenWidth),
                      _buildKeyButton('2', 'ABC', screenWidth),
                      _buildKeyButton('3', 'DEF', screenWidth),
                    ],
                  ),
                  Row(
                    children: [
                      _buildKeyButton('4', 'GHI', screenWidth),
                      _buildKeyButton('5', 'JKL', screenWidth),
                      _buildKeyButton('6', 'MNO', screenWidth),
                    ],
                  ),
                  Row(
                    children: [
                      _buildKeyButton('7', 'PQRS', screenWidth),
                      _buildKeyButton('8', 'TUV', screenWidth),
                      _buildKeyButton('9', 'WXYZ', screenWidth),
                    ],
                  ),
                  Row(
                    children: [
                      _buildKeyButton('+*#', null, screenWidth),
                      _buildKeyButton('0', null, screenWidth),
                      _buildBackspaceButton(screenWidth),
                    ],
                  ),
                  SizedBox(
                      height: screenHeight *
                          0.05), // Khoảng cách từ bàn phím đến đáy
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tạo nút bàn phím
  Widget _buildKeyButton(String mainText, String? subText, double screenWidth) {
    return Expanded(
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[300]!, width: 0.5),
        ),
        child: InkWell(
          onTap: () => addDigit(
              mainText[0]), // Chỉ lấy ký tự đầu tiên cho trường hợp '+*#'
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  mainText,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                if (subText != null)
                  Text(
                    subText,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Tạo nút backspace
  Widget _buildBackspaceButton(double screenWidth) {
    return Expanded(
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[300]!, width: 0.5),
        ),
        child: InkWell(
          onTap: removeDigit,
          child: Center(
            child: Icon(Icons.backspace, color: Colors.grey[600]),
          ),
        ),
      ),
    );
  }
}
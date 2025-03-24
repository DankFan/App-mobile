import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPInputPage extends StatefulWidget {
  const OTPInputPage({Key? key}) : super(key: key);

  @override
  State<OTPInputPage> createState() => _OTPInputPageState();
}

class _OTPInputPageState extends State<OTPInputPage> {
  String otpCode = ''; // Lưu mã OTP

  void addDigit(String digit) {
    setState(() {
      if (otpCode.length < 4) {
        otpCode += digit;
      }
    });
  }

  void removeDigit() {
    setState(() {
      if (otpCode.isNotEmpty) {
        otpCode = otpCode.substring(0, otpCode.length - 1);
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
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // Tiêu đề "Nhập OTP 4 Chữ Số Được Gửi"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Text(
                'Nhập OTP 4 Chữ Số Được Gửi',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            // Các ô nhập OTP
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: index < otpCode.length ? greenColor : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        index < otpCode.length ? otpCode[index] : '',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            const Spacer(), // Đẩy nội dung bên dưới xuống dưới

            // Nút "Gửi Lại Mã" và nút "Tiếp tục"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // Xử lý gửi lại mã OTP
                      print("Gửi lại mã OTP");
                    },
                    child: const Text(
                      'Gửi Lại Mã',
                      style: TextStyle(
                        fontSize: 16,
                        color: greenColor, // Đổi màu chữ thành xanh lá
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 56,
                    height: 56,
                    child: FloatingActionButton(
                      onPressed: otpCode.length == 4
                          ? () {
                              // Trả mã OTP về Verifypage và thoát
                              Navigator.pop(context, otpCode);
                            }
                          : null,
                      backgroundColor: otpCode.length == 4
                          ? greenColor // Màu xanh lá khi đủ 4 số
                          : Colors.grey, // Màu xám khi chưa đủ
                      child: const Icon(Icons.arrow_forward, color: Colors.white),
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
                  SizedBox(height: screenHeight * 0.05), // Khoảng cách từ bàn phím đến đáy
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
          onTap: () => addDigit(mainText[0]), // Chỉ lấy ký tự đầu tiên cho trường hợp '+*#'
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
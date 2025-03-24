import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/provider/countriese.dart';
import 'LoginPage.dart';
import 'OTPInputPage.dart';

class Verifypage extends StatefulWidget {
  final String phoneNumber;
  final String countryCode;

  const Verifypage({
    Key? key,
    this.phoneNumber = '123456789', // Mặc định nếu không truyền
    this.countryCode = '+84', // Mặc định nếu không truyền
  }) : super(key: key);

  @override
  _Verifypage createState() => _Verifypage();
}

class _Verifypage extends State<Verifypage> {
  // Controllers cho các ô OTP
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  final TextEditingController _thirdController = TextEditingController();
  final TextEditingController _fourthController = TextEditingController();

  // Focus nodes
  final FocusNode _firstFocusNode = FocusNode();
  final FocusNode _secondFocusNode = FocusNode();
  final FocusNode _thirdFocusNode = FocusNode();
  final FocusNode _fourthFocusNode = FocusNode();

  @override
  void dispose() {
    // Giải phóng controllers
    _firstController.dispose();
    _secondController.dispose();
    _thirdController.dispose();
    _fourthController.dispose();

    // Giải phóng focus nodes
    _firstFocusNode.dispose();
    _secondFocusNode.dispose();
    _thirdFocusNode.dispose();
    _fourthFocusNode.dispose();
    super.dispose();
  }

  // Hàm điều hướng sang OTPInputPage và nhận kết quả trả về
  Future<void> _navigateToOtpInputPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OTPInputPage(),
      ),
    );

    // Nếu nhận được mã OTP từ OTPInputPage
    if (result != null && result is String && result.length == 4) {
      setState(() {
        _firstController.text = result[0];
        _secondController.text = result[1];
        _thirdController.text = result[2];
        _fourthController.text = result[3];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF009432), // Màu xanh lá đậm
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            children: [
              // Card với logo và tính năng
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
                      const SizedBox(height: 20),
                      const FeatureItem(
                          icon: Icons.eco,
                          text: "Thực phẩm hữu cơ",
                          color: Color(0xFF009432)),
                      const Divider(),
                      const FeatureItem(
                          icon: Icons.restaurant,
                          text: "Thức ăn và rau củ",
                          color: Colors.orange),
                      const Divider(),
                      const FeatureItem(
                          icon: Icons.local_shipping_outlined,
                          text: "Giao Hàng Nhanh",
                          color: Colors.orange),
                      const Divider(),
                      const FeatureItem(
                          icon: Icons.badge,
                          text: "Trả hàng dễ dàng",
                          color: Colors.green),
                      const Divider(),
                      const FeatureItem(
                          icon: Icons.security,
                          text: "Bảo mật và an toàn",
                          color: Colors.red),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              const Text(
                "Xác Nhận OTP",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Nhập mã OTP đã được gửi đến số\nđiện thoại (${widget.countryCode})${widget.phoneNumber}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildOtpBox(
                    controller: _firstController,
                    focusNode: _firstFocusNode,
                    onTap: _navigateToOtpInputPage, // Chuyển hướng khi nhấn
                  ),
                  buildOtpBox(
                    controller: _secondController,
                    focusNode: _secondFocusNode,
                    onTap: _navigateToOtpInputPage, // Chuyển hướng khi nhấn
                  ),
                  buildOtpBox(
                    controller: _thirdController,
                    focusNode: _thirdFocusNode,
                    onTap: _navigateToOtpInputPage, // Chuyển hướng khi nhấn
                  ),
                  buildOtpBox(
                    controller: _fourthController,
                    focusNode: _fourthFocusNode,
                    onTap: _navigateToOtpInputPage, // Chuyển hướng khi nhấn
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Lấy mã OTP từ các ô nhập
                  final otp = _firstController.text +
                      _secondController.text +
                      _thirdController.text +
                      _fourthController.text;

                  if (otp.length == 4) {
                    // Xử lý xác thực OTP
                    print("Verifying OTP: $otp");

                    // Giả sử xác thực thành công, chuyển hướng sang LoginPage
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Vui lòng nhập đủ 4 chữ số OTP")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF009432),
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Xác Thực",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Widget cho ô nhập OTP
  Widget buildOtpBox({
    required TextEditingController controller,
    required FocusNode focusNode,
    Function(String)? onChanged,
    VoidCallback? onTap, // Thêm onTap để xử lý sự kiện nhấn
  }) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        onChanged: onChanged,
        onTap: onTap, // Gọi hàm khi nhấn vào ô
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
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

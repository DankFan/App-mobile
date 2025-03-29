import 'package:flutter/material.dart';

import 'PhoneInputPage.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

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
                    borderRadius: BorderRadius.circular(16.0)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo and App Name
                      Row(
                        children: [
                          // Logo
                          Container(
                            height: 50,
                            width: 50,
                            child: Stack(
                              children: [
                                // Green leaves base
                                Positioned(
                                  bottom: 0,
                                  child: Icon(
                                    Icons.spa,
                                    color: const Color(0xFF009432),
                                    size: 40,
                                  ),
                                ),
                                // Orange utensils
                                Positioned(
                                  top: 2,
                                  right: 10,
                                  child: Icon(
                                    Icons.restaurant,
                                    color: Colors.orange,
                                    size: 20,
                                  ),
                                ),
                                // Fork
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
                          // App Name
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // App name
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
                              // Subtitle
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
                      const SizedBox(
                        height: 24,
                      ),
                      // Features List
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
              const SizedBox(
                height: 20,
              ),
              // Daily Offers Section
              const Text(
                "Ưu đãi mỗi ngày",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                "Mua mọi mặt hàng tiện lợi tại nhà",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Login Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to PhoneInputPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PhoneInputPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF009432),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  minimumSize: const Size(double.infinity, 70),
                ),
                child: const Text(
                  "Đăng Nhập",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
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
          const SizedBox(
            width: 16,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

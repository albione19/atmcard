import 'package:flutter/material.dart';
import '../widgets/atm_card.dart';
import '../widgets/transaction_item.dart';
import '../models/transaction.dart';
import '../widgets/animated_neon_background.dart';

class AnimatedMovingBackground extends StatefulWidget {
  final Widget child;
  const AnimatedMovingBackground({super.key, required this.child});

  @override
  State<AnimatedMovingBackground> createState() => _AnimatedMovingBackgroundState();
}

class _AnimatedMovingBackgroundState extends State<AnimatedMovingBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -200, end: 200).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    transform: GradientRotation(_animation.value * 0.01),
                    colors: const [
                      Color(0xFF0A0F29),
                      Color(0xFF120052),
                      Color(0xFF001F3F),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        widget.child,
      ],
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController glowController;
  late Animation<double> glowAnimation;

  @override
  void initState() {
    super.initState();

    glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    glowAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transactions = [
      TransactionModel('Coffee Shop', '-Rp35.000', 'Food'),
      TransactionModel('Grab Ride', '-Rp25.000', 'Travel'),
      TransactionModel('Gym Membership', '-Rp150.000', 'Health'),
      TransactionModel('Movie Ticket', '-Rp60.000', 'Event'),
      TransactionModel('Salary', '+Rp5.000.000', 'Income'),
    ];

    return Scaffold(
      // biarkan scaffold transparan supaya background animasi terlihat
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "FINANCE MATE",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
            color: Colors.cyanAccent,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // PENTING: AnimatedNeonBackground membutuhkan named parameter `child`
          // Kita pass SizedBox.expand supaya widget background mengisi area
          const AnimatedNeonBackground(child: SizedBox.expand()),

          // Konten berada di atas background
          
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ===== BALANCE HOLOGRAM CARD =====
                AnimatedBuilder(
                  animation: glowAnimation,
                  builder: (context, child) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: LinearGradient(
                          colors: [
                            Colors.blueAccent.withOpacity(0.08),
                            Colors.purpleAccent.withOpacity(0.06),
                          ],
                        ),
                        border: Border.all(
                          color:
                              Colors.cyanAccent.withOpacity(glowAnimation.value),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.cyanAccent
                                .withOpacity(0.25 * glowAnimation.value),
                            blurRadius: 20,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "TOTAL BALANCE",
                            style: TextStyle(
                              color: Colors.cyanAccent,
                              letterSpacing: 2,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "Rp 40.600.000",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24),

                const Text(
                  'MY CARDS',
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 12),

                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                   children: const [
  AtmCard(
    bankName: 'Neon Bank',
    cardNumber: '**** 2345',
    balance: 'Rp12.500.000',
    color1: Colors.deepPurple,
    color2: Colors.cyan,
  ),
  AtmCard(
    bankName: 'Cyber Bank',
    cardNumber: '**** 8765',
    balance: 'Rp5.350.000',
    color1: Colors.cyan,
    color2: Colors.purpleAccent,
  ),
  AtmCard(
    bankName: 'Holo Bank',
    cardNumber: '**** 1122',
    balance: 'Rp2.750.000',
    color1: Color(0xFF0A0F1F), // deep futuristic blue
    color2: Colors.cyanAccent,
  ),
  AtmCard(
    bankName: 'Quantum Bank',
    cardNumber: '**** 9988',
    balance: 'Rp20.000.000',
    color1: Colors.purple,
    color2: Colors.blueAccent,
  ),
],


                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'CATEGORIES',
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 12),

                GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: const [
                    NeonMenu(icon: Icons.health_and_safety, label: "Health"),
                    NeonMenu(icon: Icons.travel_explore, label: "Travel"),
                    NeonMenu(icon: Icons.fastfood, label: "Food"),
                    NeonMenu(icon: Icons.event, label: "Event"),
                  ],
                ),

                const SizedBox(height: 24),

                const Text(
                  'RECENT TRANSACTIONS',
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 10),

                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => Divider(
                    color: Colors.cyanAccent.withOpacity(0.2),
                    thickness: 0.5,
                  ),
                  itemCount: transactions.length,
                  itemBuilder: (context, index) => TransactionItem(
                    transaction: transactions[index],
                  ),
                ),
                const SizedBox(height: 28),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ===================== NEON MENU =====================
/// Perbaikan TweenAnimationBuilder: gunakan generic <double>,
/// sertakan child: dan builder signature (context, double, Widget?)
class NeonMenu extends StatelessWidget {
  final IconData icon;
  final String label;

  const NeonMenu({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.4, end: 1.0),
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,

      // child widget statis: hanya ikon, label kita letakkan di builder wrapper
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.cyanAccent,
          size: 26,
        ),
      ),

      builder: (BuildContext context, double glow, Widget? child) {
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.cyanAccent.withOpacity(glow),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withOpacity(0.35 * glow),
                    blurRadius: 18,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: child, // child adalah ikon
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                letterSpacing: 1,
              ),
            )
          ],
        );
      },
    );
  }
}

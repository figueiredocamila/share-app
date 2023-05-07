import 'package:flutter/material.dart';

class GoogleSignInButton extends StatefulWidget {
  final VoidCallback onPressed;

  const GoogleSignInButton({super.key, required this.onPressed});

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 1.0, color: Colors.deepOrangeAccent),
            left: BorderSide(width: 1.0, color: Colors.deepOrangeAccent),
            right: BorderSide(width: 1.0, color: Colors.deepOrangeAccent),
            bottom: BorderSide(width: 1.0, color: Colors.deepOrangeAccent),
          ),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Image(
                  image: AssetImage('assets/images/google.png'),
                  height: 18.0,
                  width: 18.0,
                ),
                SizedBox(width: 12.0),
                Text(
                  'FAÇA O LOGIN COM O GOOGLE',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14.0, color: Colors.black54),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:project4/screens/base_screen.dart';
import 'package:project4/widgets/base_widget.dart';
import 'dart:async';
import '../utils/constants.dart';

class PassworRetrieval extends StatefulWidget {
  const PassworRetrieval(
      {super.key, this.chooseScreen = false, this.keyAS = false});

  final bool keyAS;
  final bool chooseScreen;

  @override
  State<PassworRetrieval> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<PassworRetrieval> {
  TextEditingController codeController = TextEditingController();
  Timer? _timer;
  int _secondsRemaining = 30;
  double fontSize = 0;
  double fontFour = 0;
  double fontBac = 0;
  double boxBack = 0;
  double fontBack = 0;
  double create = 0;
  bool chooseScreen = false;
  bool key = false; // true là đăng kí fales là đăng nhập
  ////
  List<TextEditingController> controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final TextEditingController _email =
      TextEditingController(text: "string@gmail.com");

  final TextEditingController _password = TextEditingController(text: "string");
  final TextEditingController _rePassword = TextEditingController();
  String errorMess = '';

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  //////////////////////////////////////
  @override
  void initState() {
    chooseScreen = widget.chooseScreen;
    key = widget.keyAS;
    double screenWidth = baseConstraints.maxWidth;
    ThemeData(colorSchemeSeed: const Color(0xFF3b4149), useMaterial3: true);
    fontSize = screenWidth * 0.03;
    fontFour = screenWidth * 0.04;
    fontBac = screenWidth * 0.02;
    boxBack = screenWidth * 0.15;
    fontBack = screenWidth * 0.05;
    create = screenWidth * 0.025;
    super.initState();
    startTimer();

    /////////////////////////////////////////////////////////////////////
  }

  bool _isObscured = true;
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        setAppBar: 3,
        setBottomBar: false,
        setBody: bodyAccountScreen(key: key, context: context));
  }

  ////////////////////////////////////////

///////////////////////////////////////////////////////////acc
  Widget bodyAccountScreen({required BuildContext context, bool key = false}) {
    return Container(
      width: baseConstraints.maxWidth,
      height: baseConstraints.maxHeight,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: [
            Color(0xff0b0704),
            Color(0xff16110d),
            Color(0xff1f1b19),
          ],
        ),
      ),
      child: ListView(children: [
        Container(
          width: baseConstraints.maxWidth,
          height: baseConstraints.maxHeight * 0.3,
          padding: EdgeInsets.only(top: baseConstraints.maxHeight * 0.09),
          // decoration: BoxDecoration(
          //   border: Border.all(width: 1, color: Colors.white),
          // ),
          child: Transform.scale(
            scale:
                0.7, // Đặt tỉ lệ thu nhỏ hình ảnh (0.7 là 70% kích thước gốc)
            child: BaseWidget().setImageAsset('logo_white.png'),
            // Đường dẫn đến ảnh của bạn
          ),
        ),
        Container(
          width: baseConstraints.maxWidth,
          height: baseConstraints.maxHeight * 0.1,
          child: Center(
            child: Text(
              'Đổi mật khẩu',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: const Color(0xffd6dbe2),
                fontSize: fontBack,
              ),
            ),
          ),
        ),

        Container(
          width: baseConstraints.maxWidth,
          height: baseConstraints.maxHeight * 0.22,

          // decoration: BoxDecoration(
          //   border: Border.all(width: 1, color: Colors.white),
          // ),
          child: Padding(
            padding: const EdgeInsets.only(
                bottom: 0.001), // You can adjust the value as needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffd6dbe2),
                    fontSize: fontFour,
                  ),
                ),
                const SizedBox(height: 8.0), // Add some vertical space
                TextField(
                  controller: _email,
                  style: TextStyle(
                      color: const Color(0xffd6dbe2), fontSize: fontSize),
                  decoration: InputDecoration(
                    fillColor: const Color(0xff1f1b19),
                    filled: true,
                    hintText: 'name@gmail.com',
                    prefixIcon: Icon(Icons.email),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        // Xử lý khi nút được nhấn
                        print('Nút Gửi được nhấn');
                      },
                    ),
                    hintStyle: TextStyle(
                      color: const Color(0xff49575e),
                      fontSize: fontSize,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF242830),
                        width: 1,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF3b4149), width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                  ),
                ),
                TextField(
                  controller: codeController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Color(0xffd6dbe2),
                  ),
                  decoration: InputDecoration(
                    labelText: 'Nhập mã',
                    labelStyle: TextStyle(
                      color: Color(0xffd6dbe2),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                _secondsRemaining == 0
                    ? ElevatedButton(
                        onPressed: () {
                          resetCode();
                        },
                        child: Text('Lấy lại mã'),
                      )
                    : Text(
                        '$_secondsRemaining Giây',
                        style: TextStyle(
                          color: const Color(0xffd6dbe2),
                          fontSize: fontFour,
                        ),
                      ),
                // SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: () {
                //     verifyCode();
                //   },
                //   child: Text('Xác nhận'),
                // ),
              ],
            ),
          ),
        ),

        /////////
        Container(
          width: baseConstraints.maxWidth,
          height: baseConstraints.maxHeight * 0.12,
          // decoration: BoxDecoration(
          //   border: Border.all(width: 1, color: Colors.white),
          // ),
          child: Padding(
            padding: const EdgeInsets.only(
                bottom: 0.001), // You can adjust the value as needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mật khẩu mới',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffd6dbe2),
                    fontSize: fontFour,
                  ),
                ),
                const SizedBox(height: 8.0), // Add some vertical space
                TextField(
                  controller: _password,
                  style: TextStyle(
                      color: const Color(0xffd6dbe2), fontSize: fontSize),
                  decoration: InputDecoration(
                    fillColor: const Color(0xff1f1b19),
                    filled: true,
                    hintText: 'Password',
                    hintStyle: TextStyle(
                        color: const Color(0xff49575e), fontSize: fontSize),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF242830), width: 1),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF3b4149), width: 2),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: baseConstraints.maxWidth * 0.03,
                      horizontal: baseConstraints.maxHeight * 0.02,
                    ),
                    suffixIcon: TextButton(
                      onPressed: () {
                        // Đảo ngược trạng thái ẩn/mở mật khẩu khi nhấn nút
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                      child: Icon(
                        _isObscured ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  obscureText: _isObscured,
                  obscuringCharacter: '\u2023',
                ),
              ],
            ),
          ),
        ),
        Container(
          width: baseConstraints.maxWidth,
          height: baseConstraints.maxHeight * 0.12,
          // decoration: BoxDecoration(
          //   border: Border.all(width: 1, color: Colors.white),
          // ),
          child: Padding(
            padding: const EdgeInsets.only(
                bottom: 0.001), // You can adjust the value as needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nhập lại mật khẩu mới',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffd6dbe2),
                    fontSize: fontFour,
                  ),
                ),
                const SizedBox(height: 8.0), // Add some vertical space
                TextField(
                  controller: _rePassword,
                  style: TextStyle(
                      color: const Color(0xffd6dbe2), fontSize: fontSize),
                  decoration: InputDecoration(
                    fillColor: const Color(0xff1f1b19),
                    filled: true,
                    hintText: 'Password',
                    hintStyle: TextStyle(
                        color: const Color(0xff49575e), fontSize: fontSize),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF242830), width: 1),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF3b4149), width: 2),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: baseConstraints.maxWidth * 0.03,
                      horizontal: baseConstraints.maxHeight * 0.02,
                    ),
                    suffixIcon: TextButton(
                      onPressed: () {
                        // Đảo ngược trạng thái ẩn/mở mật khẩu khi nhấn nút
                        setState(() {
                          isObscured = !isObscured;
                        });
                      },
                      child: Icon(
                        isObscured ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  obscureText: isObscured,
                  obscuringCharacter: '\u2023',
                ),
              ],
            ),
          ),
        ),

        Container(
          width: baseConstraints.maxWidth,
          height: baseConstraints.maxHeight * 0.04,
          // decoration: BoxDecoration(
          //   border: Border.all(width: 1, color: Colors.white),
          // ),
          // child: Container(
          //   height: double.infinity,
          //   decoration: BoxDecoration(
          //     color: Color(0xFFd0480a),
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Center(
          //     child: Text(
          //       'Access all my episodes',
          //       style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         color: Color(0xffd6dbe2),
          //         fontSize: fontFour,
          //       ),
          //     ),
          //   ),
          // ),
        ),
        Container(
          width: baseConstraints.maxWidth,
          height: baseConstraints.maxHeight * 0.08,
          // decoration: BoxDecoration(
          //   border: Border.all(width: 1, color: Colors.white),
          // ),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        errorMess = '';
                        chooseScreen = false;
                      });
                    },
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 2, color: const Color(0xFF455258)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '<',
                          style: TextStyle(
                              color: const Color(0xffd6dbe2),
                              fontSize: fontBack),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFd98118),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Xác nhận',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffd6dbe2),
                          fontSize: create,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

///////////////////////////////////////////////////////////lo
  ///void verifyCode() async {
  void verifyCode() async {
    String enteredCode = codeController.text;

    // Check if code is valid
    if (isValidCode(enteredCode)) {
      print('Code is valid');
    } else {
      print('Invalid code');
    }
  }

  bool isValidCode(String enteredCode) {
    String storedCode = '1234';
    return enteredCode == storedCode;
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  void resetCode() {
    print('Resetting code...');
    _secondsRemaining = 30;
    startTimer();
  }
}

import 'package:flutter/material.dart';

class FieldF extends StatefulWidget {
  bool obscureTxt;
  late TextInputType inputType;
  late String hintText;

  FieldF(
      {Key? key,
      required this.inputType,
      required this.hintText,
      this.obscureTxt = false})
      : super(key: key);

  @override
  _FieldFState createState() => _FieldFState(inputType, hintText, obscureTxt);
}

class _FieldFState extends State<FieldF> {
  bool obscureTxt = false;
  late TextInputType inputType;
  late String hintText;

  _FieldFState(this.inputType, this.hintText, this.obscureTxt);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
      child: TextFormField(
        keyboardType: inputType,
        minLines: 1,
        autofocus: false,
        decoration: InputDecoration(
            hintText: hintText,
            // labelText: "Name",     // Set text upper animation
            border: OutlineInputBorder(),
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: hintText == 'Password' &&
                      inputType == TextInputType.visiblePassword
                  ? IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        setState(() {
                          obscureTxt = !obscureTxt;
                        });
                      },
                      icon: Icon(
                        obscureTxt ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    )
                  : null,
            )),
      ),
    );
  }
}

// ===============================================================
// SUBMIT BUTTONS
class SubmitButton extends StatelessWidget {
  final String btnName;
  final Widget Function() createPage;

  const SubmitButton(
      {Key? key, required this.btnName, required this.createPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 30.0 , bottom:35.0),
        child: MaterialButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => createPage()));
          }, // When Click on Button goto Login Screen

          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80.0)),
          padding: const EdgeInsets.all(0.0),
          child: Ink(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [new Color(0xff374ABE), new Color(0xff64B6FF)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight),
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: Container(
              constraints:  BoxConstraints(
                  maxWidth: 300.0,
                  minHeight: 40.0, maxHeight: 55.0), // min sizes for Material buttons
              alignment: Alignment.center,
              child: Text(
                btnName,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
        );
  }
}

// =========================================================
// EXTRA BUTTONS FOR ROW SIGNUP AND
class ExtraButton extends StatelessWidget {
  final String btnName;
  final Widget Function() createPage;
  const ExtraButton({Key? key, required this.btnName, required this.createPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            margin: EdgeInsets.only(top: 20.0),
            padding: EdgeInsets.only(bottom: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Already have an account? "),
                GestureDetector(
                  child: Text(
                    btnName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                          builder: (context) => createPage()
                        )
                        
                        );
                  },
                )
              ],
            )));
  }
}

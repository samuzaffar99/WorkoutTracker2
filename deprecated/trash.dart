// Change Name
// Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// children: [
// Expanded(
// child: Padding(
// padding:
// EdgeInsets.fromLTRB(10, 10, 30, 10),
// child: TextField(
// controller: nameController,
// decoration: InputDecoration(
// border: OutlineInputBorder(
// borderRadius: BorderRadius.all(
// Radius.circular(20)),
// borderSide: BorderSide(
// color: Colors.transparent,
// ),
// ),
// hintText: 'Enter Name',
// filled: true,
// fillColor:
// Colors.white.withAlpha(200),
// )),
// ),
// ),
// MaterialButton(
// minWidth: 5,
// height: 40,
// color: Colors.blue[400],
// child: Text('Save'),
// onPressed: () {
// widget.user.name = nameController.text;
// widget._api.putUser(widget.user);
// },
// ),

// Navigate back to a page using bakcbutton
// leading: IconButton(
//   icon: Icon(Icons.arrow_back_rounded),
//   onPressed: () {
//     Navigator.pop(context);
//     Navigator.pushNamed(context, 'Profile');
//   },
// ),
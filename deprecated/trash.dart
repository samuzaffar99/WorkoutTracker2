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

// Positioned.fill(child: AnimatedBackground()),
// onBottom(AnimatedWave(
// height: 180,
// speed: 1,
// )),
// onBottom(AnimatedWave(
// height: 120,
// speed: 0.9,
// offset: 3.142,
// )),
// onBottom(AnimatedWave(
// height: 220,
// speed: 1.2,
// offset: 3.142 / 2,
// )),

// bottomNavigationBar: Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   crossAxisAlignment: CrossAxisAlignment.end,
//   children: <Widget>[
//     MaterialButton(
//         onPressed: previousPage, child: Text('Previous')),
//     MaterialButton(onPressed: nextPage, child: Text('Next'))
//   ],
// ),

// ,
//   Container(
//   child: Form(
//     key: _formKey,
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Row(
//             children: <Widget>[
//               IconTheme(
//                 child: Icon(Icons.person),
//                 data: IconThemeData(color: Colors.white),
//               ),
//               Expanded(
//                 child: Container(
//                   margin: EdgeInsets.only(right: 20, left: 10),
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                         borderSide: BorderSide(
//                           color: Colors.transparent,
//                         ),
//                       ),
//                       hintText: "enter your nickname",
//                       filled: true,
//                       fillColor: Colors.white.withAlpha(200),
//                     ),
//                     validator: (value) {
//                       if (value.isEmpty) {
//                         return "Username cannot be left blank";
//                       } else if (checku == false) {
//                         setState(
//                           () {
//                             checku = true;
//                           },
//                         );
//                       }
//                       return null;
//                     },
//                     onSaved: (value) {
//                       name = value;
//                     },
//                   ),
//                 ),
//               ),

// ,
//   Container(
//   child: Form(
//     key: _formKey,
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Row(
//             children: <Widget>[
//               IconTheme(
//                 child: Icon(Icons.person),
//                 data: IconThemeData(color: Colors.white),
//               ),
//               Expanded(
//                 child: Container(
//                   margin: EdgeInsets.only(right: 20, left: 10),
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                         borderSide: BorderSide(
//                           color: Colors.transparent,
//                         ),
//                       ),
//                       hintText: "enter your nickname",
//                       filled: true,
//                       fillColor: Colors.white.withAlpha(200),
//                     ),
//                     validator: (value) {
//                       if (value.isEmpty) {
//                         return "Username cannot be left blank";
//                       } else if (checku == false) {
//                         setState(
//                           () {
//                             checku = true;
//                           },
//                         );
//                       }
//                       return null;
//                     },
//                     onSaved: (value) {
//                       name = value;
//                     },
//                   ),
//                 ),
//               ),


// Container(
//   height: MediaQuery.of(context).size.height/4,
//   child: GridView.builder(
//       gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//           maxCrossAxisExtent: 160,
//         mainAxisSpacing: 12,
//         crossAxisSpacing: 0,
//         mainAxisExtent: 40,
//       ),
//       itemCount: category.length,
//       itemBuilder: (BuildContext context, index) {
//         return Container(
//             alignment: Alignment.center,
//             child: new FilterChip(
//                 selected: categoryToggle[index],
//                 selectedColor: Colors.deepOrange,
//                 padding: EdgeInsets.fromLTRB(4, 12, 4, 12),
//                 label: Text(category[index]),
//                 labelStyle: TextStyle(
//                     fontSize: 16, fontWeight: FontWeight.w500),
//                 elevation: 5,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 onSelected: (bool selected) {
//                   setState(() {
//                     categoryToggle[index] =
//                         !categoryToggle[index];
//                   });
//                 }));
//       }),
// ),
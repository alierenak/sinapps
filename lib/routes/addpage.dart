import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sinapps/utils/colors.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[350],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey[800],
          elevation: 0.0,
          title: Text(
            'Add Post',
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 24,
              fontFamily: 'BrandonText',
              fontWeight: FontWeight.w600,
            ),
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              color: Colors.grey[300],
              icon: Icon(Icons.camera_alt),
              onPressed: () {
                AddPost();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                height: 300,
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextField(
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 14,
                              fontFamily: 'BrandonText',
                              fontWeight: FontWeight.w600,
                            ),
                            minLines: 1,
                            maxLines: 1,
                            decoration: InputDecoration(
                              contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              fillColor: AppColors.captionColor,
                              filled: true,
                              hintText: 'Caption',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Expanded(
                            flex: 1,
                            child: TextField(
                              style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: 14,
                                fontFamily: 'BrandonText',
                                fontWeight: FontWeight.w600,
                              ),
                              maxLength: 260,
                              minLines: 8,
                              maxLines: 16,
                              decoration: InputDecoration(
                                contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                fillColor: AppColors.captionColor,
                                filled: true,
                                hintText: 'Whats going on...',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                      ],
                    ),
                    Container(
                      height: 60,
                      color: Colors.black54,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              height: 36.0,
                              width: 36.0,
                              color: Colors.black26,
                              child: IconButton(
                                color: Colors.grey[300],
                                icon: Icon(
                                  Icons.photo_outlined,
                                  size: 18.0,
                                ),
                                onPressed: () {
                                  AddPost();
                                },
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Container(
                              height: 36.0,
                              width: 36.0,
                              color: Colors.black26,
                              child: IconButton(
                                color: Colors.grey[300],
                                icon: Icon(
                                  Icons.add_location,
                                  size: 18.0,
                                ),
                                onPressed: () {
                                  AddPost();
                                },
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Container(
                              height: 36.0,
                              width: 36.0,
                              color: Colors.black26,
                              child: IconButton(
                                color: Colors.grey[300],
                                icon: Icon(
                                  Icons.link,
                                  size: 18.0,
                                ),
                                onPressed: () {
                                  AddPost();
                                },
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Container(
                              height: 36.0,
                              width: 36.0,
                              color: Colors.black26,
                              child: IconButton(
                                color: Colors.grey[300],
                                icon: Icon(
                                  Icons.poll,
                                  size: 18.0,
                                ),
                                onPressed: () {
                                  AddPost();
                                },
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Container(
                              height: 36.0,
                              width: 36.0,
                              color: Colors.black26,
                              child: IconButton(
                                color: Colors.grey[300],
                                icon: Icon(
                                  Icons.gif,
                                  size: 18.0,
                                ),
                                onPressed: () {
                                  AddPost();
                                },
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Container(
                              alignment: Alignment.center,
                              height: 36.0,
                              width: 90.0,
                              color: AppColors.primary,
                              child: IconButton(
                                alignment: Alignment.center,
                                color: Colors.grey[300],
                                icon: Icon(
                                  Icons.add,
                                  size: 24.0,
                                  color: Colors.black54,
                                ),
                                onPressed: () {
                                  AddPost();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
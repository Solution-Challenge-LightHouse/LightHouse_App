import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutterlogin/component/comment.dart';
import 'package:flutterlogin/component/comment_button.dart';
import 'package:flutterlogin/component/delete_button.dart';
import 'package:flutterlogin/component/helper_method.dart';
import 'package:flutterlogin/component/like_button.dart';
import 'package:flutterlogin/lighthouse/community/community_homepage.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String PostId;
  final String time;
  final List<String> likes;

  const WallPost(
      {required this.message,
      required this.user,
      required this.PostId,
      required this.likes,
      required this.time,
      super.key});

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  //user
  final currntUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  //comment text controller
  final _commonTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  //toggle like
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
    //Access the doucument is Firebase
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User Posts').doc(widget.PostId);

    if (isLiked) {
      //if the post is now liked, add the user's email to the'Likes' field
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      //if the post is now unliked, remove the user's email from the 'likes field
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  //add a comment
  void addComment(String commentText) {
    //write the commet to firestore under the comments collection for this post
    FirebaseFirestore.instance
        .collection("User Posts")
        .doc(widget.PostId)
        .collection("Comments")
        .add({
      "CommentText": commentText,
      "CommentedBy": currentUser.email,
      'CommentTime': Timestamp.now()
    });
  }

  //show a dialog box for adding comment
  void showCommentDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Add Comment'),
              content: TextField(
                controller: _commonTextController,
                decoration: const InputDecoration(hintText: "Write a comment"),
              ),
              actions: [
                //post button
                TextButton(
                    onPressed: () {
                      //add comment
                      addComment(_commonTextController.text);
                      //pop box
                      Navigator.pop(context);

                      //clear controller
                      _commonTextController.clear();
                    },
                    child: const Text('Post')),

                //cancel button
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      //clear controller
                      _commonTextController.clear();
                    },
                    child: const Text('Cancel'))
              ],
            ));
  }

  //delete a post
  void deletePost() {
    //show a dialog box asking for confirmation before deleting the post
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Delete Post'),
              content: const Text('Are you sure you want to delete this post?'),
              actions: [
                //cancel button
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel')),

                //delete button
                TextButton(
                    onPressed: () async {
                      //delete the comments from firebase first
                      final commentDocs = await FirebaseFirestore.instance
                          .collection("User Posts")
                          .doc(widget.PostId)
                          .collection("Comments")
                          .get();

                      for (var doc in commentDocs.docs) {
                        await FirebaseFirestore.instance
                            .collection("User Posts")
                            .doc(widget.PostId)
                            .collection("Comments")
                            .doc(doc.id)
                            .delete();
                      }

                      //then delete the post
                      FirebaseFirestore.instance
                          .collection("User Posts")
                          .doc(widget.PostId)
                          .delete()
                          .then((value) => print('post deleted'))
                          .catchError((error) =>
                              print('failed to delete post: $error'));

                      //dissmiss the dialog box
                      Navigator.pop(context);
                    },
                    child: const Text('Delete'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: const Color(0xFFF5F3FF),
            borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //wallpost
                Column(
                  //group of text(messge+user emaill)
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //message
                    Text(widget.message),
                    const SizedBox(height: 10),

                    //user
                    Row(
                      children: [
                        Text(
                          widget.user,
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        Text(" • ", style: TextStyle(color: Colors.grey[400])),
                        Text(widget.time,
                            style: TextStyle(color: Colors.grey[400])),
                      ],
                    )
                  ],
                ),

                //deldet button
                if (widget.user == currentUser.email)
                  DeleteButton(onTap: deletePost)
              ],
            ),

            const SizedBox(
              height: 20,
            ),

            //buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //like
                Column(
                  children: [
                    //like button
                    LikeButton(isLiked: isLiked, onTap: toggleLike),
                    const SizedBox(height: 5),

                    //likecount
                    Text(
                      widget.likes.length.toString(),
                      style: const TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),

                //Comment
                Column(
                  children: [
                    //comment button
                    CommentButton(onTap: showCommentDialog),
                    const SizedBox(height: 5),

                    //comment count
                    const Text(
                      '0',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),
            //comments under the post
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("User Posts")
                  .doc(widget.PostId)
                  .collection("Comments")
                  .orderBy("CommentTime", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                //show loading circle if no data yet
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView(
                  //for nested lists
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: snapshot.data!.docs.map((doc) {
                    //get  the comment
                    final commentData = doc.data() as Map<String, dynamic>;
                    //return the comment
                    return Comment(
                        text: commentData["CommentText"],
                        user: commentData["CommentedBy"],
                        time: formatDate(commentData['CommentTime']));
                  }).toList(),
                );
              },
            )
          ],
        ));
  }
}

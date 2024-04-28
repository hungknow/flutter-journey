// https://proandroiddev.com/flutter-challenge-youtube-ec5ff36eca9b
// https://github.com/deven98/YouTubeFlutter/blob/master/lib/main.dart

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class YoutubeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController alignmentAnimationController;
  late Animation alignmentAnimation;

  late AnimationController videoViewController;
  late Animation videoViewAnimation;

  var currentAlignment = Alignment.topCenter;

  var minVideoHeight = 100.0;
  var minVideoWidth = 150.0;

  var maxVideoHeight = 200.0;

  // This is an arbitrary value and will be changed when layout is built.
  var maxVideoWidth = 250.0;

  var currentVideoHeight = 200.0;
  var currentVideoWidth = 200.0;

  bool isInSmallMode = false;

  var videoIndexSelected = -1;

  @override
  void initState() {
    super.initState();

    alignmentAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..addListener(() {
            setState(() {
              currentAlignment = alignmentAnimation.value;
            });
          });
    alignmentAnimation =
        AlignmentTween(begin: Alignment.topCenter, end: Alignment.bottomRight)
            .animate(CurvedAnimation(
                parent: alignmentAnimationController,
                curve: Curves.fastOutSlowIn));

    videoViewController =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..addListener(() {
            setState(() {
              currentVideoWidth = (maxVideoWidth * videoViewAnimation.value) +
                  (minVideoWidth * (1.0 - videoViewAnimation.value));
              currentVideoHeight = (maxVideoHeight * videoViewAnimation.value) +
                  (minVideoHeight * (1.0 - videoViewAnimation.value));
            });
          });
    videoViewAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(videoViewController);
  }

  var videos = [
    VideoItemModel(
        "Gordon Ramsay Cooked For Vladimir Putin",
        "The Late Show with Stephen Colbert\n1.1M views.2 weeks ago",
        "assets/youtube_one.jpg"),
    VideoItemModel("Hailee Steinfeld, Alesso - Let Me Go",
        "Hailee Steinfeld\n57M views.8 months ago", "assets/youtube_two.jpg"),
    VideoItemModel("Charlie Puth - Look At Me Now",
        "Lyricwood\n4.7M views.4 months ago", "assets/youtube_three.jpg")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              FontAwesomeIcons.youtube,
              color: Colors.red,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "YouTube",
                style: TextStyle(
                    color: Colors.black,
                    letterSpacing: -1.0,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        actions: const <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Icon(
              Icons.videocam,
              color: Colors.black54,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Icon(
              Icons.search,
              color: Colors.black54,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Icon(
              Icons.account_circle,
              color: Colors.black54,
            ),
          ),
        ],
      ),
      body: Stack(children: [
        Center(
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, position) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    videoIndexSelected = position;
                  });
                },
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Image.asset(
                          videos[position].imagePath,
                          fit: BoxFit.cover,
                        )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Icon(
                              Icons.account_circle,
                              size: 40.0,
                            ),
                            flex: 2,
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Text(
                                    videos[position].title,
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ),
                                Text(
                                  videos[position].publisher,
                                  style: TextStyle(color: Colors.black54),
                                )
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                            flex: 9,
                          ),
                          Expanded(
                            child: Icon(Icons.more_vert),
                            flex: 1,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
        videoIndexSelected > -1
            ? LayoutBuilder(
                builder: (context, constraints) {
                  maxVideoWidth = constraints.biggest.width;

                  if (!isInSmallMode) {
                    currentVideoWidth = maxVideoWidth;
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Align(
                          child: Padding(
                            padding: EdgeInsets.all(isInSmallMode ? 8.0 : 0.0),
                            child: GestureDetector(
                              child: Container(
                                width: currentVideoWidth,
                                height: currentVideoHeight,
                                child: Image.asset(
                                  videos[videoIndexSelected].imagePath,
                                  fit: BoxFit.cover,
                                ),
                                color: Colors.blue,
                              ),
                              onVerticalDragEnd: (details) {
                                if (details.velocity.pixelsPerSecond.dy > 0) {
                                  setState(() {
                                    isInSmallMode = true;
                                    alignmentAnimationController.forward();
                                    videoViewController.forward();
                                  });
                                } else if (details.velocity.pixelsPerSecond.dy <
                                    0) {
                                  setState(() {
                                    alignmentAnimationController.reverse();
                                    videoViewController.reverse().then((value) {
                                      setState(() {
                                        isInSmallMode = false;
                                      });
                                    });
                                  });
                                }
                              },
                            ),
                          ),
                          alignment: currentAlignment,
                        ),
                      ),
                      currentAlignment == Alignment.topCenter
                          ? Expanded(
                              flex: 6,
                              child: Container(
                                color: Colors.white,
                                child: const Column(
                                  children: <Widget>[
                                    Row(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Video Recommendation"),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Video Recommendation"),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Video Recommendation"),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      const Row(),
                    ],
                  );
                },
              )
            : Container()
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black54,
            ),
            label: "Home",
            // style: TextStyle(color: Colors.black54),
            // ),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.fire,
                color: Colors.black54,
              ),
              label: "Home"
              // Text(
              //   "Home",
              //   style: TextStyle(color: Colors.black54),
              // ),
              ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.subscriptions,
                color: Colors.black54,
              ),
              label: "home"
              // title: Text(
              //   "Home",
              //   style: TextStyle(color: Colors.black54),
              // ),
              ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.email,
                color: Colors.black54,
              ),
              label: "Home"
              // title: Text(
              //   "Home",
              //   style: TextStyle(color: Colors.black54),
              // ),
              ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.folder,
                color: Colors.black54,
              ),
              label: "Home"
              // title: Text(
              //   "Home",
              //   style: TextStyle(color: Colors.black54),
              // ),
              ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class VideoItemModel {
  String title;
  String publisher;
  String imagePath;

  VideoItemModel(this.title, this.publisher, this.imagePath);
}

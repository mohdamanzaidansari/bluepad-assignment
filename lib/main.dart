import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluepad',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final GlobalKey<State> widgetKey = new GlobalKey();
  final ValueNotifier<bool> _showBottomBar = ValueNotifier(true);

  bool _checkAndSetVisibility(ScrollNotification scroll) {
    BuildContext? currentContext = widgetKey.currentContext;
    if (currentContext == null) return false;

    RenderObject renderObject = currentContext.findRenderObject()!;
    RenderAbstractViewport? viewport = RenderAbstractViewport.of(renderObject);

    if (viewport == null) return false;

    RevealedOffset offsetToRevealBottom =
        viewport.getOffsetToReveal(renderObject, 1.0);
    if (offsetToRevealBottom.offset > scroll.metrics.pixels) {
      _showBottomBar.value = true;
    } else {
      _showBottomBar.value = false;
      print('Bottom of article is reached');
    }
    return false;
  }

  final ValueNotifier<int> _likeCount = ValueNotifier(0);
  final ValueNotifier<int> _commentCount = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                (SnackBar(content: const Text('Home button presssed'))));
          },
          icon: Icon(Icons.home),
        ),
        title: Text(
          'Blue pad',
          style: TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          NotificationListener<ScrollNotification>(
            child: new SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                        Text(
                          'Crypto Investor Buys \$ 69 Million Beeple NFT Art Work',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                            '''The latest news to do the rounds is about the investor from Singapore, has bought \$ 69 Million Beeple NFT. Now, that sounds too interesting. However, he is not ready to divulge his real name. I a world like ours, anyone can attack him for his funds. I just learnt, that this wealthy investor goes by the name Metakovan. It is a record of sorts in the bitcoin genre. The record-braking digital artwork is connected to an image file, that is connected to a NFT. 
You will be amazed to know how lucrative such bitcoins are getting today. Moreover, they are receiving rave reviews. Christie’s Auction House is behind this huge deal. Metakovan also happens to be the chief investor behind Metapurse. It is nothing, but a Crypto-based fund. It is also the largest NFT in the world. At least, that is what it claims to be. Metakovan has also given an interview on Google Hangouts, and states there, that it is one lucrative deal. It is a big investment. The art work in question is interesting. 
It is a mosaic of 5,000 artworks. It took him the last 13 years to prepare it. Says, Mike Winkelmann, who goes by the artist whose name is Beeple. One can find a variety of images inside the mosaic artwork. There is Abraham Lincoln spanking baby Trump, and more interesting ones. The bidding happened on 25 February. If reports are to be believed, initially things were a bit mellow, however, it shot up in the last ten minutes. 
'''),
                        SizedBox(height: 8),
                        Text(
                          'Monetization of NFTs',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                            '''Well, this is not the first time, Metakovan has done this. He has purchased more such Beeple artworks amounting to \$ 2.2 million in December 2020. Moreover, he fractionalized them and locked them with blockchain. No one even got a whiff, of what he was up to. The entire episode has created a sudden gripping interest in NFTs. 
Winkelmann is not ready to divulge any further details yet. Well, Metakovan himself is not planning to sell his shares. This is a historic feat that he has achieved. For the uninitiated, almost 20 million visitors were a part of the auction. And, there were 200 registrations for the bidding. Metakovan was one of them. He has made the payment through ether. This is also a first, for Christie’s. no one has ever received such a large payment in cryptocurrency, in a similar domain. 
This is the third highest amount which has been paid for the artwork of a living artist. So, you can understand, how it is. The entire feeling is simply overwhelming. The amount, that Metakovan has invested in artwork can actually buy a few palaces in France. You could even buy a yacht or an aeroplane, with that amount of money. 
It seems that the market is quite open now.  And, people like Metakovan can do the unimaginable. Metakovan says, that he has no house, or cars. He just loves art and the power of bitcoin. He packs it up and moves on. While the world gushes at him. 
'''),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ValueListenableBuilder(
                                valueListenable: _likeCount,
                                builder: (BuildContext context, int likeCount,
                                    Widget? child) {
                                  return Text('$likeCount Likes');
                                }),
                            ValueListenableBuilder(
                                valueListenable: _commentCount,
                                builder: (BuildContext context,
                                    int commentCount, Widget? child) {
                                  return Text(
                                    '$commentCount Comments',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blue,
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  MyBottomBar(
                    key: widgetKey,
                    likeCount: _likeCount,
                    commentCount: _commentCount,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Comments'),
                        Text('comment'),
                        Text('more comment'),
                        Text('Even more comment'),
                        Container(
                          height: 400,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            onNotification: _checkAndSetVisibility,
          ),
          ValueListenableBuilder(
              valueListenable: _showBottomBar,
              builder:
                  (BuildContext context, bool showBottomBar, Widget? child) {
                return showBottomBar
                    ? MyBottomBar(
                        likeCount: _likeCount,
                        commentCount: _commentCount,
                      )
                    : Container();
              })
        ],
      ),
    );
  }
}

class MyBottomBar extends StatelessWidget {
  final ValueNotifier<int> likeCount;
  final ValueNotifier<int> commentCount;
  const MyBottomBar({
    Key? key,
    required this.likeCount,
    required this.commentCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.thumb_up),
              onPressed: () {
                final value = likeCount.value;
                likeCount.value = value + 1;
              },
            ),
            IconButton(
              icon: Icon(Icons.comment),
              onPressed: () {
                final value = commentCount.value;
                commentCount.value = value + 1;
              },
            ),
          ],
        ),
      ),
    );
  }
}

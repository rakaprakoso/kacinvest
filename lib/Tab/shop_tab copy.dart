import 'package:simple_animations/simple_animations.dart';
import 'package:flutter/material.dart';

class BuyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Container(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 2.2/1,
                      child: FadeAnimation(1, Container(
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(
                          child: Text("All", style: TextStyle(fontSize: 20),),
                        ),
                      )),
                    ),
                    AspectRatio(
                      aspectRatio: 2.2/1,
                      child: FadeAnimation(1.1, Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Center(
                          child: Text("Sneakers", style: TextStyle(fontSize: 17),),
                        ),
                      )),
                    ),
                    AspectRatio(
                      aspectRatio: 2.2/1,
                      child: FadeAnimation(1.2, Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Center(
                          child: Text("Football", style: TextStyle(fontSize: 17),),
                        ),
                      )),
                    ),
                    AspectRatio(
                      aspectRatio: 2.2/1,
                      child: FadeAnimation(1.3, Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Center(
                          child: Text("Soccer", style: TextStyle(fontSize: 17),),
                        ),
                      )),
                    ),
                    AspectRatio(
                      aspectRatio: 2.2/1,
                      child: FadeAnimation(1.4, Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Center(
                          child: Text("Golf", style: TextStyle(fontSize: 17),),
                        ),
                      )),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              FadeAnimation(1.5, makeItem(image: 'assets/images/BGStock2.jpg', tag: 'red', context: context)),
              FadeAnimation(1.6, makeItem(image: 'assets/images/BGStock2.jpg', tag: 'blue', context: context)),
              FadeAnimation(1.7, makeItem(image: 'assets/images/BGStock2.jpg', tag: 'white', context: context)),
            ],
          ),
        );
      
  
  }

  Widget makeItem({image, tag, context}) {
    return Hero(
      tag: tag,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Shoes(image: image,)));
        },
        child: Container(
          height: 250,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400],
                blurRadius: 10,
                offset: Offset(0, 10)
              )
            ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeAnimation(1, Text("Sneakers", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),)),
                        SizedBox(height: 10,),
                        FadeAnimation(1.1, Text("Nike", style: TextStyle(color: Colors.white, fontSize: 20),)),

                      ],
                    ),
                  ),
                  FadeAnimation(1.2, Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white
                    ),
                    child: Center(
                      child: Icon(Icons.favorite_border, size: 20,),
                    ),
                  ))
                ],
              ),
              FadeAnimation(1.2, Text("100\$", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),)),              
            ],
          ),
        ),
      ),
    );
  }
}

class Shoes extends StatefulWidget {
  final String image;

  const Shoes({Key key, this.image}) : super(key: key);

  @override
  _ShoesState createState() => _ShoesState();
}

class _ShoesState extends State<Shoes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Hero(
          tag: 'red',
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.image),
                fit: BoxFit.cover
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400],
                  blurRadius: 10,
                  offset: Offset(0, 10)
                )
              ]
            ),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          child: Icon(Icons.arrow_back_ios, color: Colors.white,),
                        ),
                      ),
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white
                        ),
                        child: Center(
                          child: Icon(Icons.favorite_border, size: 20,),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  child: FadeAnimation(1, Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        colors: [
                          Colors.black.withOpacity(.9),
                          Colors.black.withOpacity(.0),
                        ]
                      )
                    ),
                    child: Material(
                      elevation : 10,
                      color: Colors.blue,
                      borderRadius : BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FadeAnimation(1.3, Text("Sneakers", style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),)),
                          SizedBox(height: 25,),
                          FadeAnimation(1.4, Text("Size", style: TextStyle(color: Colors.white, fontSize: 20),)),
                          SizedBox(height: 10,),
                          Row(
                            children: <Widget>[
                              FadeAnimation(1.5, Container(
                                width: 40,
                                height: 40,
                                margin: EdgeInsets.only(right: 20),
                                child: Center(
                                  child: Text('40', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                                ),
                              )),
                              FadeAnimation(1.45, Container(
                                width: 40,
                                height: 40,
                                margin: EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(
                                  child: Text('42', style: TextStyle(fontWeight: FontWeight.bold),)
                                ),
                              )),
                              FadeAnimation(1.46, Container(
                                width: 40,
                                height: 40,
                                margin: EdgeInsets.only(right: 20),
                                child: Center(
                                  child: Text('44', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                                ),
                              )),
                              FadeAnimation(1.47, Container(
                                width: 40,
                                height: 40,
                                margin: EdgeInsets.only(right: 20),
                                child: Center(
                                  child: Text('46', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                                ),
                              )),
                            ],
                          ),
                          SizedBox(height: 60,),
                          FadeAnimation(1.5, Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(
                              child: Text('Buy Now', style: TextStyle(fontWeight: FontWeight.bold),)
                            ),
                          )),
                          SizedBox(height: 30,),
                        ],
                      ),
                    ),
                  )),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}



class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity").add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      Track("translateY").add(
        Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
        curve: Curves.easeOut)
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
          offset: Offset(0, animation["translateY"]), 
          child: child
        ),
      ),
    );
  }
}
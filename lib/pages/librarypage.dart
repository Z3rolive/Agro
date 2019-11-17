import 'package:agro/Repositories/document_repository.dart';
import 'package:agro/models/document.dart';
import 'package:agro/pages/contentpage.dart';
import 'package:flutter/material.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  List<Document> allContents= DocumentsRepository.loadDocs();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Documents'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: 6,
        itemBuilder: (context, index){
          return InkWell(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ContentPage(content: allContents[index]),
                  ),
                );
            },
                      child: Card(
              child: ListTile(
                leading: Image.asset(
                        allContents[index].imgUrl,
                        height: 100,
                        width: 100,
                      ),
                title: Text(allContents[index].title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),),
                subtitle: Text('View Details'),
              ),
            ),
          );
        },
      )
    );
  }
}
/* GridView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: 6,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.8),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ContentPage(content: allContents[index]),
                  ),
                );
              },
              child: Card(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image.asset(
                        allContents[index].imgUrl,
                        height: 100,
                        width: 100,
                      ),
                      Text(
                        allContents[index].title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      OutlineButton(
                          child: Text("View"),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ContentPage(content: allContents[index]),
                              ),
                            );
                          }),
                    ]),
              ),
            );
          }), */

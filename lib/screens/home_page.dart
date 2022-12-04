import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../model/content_model.dart';
import '../network/api_services.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Meropadai",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
          future: ApiServices.getContent(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ContentModel> result = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(20),
                child: ListView.separated(
                  itemCount: result.length,
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.grey,
                          child: Image.network(result[index].imageUrl!),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text("title",
                              style: TextStyle(
                                fontSize: 20,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text("small description",
                              style: TextStyle(
                                fontSize: 16,
                              )),
                        )
                      ],
                    );
                  },
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Container(
                  child: Text("Err"),
                ),
              );
            }
            return Container();
          }),
    );
  }
}

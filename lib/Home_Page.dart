import 'package:flutter/material.dart';
import 'package:covid_cases_tracker_master/Modals.dart';
import 'package:covid_cases_tracker_master/Helpers_Page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic selectedCountry;
  List country = [];
  List flag = [];
  dynamic i;
  TextStyle mystyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Covid Cases Tracker"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(8),
              // alignment: Alignment.center,
              child: FutureBuilder(
                future: CovidAPIHelper.covidAPIHelper.covidCasesData(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  } else if (snapshot.hasData) {
                    List<Covid19> data = snapshot.data as List<Covid19>;
                    country = data.map((e) => e.country).toList();
                    return Container(
                      padding: const EdgeInsets.all(8),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              child: DropdownButtonFormField(
                                hint: const Text("Please Select Country."),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                                value: selectedCountry,
                                onChanged: (val) {
                                  setState(() {
                                    selectedCountry = val;
                                    i = country.indexOf(val);
                                  });
                                },
                                items: country
                                    .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: const TextStyle(
                                        color: Colors.black),
                                  ),
                                ))
                                    .toList(),
                              ),
                            ),
                            (i != null)
                                ? Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Card(
                                  elevation: 10,
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black)),
                                          height: 160,
                                          width: double.infinity,
                                          child: Image.network(
                                            data[i].flag,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Text(
                                          data[i].country,
                                          style: mystyle,
                                        ),
                                        Text(
                                          "Population: ${data[i].population}",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                infoCard(
                                  title: "Total Cases",
                                  totalCount: data[i].totalCases,
                                  color: Colors.blueGrey,
                                ),
                                infoCard(
                                    title: "Active",
                                    totalCount: data[i].activeCases,
                                    color: Colors.blue),
                                infoCard(
                                    title: "Total Recovered",
                                    totalCount: data[i].totalRecovered,
                                    color: Colors.blue),
                                infoCard(
                                    title: "Total Deaths",
                                    totalCount: data[i].totalDeaths,
                                    color: Colors.black),
                              ],
                            )
                                : Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.end,
                                  children: [
                                    coronaIcon2(
                                        color: Colors.green
                                            .withOpacity(0.1)),
                                    const Spacer(),
                                    coronaIcon2(
                                        color:
                                        Colors.pink.withOpacity(0.1)),
                                  ],
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                coronaIcon(
                                    color: Colors.red.withOpacity(0.1)),
                                const SizedBox(
                                  height: 50,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    coronaIcon2(
                                        color:
                                        Colors.blue.withOpacity(0.1)),
                                  ],
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.end,
                                  children: [
                                    coronaIcon2(
                                        color:
                                        Colors.blue.withOpacity(0.1)),
                                    const SizedBox(
                                      width: 50,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  coronaIcon({required color}) {
    return Icon(
      Icons.coronavirus_outlined,
      size: 60,
      color: color,
    );
  }

  coronaIcon2({required color}) {
    return Icon(
      Icons.coronavirus_rounded,
      size: 60,
      color: color,
    );
  }

  infoCard({required title, required totalCount, required color}) {
    return Card(
      elevation: 5,
      child: Container(
        height: 100,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "$totalCount",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart' as web3;
import 'package:http/http.dart';
import 'package:flutter/services.dart';

class Screen4 extends StatefulWidget {
  String title = "Default";
  String logo_url = "Default";
  String song_url = "Default";
  String artist_email = "Default";
  String owned_email = "Default";
  String price = "Default";

  Screen4({
    required this.title,
    required this.logo_url,
    required this.song_url,
    required this.artist_email,
    required this.owned_email,
    required this.price,
  });

  @override
  State<Screen4> createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  Client? httpsClient;
  web3.Web3Client? ethClient;
  bool data = false;
  TextEditingController val = TextEditingController();
  double myamount = 0.0001;
  final myaddress = "0x21Fb5976b2d5c21F3C15389Ec110283D42d58Cf2";
  var mydata;
  var newData = 0.05;
  @override
  void initState() {
    super.initState();
    // getBalance(myaddress);
    httpsClient = Client();
    ethClient = web3.Web3Client(
        "https://kovan.infura.io/v3/9ce28d61467b44458cdd70c00ee54ae3",
        httpsClient!);
  }

  Future<web3.DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString("assets/abi.json");
    String contractAddress = "0xF4dc48141B5Abe74aD0986dbfD8C424da32575C4";
    final contract = web3.DeployedContract(
        web3.ContractAbi.fromJson(abi, "Bank"),
        web3.EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    final contract = await loadContract();
    final ethFunction = contract.function(functionName);
    print(ethFunction.outputs);
    final result = await ethClient!
        .call(contract: contract, function: ethFunction, params: []);
    print(result);
    return result;
  }

  Future<void> getBalance(String targetaddress) async {
    web3.EthereumAddress address = web3.EthereumAddress.fromHex(targetaddress);
    List<dynamic> result = await query("getBalance", []);
    mydata = result[0];
    data = true;
    setState(() {});
  }

  Future<String> submit(String functionName, List<dynamic> args) async {
    web3.EthPrivateKey credentials = web3.EthPrivateKey.fromHex(
        "3ee7532b8f3acbbbd9b2ccf437ec76ed985360712c03d97ce1fa1e72378112c9");

    web3.DeployedContract contract = await loadContract();
    final ethFunction = contract.function(functionName);

    final result = await ethClient!.sendTransaction(
        credentials,
        web3.Transaction.callContract(
            contract: contract, function: ethFunction, parameters: args),
        chainId: 42);

    return result;
  }

  Future<String> sendCoin() async {
    var Bigamount = BigInt.from(myamount);
    var response = await submit("deposit", [Bigamount]);
    print("Deposited");
    return response;
  }

  Future<String> withdrawCoin() async {
    var Bigamount = BigInt.from(myamount);
    var response = await submit("withdraw", [Bigamount]);
    print("withdrawn");
    return response;
  }

  final _cloudfirestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;

  Future<void> buy() async {
    loggedInUser = _auth.currentUser;
    var currentLoggedIn = loggedInUser?.email.toString();
    print(currentLoggedIn);
    FirebaseFirestore.instance
        .collection('songs')
        .doc('3e8ucNH1KVhd94ctCnWd')
        .update({'owner': currentLoggedIn}).then(
            (value) => print('Suzzess $currentLoggedIn'));
    setState(() {
      newData = newData - 0.0001;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
          title: Text('Wallet',
              style: TextStyle(fontSize: 23, letterSpacing: 1.5))),
      body: SingleChildScrollView(
        child: Container(
          height: 700,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.green[800]!,
                  Colors.green[200]!,
                ]),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: 10.0,
            ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  //Let's add some text title
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      "Your Wallet",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Center(
                  //   child: ElevatedButton(
                  //       child: Text('GET Balance'),
                  //       onPressed: () {
                  //         getBalance(myaddress);
                  //         FocusScope.of(context).unfocus();
                  //       },
                  //       style: ElevatedButton.styleFrom(
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(30),
                  //         ),
                  //         primary: Colors.transparent,
                  //       )),
                  // ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Balance: \Eth ${newData.toStringAsFixed(5)}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                              height: 150,
                              width: 150,
                              margin:
                                  EdgeInsets.only(top: 10, left: 20, right: 20),
                              padding: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(widget.logo_url)),
                                border:
                                    Border.all(color: Colors.black, width: 1.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(child: Text(''))),
                          SizedBox(height: 10),
                          Text(
                            widget.title,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        onPressed: () async {
                          await buy();
                        },
                        child: Text('\nBUY\n\nEth ${widget.price}\n'),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:revengers/widgets/appBar.dart';
import 'package:web3dart/web3dart.dart';
import 'package:velocity_x/velocity_x.dart';

class Screen4 extends StatefulWidget {
  const Screen4({Key? key}) : super(key: key);

  @override
  State<Screen4> createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  TextEditingController walletId = TextEditingController();
  Client? httpsClient;
  Web3Client? ethClient;
  bool data = false;
  TextEditingController val = TextEditingController();
  int myamount = 1;
  final myaddress = "0x21Fb5976b2d5c21F3C15389Ec110283D42d58Cf2";
  var mydata;
  @override
  void initState() {
    super.initState();
    httpsClient = Client();
    ethClient = Web3Client(
        "https://kovan.infura.io/v3/9ce28d61467b44458cdd70c00ee54ae3",
        httpsClient!);
    //getBalance(myaddress);
  }

  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString("assets/abi.json");
    String contractAddress = "0xF4dc48141B5Abe74aD0986dbfD8C424da32575C4";
    final contract = DeployedContract(ContractAbi.fromJson(abi, "Bank"),
        EthereumAddress.fromHex(contractAddress));
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
    EthereumAddress address = EthereumAddress.fromHex(targetaddress);
    List<dynamic> result = await query("getBalance", []);
    mydata = result[0];
    data = true;
    setState(() {});
  }

  Future<String> submit(String functionName, List<dynamic> args) async {
    EthPrivateKey credentials = EthPrivateKey.fromHex(
        "3ee7532b8f3acbbbd9b2ccf437ec76ed985360712c03d97ce1fa1e72378112c9");

    DeployedContract contract = await loadContract();
    final ethFunction = contract.function(functionName);

    final result = await ethClient!.sendTransaction(
        credentials,
        Transaction.callContract(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
          title: Text('Wallet',
              style: TextStyle(fontSize: 23, letterSpacing: 1.5))),
      body: SingleChildScrollView(
        child: Container(
          height: 800,
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
          child: Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: 10.0,
              ),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Let's add some text title
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 20),
                      child: Text(
                        "Your Earnings",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 38.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, right: 20, left: 20, bottom: 8),
                      child: TextField(
                        controller: walletId,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0),
                            ),
                            fillColor: Colors.transparent,
                            hintText: 'Enter Wallet Id',
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                letterSpacing: 2)),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                          child: Text('GET Balance'),
                          onPressed: () {
                            if (walletId.text == "") {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text('Enter Wallet Id to Proceed!',
                                      style: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: 1.0,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w800)),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            } else {
                              getBalance(myaddress);
                            }
                            FocusScope.of(context).unfocus();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            primary: Colors.transparent,
                          )),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Balance: \$${mydata}",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    10.heightBox,
                    data
                        ? "\$${mydata}".text.xl5.bold.makeCentered().shimmer()
                        : Text(''),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       top: 8.0, right: 20, left: 20, bottom: 8),
                    //   child: TextField(
                    //     controller: val,
                    //     onChanged: (value) {
                    //       setState(() {
                    //         var a = val.text, myamount = int.parse(a) * 100;
                    //       });
                    //     },
                    //     keyboardType: TextInputType.number,
                    //     decoration: InputDecoration(
                    //         enabledBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(20),
                    //           borderSide: const BorderSide(
                    //               color: Colors.black, width: 2.0),
                    //         ),
                    //         fillColor: Colors.transparent,
                    //         hintText: 'Enter Amount To Deposit',
                    //         hintStyle: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 20,
                    //             letterSpacing: 2)),
                    //   ),
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     TextButton.icon(
                    //       onPressed: () => sendCoin(),
                    //       label: 'Deposit'.text.black.make(),
                    //       icon: Icon(
                    //         Icons.refresh,
                    //         color: Colors.black,
                    //       ),
                    //     ),
                    //     TextButton.icon(
                    //       onPressed: () => getBalance(myaddress),
                    //       label: 'Refresh'.text.black.make(),
                    //       icon: Icon(
                    //         Icons.call_made_outlined,
                    //         color: Colors.black,
                    //       ),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

(async () => {
  try {
    console.log("Deploying Owner with web3 script while converting ':)' into bytes32 with ethers.js at the same time!");

    const contractName = "Owner";
    const str = ':)'

    //string conversion


    let converted_str = await ethers.utils.formatBytes32String(str);

    console.log("Converted String in byte32 is: ", converted_str)

    //deploying

    const artifactsPath = `browser/contracts/artifacts/${contractName}.json`;

    const metadata = JSON.parse(
      await remix.call("fileManager", "getFile", artifactsPath)
    );
    const accounts = await web3.eth.getAccounts();

    let contract = new web3.eth.Contract(metadata.abi);

    contract = contract.deploy({
      data: metadata.data.bytecode.object,
      arguments: [],
    });

    const newContractInstance = await contract.send({
      from: accounts[0],
      gas: 1500000,
      gasPrice: "30000000000",
    });
    console.log("Contract Address: ", newContractInstance.options.address);
  } catch (e) {
    console.log(e.message);
  }
})();

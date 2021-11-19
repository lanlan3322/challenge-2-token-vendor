module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  const ubdToken = await ethers.getContract("YourToken", deployer);

  // deploy the vendor
  await deploy("Vendor", {
     // Learn more about args here: https://www.npmjs.com/package/hardhat-deploy#deploymentsdeploy
    from: deployer,
    args: [ubdToken.address],
    log: true,
   });
  const Vendor = await deployments.get("Vendor");
  const vendor = await ethers.getContract("Vendor", deployer);

  // transfer the tokens to the vendor
  console.log("\n 🏵  Sending 1000 tokens to the vendor...\n");
  const result = await ubdToken.transfer( vendor.address, ethers.utils.parseEther("1000") );

  // change address with your burner wallet address vvvv
  console.log("\n 🤹  Sending ownership to frontend address...\n", vendor.address)
  await vendor.transferOwnership("0x990e0DB54f2B5Ad17026C14A6D11d30Da845f0bd");
};

module.exports.tags = ["Vendor"];

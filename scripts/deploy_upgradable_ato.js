const { ethers, upgrades } = require('hardhat');

// The deployment script
const main = async() => {
    // Getting the first signer as the deployer
    const [deployer] = await ethers.getSigners();
    // Saving the info to be logged in the table (deployer address)
    var deployerLog = { Label: "Deploying Address", Info: deployer.address };
    // Saving the info to be logged in the table (deployer address)
    var deployerBalanceLog = {
        Label: "Deployer Balance",
        Info: (await deployer.getBalance()).toString()
    };

    // Creating the instance and contract info for the ATO contract
    let ATOInstance, ATOContract;

    // Getting the lottery code (abi, bytecode, name)
    ATOContract = await ethers.getContractFactory("ATO");

    ATOInstance = await upgrades.deployProxy(ATOContract, []);
    
    // Saving the info to be logged in the table (deployer address)
    var ATOLog = { Label: "Deployed ATO Address", Info: ATOInstance.address };

    console.table([
        deployerLog,
        deployerBalanceLog,
        ATOLog
    ]);
}
// Runs the deployment script, catching any errors
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
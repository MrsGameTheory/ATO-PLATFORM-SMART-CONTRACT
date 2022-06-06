const { expect, assert } = require("chai");
const { network, ethers } = require("hardhat");

describe("ATO contract", function() {
    // Creating the instance and contract info for the ATO
    let ATO_Contract, ATO_Instance;

    // Creating the users
    let owner;

    beforeEach(async () => {
        // Getting the signers provided by ethers
        const signers = await ethers.getSigners();
        // Creating the active wallets for use
        owner = signers[0];
        
        // Getting the ATO code (abi, bytecode, name)
        ATO_Contract = await ethers.getContractFactory("ATO");

        // Deploying the instances
        ATO_Instance = await ATO_Contract.deploy();
    })

    /**
     * Testing ATO Contract
     */
    it("Testing ATO Contract", async function() {

    })
})
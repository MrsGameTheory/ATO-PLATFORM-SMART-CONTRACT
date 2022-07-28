require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-ethers");
require("hardhat-gas-reporter");
require("solidity-coverage");
require("@nomiclabs/hardhat-etherscan");
require('@openzeppelin/hardhat-upgrades');

require("dotenv").config();

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  gasReporter: {
    enabled: true,
    currency: 'CHF',
    gasPrice: 21
  },
  networks: {
		moonbase: {
			url: `https://rpc.testnet.moonbeam.network`,
			chainId: 1287,
			accounts: [process.env.PRIVATE_KEY] // Insert your private key here
		},
    moonbeam: {
      url: `https://rpc.api.moonbeam.network`,
			chainId: 1284,
      accounts: [process.env.PRIVATE_KEY]
    },
    hardhat: {
      mining: {
        auto: false,
        interval: 5000
      },
      blockGasLimit: 0x1fffffffffffff,
      gasPrice: 12000000,
      allowUnlimitedContractSize: true,
    },
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_KEY
  },
  solidity: {
    compilers: [
      {
        version: "0.8.4"
      }
    ],
		settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  } 
};

// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.26;

import { Script } from "forge-std/Script.sol";
import { Upgrades, Options } from "openzeppelin-foundry-upgrades/Upgrades.sol";
import { MantraUSD } from "../src/MantraUSD.sol";
import { console } from "forge-std/console.sol";

contract DeployMantraUSD is Script {
    function run() external {
        address M_TOKEN = 0x866A2BF4E572CbcF37D5071A7a58503Bfb36be1b;
        address swapFacility = vm.envOr("SWAP_FACILITY", 0xB6807116b3B1B321a390594e31ECD6e0076f6278);

        address deployer = 0xAFb3280B22d966c17ce62E8d06B9515BD91E155A;

        vm.startBroadcast(deployer);

        Options memory opts;
        opts.constructorData = abi.encode(M_TOKEN, swapFacility);

        // Deploying a Transparent Proxy, which requires a proxy admin.
        address proxy = Upgrades.deployTransparentProxy(
            "MantraUSD.sol", // Contract file name
            deployer, // The admin for the proxy contract
            abi.encodeCall( // The initializer call data
                    MantraUSD.initialize,
                    (
                        "MANTRA USD", // name: MANTRA USD
                        "mantraUSD", // symbol: mantraUSD
                        0x50651b740e5D7B6C7c063C8618ccfc13A24b4874, // yieldRecipient
                        0x3b49208e7e831B29EA2e93fB09f315f414fD7343, // admin
                        0x9cB81AD5423E0ca22d3E3aF3004c85D865B70eFe, // freezeManager
                        0x50651b740e5D7B6C7c063C8618ccfc13A24b4874 // yieldRecipientManager
                    )
                ),
            opts
        );

        vm.stopBroadcast();

        console.log("MANTRA USD deployed at:", proxy);
    }
}

# 🎲 Raffle Smart Contract

A decentralized raffle (lottery) smart contract that uses **Chainlink VRF v2.5** and **Chainlink Automation** to securely and automatically pick a random winner.

## Description

This project implements an **automated raffle system** on the blockchain. Users enter by paying an entrance fee. At regular time intervals, the contract uses **Chainlink Automation** to check if a winner should be picked and **Chainlink VRF** to generate a secure, tamper-proof random winner.

> Author: **Zeco Lionel Pratama**  
> Solidity Version: ^0.8.19

---

## Features

- Players can enter the raffle by sending ETH
- Raffle runs on a configurable time interval
- Randomness is provided by **Chainlink VRF v2.5**
- Fully automated using **Chainlink Automation**
- Winner receives all the collected ETH

---

## Tech Stack

- **Solidity `^0.8.19`**
- **Chainlink VRF v2.5** – For verifiable randomness
- **Chainlink Automation** – For automated execution of winner selection
- Foundry – For testing and deployment

---

## Contract Overview

### Constructor Parameters

- `entranceFee` — Minimum ETH to enter the raffle
- `interval` — Time interval between raffles (in seconds)
- `vrfCoordinator` — Address of Chainlink VRF coordinator
- `gasLane` — Chainlink keyHash
- `subscriptionId` — Chainlink VRF subscription ID
- `callbackGasLimit` — Gas limit for the VRF callback

### Main Functions

- `enterRaffle()` — Join the raffle by sending enough ETH
- `checkUpkeep()` — Called by Chainlink Automation to check if raffle needs execution
- `performUpkeep()` — Requests randomness from Chainlink if conditions are met
- `fulfillRandomWords()` — Called by Chainlink VRF to pick and reward the winner

---

## Sample Usage

```solidity
// Player enters the raffle
raffle.enterRaffle{value: 0.01 ether}();
```

## Events

- `RaffleEntered(address indexed player)`
- `RequestedRaffleWinner(uint256 indexed requestId)`
- `WinnerPicked(address indexed winner)`

## Security

- Implements the Checks-Effects-Interactions pattern  
- Uses enum-based state control (\`RaffleState\`) to prevent unexpected behavior  
- Randomness is securely generated through Chainlink VRF v2.5  
- Fully automated with Chainlink Automation (formerly Chainlink Keepers)  
- ETH transfer to the winner is handled with \`.call()\` and error-checked  

## License

MIT License

## Contact

- GitHub: [ZecoLP](https://github.com/ZecoLP)

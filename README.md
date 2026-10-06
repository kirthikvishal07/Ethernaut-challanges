# Ethernaut — Solidity Security Challenges

This is my ongoing Ethernaut challenge-solving repository. I add to it as I work through the levels, recording the Solidity contracts, Foundry scripts, and exploit approaches I use along the way. The repository is a work in progress and will grow over time.

Challenge implementations live in `src/`, with related Foundry scripts in `script/`. Files are organized by challenge number; new solutions are added as I reach them.

## Requirements

- [Foundry](https://getfoundry.sh/)
- An Ethereum wallet and a funded testnet account for broadcasting transactions
- An Ethernaut challenge instance for levels that interact with the Ethernaut game

Install Foundry, then install the repository dependencies and compile:

```bash
foundryup
forge install
forge build
```

## Configure and run

Create a `.env` file in the repository root for your local credentials. For example:

```dotenv
PRIVATE_KEY=your_test_wallet_private_key
ARBITRUM_SEPOLIA_RPC=https://your-arbitrum-sepolia-rpc-url
ETHERSCAN_KEY=your_explorer_api_key
```

Keep `.env` private. It is ignored by Git; never commit private keys, seed phrases, or API credentials. Use a dedicated test wallet and do not put valuable funds in it.

Before running a script, review it and update any target contract address to the address of your own Ethernaut instance. The scripts are personal working solutions and may need adjustment for your setup or the current challenge instance.

Run a script against Arbitrum Sepolia with:

```bash
forge script script/1.s.sol --rpc-url "$ARBITRUM_SEPOLIA_RPC" --broadcast
```

Replace `1.s.sol` with the script for the challenge you are working on. Check the transaction output, then submit the instance through the [Ethernaut website](https://ethernaut.openzeppelin.com/). The RPC network must match the network where your instance was deployed.

## Repository layout

```text
src/       Challenge contract implementations
script/    Foundry scripts and exploit examples
lib/       Foundry and OpenZeppelin dependencies
foundry.toml
```

## Safety

These contracts and scripts intentionally demonstrate vulnerable patterns. Use them only in local development or against challenge instances you are authorized to interact with. Review every script before broadcasting it.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE).
# Ethernaut-challanges

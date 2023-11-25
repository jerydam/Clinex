
# ClinexToken

ClinexToken is a StarkNet smart contract that implements a simple token standard. It allows users to mint, transfer, approve, and perform other token-related operations.

## Table of Contents

- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
  - [Minting Tokens](#minting-tokens)
  - [Transferring Tokens](#transferring-tokens)
  - [Approving Allowance](#approving-allowance)
  - [Checking Allowance](#checking-allowance)
  - [Transferring From](#transferring-from)
  - [Withdrawing Tokens](#withdrawing-tokens)
  - [Getting Token Information](#getting-token-information)
- [Events](#events)
- [Contributing](#contributing)
- [License](#license)

## Getting Started

### Prerequisites

Before you begin, make sure you have scarb installed:

$ curl --proto '=https' --tlsv1.2 -sSf https://docs.swmansion.com/scarb/install.sh | sh

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/faytey/Clinex.git
   ```
2. cd Clinex

3. $ scarb build

4. Compile the contract:

   ```bash
   starknet-compile clinex_token.cairo
   ```

5. Deploy the contract:

   ```bash
   starknet deploy --contract ClinexToken --network alpha
   ```

## Usage

### Minting Tokens

To mint tokens, call the `mint` function:

```bash
starknet invoke --address CONTRACT_ADDRESS --abi ClinexToken ITokens.mint
```

### Transferring Tokens

To transfer tokens, call the `transfer` function:

```bash
starknet invoke --address CONTRACT_ADDRESS --abi ClinexToken ITokens.transfer --inputs '{"address": "RECEIVER_ADDRESS", "amount": AMOUNT}'
```

### Approving Allowance

To approve allowance for another address, call the `approval` function:

```bash
starknet invoke --address CONTRACT_ADDRESS --abi ClinexToken ITokens.approval --inputs '{"to": "TO_ADDRESS", "amount": AMOUNT}'
```

### Checking Allowance

To check the allowance for a specific address, call the `allowance` function:

```bash
starknet call --address CONTRACT_ADDRESS --abi ClinexToken ITokens.allowance --inputs '{"from": "FROM_ADDRESS", "to": "TO_ADDRESS"}'
```

### Transferring From

To transfer tokens from one address to another using approved allowance, call the `transfer_from` function:

```bash
starknet invoke --address CONTRACT_ADDRESS --abi ClinexToken ITokens.transfer_from --inputs '{"from": "FROM_ADDRESS", "to": "TO_ADDRESS", "amount": AMOUNT}'
```

### Withdrawing Tokens

To withdraw tokens from the contract, call the `withdrawTokens` function:

```bash
starknet invoke --address CONTRACT_ADDRESS --abi ClinexToken ITokens.withdrawTokens --inputs '{"contract_address": "CONTRACT_ADDRESS", "amount": AMOUNT}'
```

### Getting Token Information

To get information about the token, you can use the following functions:

- `get_name`
- `get_symbol`
- `get_decimal`
- `get_total_supply`
- `get_balance_of_user`
- `get_owner`

## Events

The contract emits the following events:

- `TransferFrom`
- `Transfer`
- `Mint`
- `Withdraw`
- `Approval`

These events can be used to track various activities on the contract.

## Contributing

Contributions are welcome! Please follow the [CONTRIBUTING.md](CONTRIBUTING.md) guidelines.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.



# Clinex DAO Smart Contract

## Overview

The Clinex DAO (Decentralized Autonomous Organization) smart contract is designed to manage membership, proposals, and voting within a decentralized organization. It utilizes the StarkNet platform for secure and scalable smart contract execution.

## Features

- **Membership Management:** Users can join the DAO by staking a specified amount of tokens.
- **Proposal Creation:** DAO members can create proposals, providing details such as title, description, and deadline.
- **Voting:** Members can vote on proposals, influencing their approval or rejection.
- **Execution of Proposals:** Approved proposals can be executed, triggering associated actions.

## Contract Structure

### DAO Interface (`IDAO`)

The `IDAO` interface defines the methods that the Clinex DAO contract implements. It includes functions for joining the DAO, accessing DAO features, managing member lists, creating and viewing proposals, voting on proposals, and executing proposals.

### Clinex DAO Contract (`ClinexDao`)

The `ClinexDao` contract implements the `IDAO` interface and provides the core logic for DAO operations. It uses StarkNet storage to maintain information about proposals, members, votes, and other relevant data.

### Proposal Struct

The `Proposal` struct represents a DAO proposal, containing details such as the proposal ID, vote count, title, description, deadline, and a flag indicating whether the proposal has been proposed.

## Usage

### Joining the DAO

To join the Clinex DAO, a user can call the `join_dao` function, staking a specified amount of tokens (e.g., 1000 tokens). Upon successful membership, the user is added to the member list.

```rust
// Example: Join the DAO
const proposalId = dao.join_dao();
```

### Creating a Proposal

Members can create proposals using the `create_proposal` function, providing details such as the title, description, and deadline. The function returns the unique ID of the created proposal.

```rust
// Example: Create a Proposal
const proposalId = dao.create_proposal("Proposal Title", "Description", deadline);
```

### Viewing Proposals

Members can view the list of proposals using the `view_proposals` function.

```rust
// Example: View Proposals
const proposals = dao.view_proposals();
```

### Voting on a Proposal

Members can vote on a proposal using the `vote` function, providing the proposal ID. The function returns a boolean indicating the success of the vote.

```rust
// Example: Vote on a Proposal
const success = dao.vote(proposalId);
```

### Executing a Proposal

Once a proposal is approved through voting, members can execute the proposal using the `execute_proposal` function.

```rust
// Example: Execute a Proposal
const success = dao.execute_proposal(proposalId);
```

### Accessing Member List

To access the list of members, the `member_list` function can be used.

```rust
// Example: Access Member List
const members = dao.member_list();
```

## Getting Started

1. **Clone Repository:**
   ```bash
   git clone https://github.com/faytey/Clinex.git
   ```

2. **Install Dependencies:**
   ```bash
   cd clinex-dao
   # Install dependencies as needed
   ```

3. **Deploy Contract:**
   - Follow the StarkNet documentation on deploying contracts to deploy the `ClinexDao` contract.
   - Configure the contract parameters as necessary.

4. **Interact with Contract:**
   - Use a StarkNet-compatible environment to interact with the deployed contract.
   - Call the provided functions as needed for DAO operations.

## Contributors

- [Jerydam](https://github.com/jerydam)
- [Faytey7](https://github.com/faytey)
- [MrPatrick](https://github.com/mrpatrick030)

## License

This Clinex DAO smart contract is licensed under the [Your License] License.
```


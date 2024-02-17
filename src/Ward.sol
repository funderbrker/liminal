// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

/*
 * Contract used to send USDC from a preset source chain to a present destination chain + address.
 */
contract Ward {
    address custodian;

    modifier onlyCustodian() {
        require(msg.sender == custodian, "IC");
        _;
    }

    // TODO: Be more clever. Allow updates. Etc.
}

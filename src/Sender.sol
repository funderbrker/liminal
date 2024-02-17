// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {IERC20} from "@openzeppelin/token/ERC20/IERC20.sol";
import {ITokenMessenger} from "src/interfaces/ITokenMessenger.sol";

import {Ward} from "src/Ward.sol";

/*
 * Contract used to send USDC from a preset source chain to a present destination chain + address.
 */
contract Sender is Ward {
    ITokenMessenger public tokenMessenger;
    uint32 public destinationDomain;
    bytes32 public mintRecipient;
    address public localUsdc;

    constructor(address _tokenMessenger, uint32 _destinationDomain, bytes32 _mintRecipient, address _localUsdc) {
        custodian = address(msg.sender);

        tokenMessenger = ITokenMessenger(_tokenMessenger);
        destinationDomain = _destinationDomain;
        mintRecipient = bytes32(_mintRecipient);
        localUsdc = _localUsdc;

        IERC20(_localUsdc).approve(address(tokenMessenger), type(uint256).max);
    }

    function out(uint256 amount) external onlyCustodian returns (uint64 _nonce) {
        return tokenMessenger.depositForBurn(amount, destinationDomain, mintRecipient, localUsdc);
    }

    // TODO: Add rescueToken function.
}

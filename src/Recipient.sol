// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "Ward.sol";

contract Recipient is Ward {
    address localUsdc;

    // NOTE: IMessageTransmitter.receive can be called directly from managed EOA. Recipient is preset.
    // /**
    //  * @notice  Triggers mint and receipt of USDC to this contract.
    //  */
    // function receive(bytes message, bytes attestation) external {
    //     messageTransmitter.receiveMessage(message, attestation);
    // }

    constructor(address _tokenMessenger, uint32 _destinationDomain, bytes32 _mintRecipient, address _localUsdc) {
        custodian = address(msg.sender);

        localUsdc = _localUsdc;
    }

    /**
     * @notice  User withdrawal via a custodied send of USDC.
     */
    function withdrawToUser(address user, uint256 amount) external onlyCustodian {
        IERC20(localUsdc).transfer(user, amount);
    }
}

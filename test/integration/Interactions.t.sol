// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {HelperConfig} from "../../script/HelperConfig.s.sol";
import {CreateSubscription, FundSubscription, AddConsumer} from "../../script/Interactions.s.sol";
import {VRFCoordinatorV2_5Mock} from "@chainlink/contracts/src/v0.8/vrf/mocks/VRFCoordinatorV2_5Mock.sol";
import {LinkToken} from "../Mocks/LinkToken.sol";
import {Raffle} from "../../src/Raffle.sol";

contract InteractionsTest is Test {
    CreateSubscription createSubscription;

    address USER = makeAddr("user");
    uint256 public constant USER_BALANCE = 100 ether;

    uint96 public constant BASE_FEE = 0.25 ether;
    uint96 public constant GAS_PRICE_LINK = 1e9;
    int256 public constant LINK_TOKEN_PRICE = 4e15;

    function setUp() external {
        vm.deal(USER, USER_BALANCE);
        createSubscription = new CreateSubscription();
        createSubscription.run();
    }

    function testUserCanCreateSubscriptionInteractions() public {
        // Arrange
        uint256 subId;
        // Act
        VRFCoordinatorV2_5Mock vrfCoordinator = new VRFCoordinatorV2_5Mock(
            BASE_FEE,
            GAS_PRICE_LINK,
            LINK_TOKEN_PRICE
        );

        (subId, ) = createSubscription.createSubscription(
            address(vrfCoordinator),
            USER
        );
        // Assert
        assert(address(vrfCoordinator) != address(0));
        assert(subId != 0);
    }

    function testUserCanFundSubscriptionInteractions() public {
        // Arrange
        uint256 subId;
        address myAccount = vm.addr(1);
        hoax(myAccount, 5e20 ether);

        // Act
        VRFCoordinatorV2_5Mock vrfCoordinator = new VRFCoordinatorV2_5Mock(
            BASE_FEE,
            GAS_PRICE_LINK,
            LINK_TOKEN_PRICE
        );

        (subId, ) = createSubscription.createSubscription(
            address(vrfCoordinator),
            USER
        );
        console.log("SubId is:", subId);

        FundSubscription fundSubscriptionInstance = new FundSubscription();
        fundSubscriptionInstance.fundSubscription(
            address(vrfCoordinator),
            subId,
            USER,
            myAccount
        );
    }
}

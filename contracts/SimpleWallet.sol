pragma solidity ^0.8.7;

import "./Allowance.sol";


contract SimpleWallet is Allowance{
    event MoneySent(address indexed _beneficiary, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);

    function withDrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount){
        require(_amount <= address(this).balance,"Amount is greater than balance in the smart contract");
        if(!isOwner()){
            reduceAllowance(msg.sender,_amount);
        }
        emit MoneySent(_to,_amount);
        _to.transfer(_amount);
    }

    function  renounceOwnership () override public{
        // overriden from ownable contract
        revert("cannot renounce ownership here");
    }

    fallback () external payable {
        emit MoneyReceived(msg.sender,msg.value);
    }

}
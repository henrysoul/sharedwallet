pragma solidity ^0.8.7;
import "./utils/Ownable.sol";
import "./utils/SafeMath.sol";

contract Allowance is Ownable{
    using SafeMath for uint;
    mapping(address=>uint) public allowance;
    event AllowanceChanged(address indexed _who, address indexed _from, uint _oldAmount, uint _newAmount);

    function addAllowance(address _who,uint _amount) public onlyOwner{
        emit AllowanceChanged(_who,msg.sender,allowance[_who], _amount);
        allowance[_who]= _amount;
    }

    modifier ownerOrAllowed(uint _amount){
        require(isOwner() || allowance[msg.sender] >= _amount,"You are not allowed");
        _;
    }

    function reduceAllowance(address _who,uint _amount) internal{
        emit AllowanceChanged(_who,msg.sender,allowance[_who],allowance[_who].sub(_amount));
        allowance[_who] = allowance[_who].sub(_amount);
    }
}
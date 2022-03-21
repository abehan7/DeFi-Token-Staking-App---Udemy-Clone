// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract Tether {
    string public name = "Mock Tether Token";
    string public symbol = "mUSDT";
    uint256 public totalSupply = 1000000000000000000; //1 million tokens
    uint8 public decimals = 18;

    event Transfer(address indexed _from, address _to, uint256 _value);

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    mapping(address => uint256) public balances;

    constructor() {
        balances[msg.sender] = totalSupply;
    }

    function transfer(address _to, uint256 _value)
        public
        returns (bool success)
    {
        // require that the value is greater or equal for transfer
        require(balances[msg.sender] >= _value);
        // transfer the amount and substract the balance
        balances[msg.sender] -= _value;
        //  add the balance to the new address
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
}

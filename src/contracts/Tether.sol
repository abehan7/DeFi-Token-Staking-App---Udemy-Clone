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
    // key : value = address : uint256
    // FIXME:
    mapping(address => mapping(address => uint256)) public allowance;

    // allowance = { owner : { spender : amount } }

    // key : value = address : (key : value = address : uint256)
    // allowance[owner][spender] = amount

    // 주소 => 매핑(주소 => 양)

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

    function approve(address _spender, uint256 _value)
        public
        returns (bool success)
    {
        // check if the spender is the same as the owner
        require(_spender != msg.sender);
        // check if the value is greater or equal for transfer
        require(balances[msg.sender] >= _value);
        // set the allowance to the spender
        allowance[msg.sender][_spender] = _value;
        // FIXME: msg.sender이랑 spender이 어떤 관계인지 잘 모르겠어
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    // FIXME:
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        // require that the value is greater or equal for transfer
        require(balances[_from] >= _value);
        require(allowance[_from][msg.sender] >= _value);
        // transfer the amount and substract the balance
        balances[_from] -= _value;
        //  add the balance to the new address
        balances[_to] += _value;

        // substract the allowance
        // third party
        allowance[_from][msg.sender] -= _value;
        // allowance[msg.sender][_from] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }
}

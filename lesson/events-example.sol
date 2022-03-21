// Decentralized Exchange:  On a smart contract traders can trade tokens - from the smart contract emit an event so
// they can get the data (web front moble)

// After emitting events you can't read them in the past only for entities outside the of the blockchain - not stored as memory
// events have lower gas cost than  storage

pragma solidity >=0.7.0 <0.9.0;

contract LearnEvents {
    // two steps - 1. declare event 2. emit event

    // index keywords help outside consumer filter
    // you can only use indexed keyword makes ethereum more expensive to store so you can only use three

    // camelcase good convention - input field data structure
    // 이런식으로 상수같이 선언을 하고 아래 함수에서 사용함
    // 함수같은데 event라는 새로운 거가 있음
    // 이벤트는 대문자로 시작
    event NewTrade(
        uint256 indexed date,
        address indexed from,
        address to,
        uint256 indexed amount
    );

    function trade(address to, uint256 amount) external {
        // now is curent timestamp
        // outside consumer can recieve event with web3js
        // 아 이걸 web3.js를 통해서 받아올 수 있다는거네
        emit NewTrade(block.timestamp, msg.sender, to, amount);
    }
}

const Tether = artifacts.require("Tether");
const RWD = artifacts.require("RWD");
const DecentralBank = artifacts.require("DecentralBank");

module.exports = async function (deployer, network, accounts) {
  // Deploy Mock Tether Contract
  await deployer.deploy(Tether);
  const tether = await Tether.deployed();

  // Deploy RWD Contract
  await deployer.deploy(RWD);
  const rwd = await RWD.deployed();

  // Deploy DecentralBank Contract
  await deployer.deploy(DecentralBank, rwd.address, tether.address);
  const decentralBank = await DecentralBank.deployed();

  // Transfer all RWD tokens to Decentral Bank
  // 여기서 숫자 await rwd.totalSupply() 이쪽에서 잘못해서 에러가 났어
  // await rwd.transfer(decentralBank.address, await rwd.totalSupply());
  await rwd.transfer(decentralBank.address, 1000000);
  // await rwd.transfer(decentralBank.address, "1000000000000000000000000"); //24개
  // Distribute 100 Tether tokens to investor
  await tether.transfer(accounts[1], "1000000000000000000"); //18개
};

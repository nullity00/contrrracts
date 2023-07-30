const { expect } = require("chai");
const { ethers } = require("hardhat");
const { time } = require("@nomicfoundation/hardhat-network-helpers");

describe("Counter Contract", function () {
  let deployer;
  before(async () => {
    deployer = await ethers.getSigner(0);
    this.balancebefore = await ethers.provider.getBalance(deployer.address);
    const counterFactory = await ethers.getContractFactory(
      "src/Counter.sol:Counter",
      deployer
    );
    this.counter = await counterFactory.deploy({
      value: ethers.utils.parseEther("1"),
    });
    await this.counter.deployed();
  });

  it("Actions", async () => {
    await this.counter.connect(deployer).withdraw();
  });

  after(async () => {
    const number = await ethers.provider.getBalance(deployer.address);
    expect(number).to.lt(this.balancebefore);
  });
});

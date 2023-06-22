from brownie import SimpleStorage,StorageFactory,FundMe, accounts, config
from brownie.network import gas_price
from brownie.network.gas.strategies import LinearScalingStrategy

gas_strategy = LinearScalingStrategy("10 gwei", "20 gwei", 1.1)

gas_price(gas_strategy)

def deploy_fondMe():
    account = accounts.add(config["keys"]["private_key"])
    storageFactory = FundMe.deploy(
        {"from": account,
         "gas_price": gas_strategy},
        publish_source=config["networks"]["goerli"]["verify"]
    )

def main():
    deploy_fondMe()
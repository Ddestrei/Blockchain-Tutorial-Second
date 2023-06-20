from brownie import SimpleStorage,StorageFactory, accounts
from brownie.network import gas_price
from brownie.network.gas.strategies import LinearScalingStrategy

gas_strategy = LinearScalingStrategy("10 gwei", "20 gwei", 1.1)

gas_price(gas_strategy)

def deploy_simplestorage():
    simplestorage = SimpleStorage.deploy({
        "from" : accounts[0],
        "gas_price": gas_strategy 
    })
    print(simplestorage)
    return simplestorage

def deploy_storagefactory():
    storagefactory = StorageFactory.deploy({
        "from" : accounts[0],
        "gas_price": gas_strategy 
    })
    print(storagefactory)
    return storagefactory

def main():
    deploy_simplestorage()
    deploy_storagefactory()

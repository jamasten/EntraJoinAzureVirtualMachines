@description('Choose whether to Intune enroll the virtual machine.')
param intune bool = false

@description('The location for the deployments.')
param location string = resourceGroup().location

@description('DO NOT MODIFY THIS VALUE! The timestamp is needed to differentiate deployments for certain Azure resources and must be set using a parameter.')
param timestamp string = utcNow('yyyyMMddhhmmss')

@description('The resource ID for the target virtual machine.')
param virtualMachineResourceId string

module virtualMachine 'modules/virtualMachine.bicep' = {
  name: 'EntraJoin_${timestamp}'
  scope: resourceGroup(split(virtualMachineResourceId, '/')[2], split(virtualMachineResourceId, '/')[4])
  params: {
    intune: intune
    location: location
    virtualMachineResourceId: virtualMachineResourceId
  }
}

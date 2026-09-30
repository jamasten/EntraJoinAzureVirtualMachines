param intune bool = false
param location string
param virtualMachineResourceId string

resource virtualMachine 'Microsoft.Compute/virtualMachines@2025-04-01' existing = {
  name: split(virtualMachineResourceId, '/')[8]
}

resource extension_AADLoginForWindows 'Microsoft.Compute/virtualMachines/extensions@2021-03-01' = {
  parent: virtualMachine
  name: 'AADLoginForWindows'
  location: location
  properties: {
    publisher: 'Microsoft.Azure.ActiveDirectory'
    type: 'AADLoginForWindows'
    typeHandlerVersion: '2.0'
    autoUpgradeMinorVersion: true
    settings: intune ? {
      mdmId: '0000000a-0000-0000-c000-000000000000'
    } : null
  }
}

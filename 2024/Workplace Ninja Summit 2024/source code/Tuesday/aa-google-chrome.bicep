param hostpoolName string = 'lab-avd-hp-01'
param packageName string = 'GoogleChrome-2'
param displayName string = 'Google Chrome'
param packageFullName string = 'GoogleChrome_70.83.32895.0_x64__g33wvrk220n28-2'
param Imagepath string = '\\\\labcloudsa01.file.core.windows.net\\appattach\\GoogleChrome_70.83.32895.0_x64__g33wvrk220n28.vhd'
param packageRelativePath string = '\\googlechrome\\GoogleChrome_70.83.32895.0_x64__g33wvrk220n28'
param packageFamilyName string = 'GoogleChrome_g33wvrk220n28'
param version string = '70.83.32895.0'
param lastUpdated string = '2024-08-21T12:06:28.7714289'
param appId string = 'CHROME'
param friendlyName string = 'Google Chrome'
param appUserModelID string = 'GoogleChrome_g33wvrk220n28!CHROME'
param description string = 'Google Chrome'
param iconImageName string = 'CHROME-Square44x44Logo.scale-100.png'

resource hp 'Microsoft.DesktopVirtualization/hostPools@2024-04-03' existing = {
  name: hostpoolName
}

resource GoogleChrome 'Microsoft.DesktopVirtualization/appAttachPackages@2024-03-06-preview' = {
  name: 'Google Chrome-2'
  location: 'west europe'
  properties: {
    hostPoolReferences: [
      hp.id
    ]
    image: {
      isRegularRegistration: true
      isActive: true
      packageName: packageName
      displayName: displayName
      packageFullName: packageFullName
      imagePath: Imagepath
      packageRelativePath: packageRelativePath
      packageFamilyName: packageFamilyName
      version: version
      lastUpdated:lastUpdated
      packageApplications: [
        {
          appId:appId
          friendlyName:friendlyName
          appUserModelID: appUserModelID
          description:description
          iconImageName:iconImageName
          rawIcon: rawIcon
          rawPng: rawPng
        }
      ]
    }
    failHealthCheckOnStagingFailure: 'NeedsAssistance'    
  }
}

param rawIcon string = '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'
param rawPng string = 'iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwgAADsIBFShKgAAABVxJREFUWEftlmtQVGUYx3cmrbzbFWoEl4sgl73AghDCXkACTAHLGaf6UJZ9yMYmx2qaRFSybEwkVMIUxZCBvMxYo2mjwCK4QFqjefmgogcB2QV2WUBhgXPYf8+7e1jAlEv1pRmfmd/837PDeX7P+77szEoe1f+msF7ibtUopMa/ETHs2faWm5T+doL42n9TXFSgsuPNWZw5ToXmWEaYi5Y4Sp0KJqJZq0Jbqj+aE+RZ4qv/vlqjojiTLrTVRDImMekGkiAhSyOlURvqyiZNCBrVMu6mxnOp2Gb8xWkUM6nhyUGBU+gUERomGkwnIWhSD3InRomGCIVWbDm+alCrTg42FpsPEdxxoRxMEjIaB4hWoCFKjnqNbIXYdmx1PTycM4oNmdQlYwKH0AkTDIiG0jDAfOcANyIUOK9Sje0kwvMXKiuXzGtlje/fjQP2eVIMWj9cAUvaGpjXrYb541SYV4Wj9QMlzMTQbF2pQAvRVRi0WVQ8vDR6jXvkT0nc298k4VpsyPCdzJejURuGti0Z6L18EZ3Nbahr6kaLpQt8Rx36G4sh/JEK3hDqQDCEuOBZnpPDbpcUi6oHl6I4QaosXgxVYSoKls/HbZLWszskGjQqtO/Nxd27vThY04tXszsR+3UHErZ04JMfu3CrRUB/dwOEy8sgVCsg1Djhq+UOhCoaoMaXE1UPLkVxijSkMAUhNMBrWUkwLAzF7ZdkjkHMm9Ic8rWHuxCxsR2q9U7CRJZs78TpKz2wW0pot5EkDAZPCNUEy6ogxigD5KdIFQXJUBSkIGx/MraujAYXGYT6hGj0XLqIA4YezNtgRWj6g1m0rQP15l46hTdIFkgEuOAZBr/RB5DvXwz5D04W7EjC7zo5jCuXo91kQVJmB5TrrA8lMsOKYxd60W86THfv74B34Qf+7JzRB5DlL0IwwZLxXpoOdelrUGe0IeZLK+RpbcNQiLC1an0b9lXYIFh/g3DW1wXvSB/0nfUZeQD//ARp0L5XECzC1rK8hTi6fQ3uNHVC/ZUVMhLJ1hJDMnithaAB6HqKanrQb6kkoTeJvRwpVHrRWoq+SunoAwSSMGivk8C8JAfL970DY3M9Pj10F0EkexiRX7ShurYP/dc/I+lswhP8UCo8RhkgN0EasCcR96PMW4SDV4+jtllAYmY7Aj63EGYxnQSnWZDx8z10W6+Crwkn2axhCCzPvDj6AP67EzB3dyLmfs9ycJ148F3UtTfhxCUb4rbQvadb6PidRGRYsJHknbYudN/YQLv1INkLLoQKlu6wVzw38gBuF2ZLPY6Fw5+E/rtedkJrP0pG6pH38UttOa6ZbDhyvgd5Z7pRYLDh3K0+XGmpw/5z2WipoK/bGTcXAsvy5x1pr50y8gASSCa4FcZl+ebGY84A3y0gWMbDj56Ve5Lx+tHVKLpyHNWNf+LUzSqsK/8WuoJlMJzwRV/5syS8n2dgNxB2ySzRNHJ558RzvjkLwGADDKyHE+diDrHqQChsepLpnyahiP4pSqJ0JviTM8b+u8A3O3GpV3Y8vHfEwWdnLOXIRO2KRtVx+ifTk0g/A3wZwdKxno7+0umVOCRxF9uPrXxy47Q+O3XwytbCazvlCGwqCoCtdDrJpkHQT3MkXzaVBpgKXHSD2HL85bUtdsXcnGhIv9U6oWEcDDwT83KicPUEHX3ZFGKyk9JJ4E9PQv+pyZViq39eqlyV1itbvVmapcFsEc9tako1vImiwx7oZcLSJ8GXEJT2Xx+jO39CO+5jH7HSJcUBO9ScZ6aa88iM4Ty2xnDJu0K4eyUTub6SCRxfNpETKh7nTHrJR+Ibj+pRjaEkkr8AU2seXsPeMZIAAAAASUVORK5CYII='


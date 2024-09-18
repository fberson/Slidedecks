param personName string
param FavoriteConference string

//Reusing a UDF by placing it in a module
module udf 'b. User-Defined-Functions.bicep' = {
  name: 'udf'
  params: {
    FavoriteConference: FavoriteConference
    personName: personName
  }
}
output result1 string = udf.outputs.result

//Reusing a UDF by importing
import * as myImports from 'b. User-Defined-Functions.bicep'
output result2 string = myImports.personNameAndFavoriteConference(personName,FavoriteConference)



param personName string
param FavoriteConference string

//example of Bicep (ARM) Functions
var dummy1 = length('test')
var dummy2 = first('value')
param dummy3 string = utcNow('d')

//Example of User Defined Function
@description('This super advanced functions outputs a persons favorite conference')
@export()
func personNameAndFavoriteConference(names string, conference string) string => 'We are ${names} and our favorite conference is ${conference}!'

output result string = personNameAndFavoriteConference(personName, FavoriteConference)

// limitations:
// The function can't access variables.
// The function can only use parameters that are defined in the function.
// The function can't use the reference function or any of the list functions.
// Parameters for the function can't have default values.

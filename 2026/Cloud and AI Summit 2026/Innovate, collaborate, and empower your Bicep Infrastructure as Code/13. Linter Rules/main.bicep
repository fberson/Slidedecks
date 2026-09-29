type usedType = {
   name: string
}

type unusedType = string   // Warning: Type "unusedType" is declared but never used.

param person usedType
output personName string = person.name


@secure()
param password string = 'NotSoSecure'  // Warning: Parameter "password" is marked as secure but has a default value that is not secure.



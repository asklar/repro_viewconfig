@echo off

nuget restore windows\rn65.sln

echo Building the native custom control
msbuild .\windows\RuntimeComponent1\RuntimeComponent1.vcxproj /p:Platform=x86 /restore /p:RestorePackagesConfig=true

echo Building the projection
cd /d %~dp0\node_modules\react-native-xaml
dotnet run --project .\Codegen\ -winmd ..\..\windows\RuntimeComponent1\Debug\Merged\RuntimeComponent1.winmd
call yarn add @types/react @types/react-native --save
call yarn
call npx typescript -b

echo Need to add a reference from ReactNativeXaml project to the RuntimeComponent1 project

echo Building the app
cd /d %~dp0
call npx react-native run-windows --logging
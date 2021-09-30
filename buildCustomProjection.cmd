@echo off

echo Building the native custom control
msbuild .\windows\RuntimeComponent1\RuntimeComponent1.vcxproj /p:Platform=x86 

echo Building the projection
cd /d %~dp0\node_modules\react-native-xaml
dotnet run --project .\Codegen\ -winmd ..\..\windows\RuntimeComponent1\Debug\Merged\RuntimeComponent1.winmd
yarn add @types/react @types/react-native --save
yarn
npx typescript -b

echo Building the app
cd /d %~dp0
npx react-native run-windows --logging
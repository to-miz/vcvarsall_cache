# vcvarsall_cache
A batch script to cache the changes made to environment variables by Visual Studios vcvarsall.bat.
It generates a batch file which then uses the cached changes to modify environment variables.

## Usage
To generate a cached vcvarsall batch file use this command:
```
vcvarsall_cache PATH_TO/vcvarsall.bat > my_cached_vcvarsall.bat
```

You can now use the generated batch file to initialize a command prompt for development by running the following command in a command prompt:
```
my_cached_vcvarsall x64
```

This will have a similar effect to calling `vcvarsall x64`.

## Why
Sometimes it is necessary to call vcvarsall in scripts which then get called repeatedly.
One issue with this is that vcvarsall will do various things like crawling through the registry to set environment variables, which is very slow.
This in turn bottlenecks anything that calls vcvarsall repeatedly. Using a batch file that caches the results of vcvarsall can alleviate this problem, but requires manual re-generation of the cache everytime the Visual Studio installation changes.
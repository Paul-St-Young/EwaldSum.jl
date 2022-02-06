# EwaldSum.jl

## Project Setup

1. Create Project
```
julia> ]
pgk> generate EwaldSum
```
2. Activate Project
```
$ cd EwaldSum
julia> ]
pgk> activate .
(EwaldSum) pkg> add SpecialFunctions
```
or `julia --project=.` or use "startup.jl"
```
$ cat ~/.julia/config/startup.jl
using Pkg
if isfile("Project.toml")
  Pkg.activate(".")
end
```
3. Test Project
Create "test/runtests.jl"
```
julia> using Pkg
julia> Pkg.test("EwaldSum")
```
or `julia --project=. test/runtests.jl`

#!/usr/bin/env julia

using EwaldSum, Test, SafeTestsets

@time begin
@time @safetestset "Madelung" begin include("test_vmad.jl") end
end

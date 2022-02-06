using EwaldSum
using Test

nr = 3
nk = 3

# 2D square lattice
axes = [1 0; 0 1]
alpha = 1.0
val = EwaldSum.Madelung.madelung_constant(axes, alpha, nr, nk)
@test isapprox(val, -1.9501324732857146)

# 3D cubic lattice
axes = [1 0 0; 0 1 0; 0 0 1]
alpha = 1.8
val = EwaldSum.Madelung.madelung_constant(axes, alpha, nr, nk)
@test isapprox(val, -1.4186487397403096)

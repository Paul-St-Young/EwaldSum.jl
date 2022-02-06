module EwaldSum

include("vmad.jl")

function main()
  nr = 3
  nk = 3
  # 2D square lattice
  axes = [1 0; 0 1]
  alpha = 1.0
  val = vmad.madelung_constant(axes, alpha, nr, nk)
  println(val)
  # 3D cubic lattice
  axes = [1 0 0; 0 1 0; 0 0 1]
  alpha = 1.8
  val = vmad.madelung_constant(axes, alpha, nr, nk)
  println(val)
end

main()

end # module

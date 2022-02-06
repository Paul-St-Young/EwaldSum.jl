module vmad

using SpecialFunctions: erfc
using LinearAlgebra: dot, det, inv

function integer_mesh(mesh)
  spaces = (-n1:n1 for n1 in mesh)
  gvecs = Iterators.product(spaces...)
  return gvecs
end

function sum_lattice(vsr_of_r::Function, axes::Matrix, nr::Int)
  val = 0.0
  ndim = size(axes, 1)
  mesh = nr*ones(Int, ndim)
  for g in integer_mesh(mesh)
    a = axes*collect(g)
    r = sqrt(dot(a, a))
    if (r<eps(Float64))
      continue
    end
    val += vsr_of_r(r)
  end
  return val
end

function madelung_constant(axes::Matrix, alpha::Float64, nr::Int, nk::Int)
  ndim = size(axes, 1)
  # real-space part is independent of spatial dimensions
  vsr_of_r(r) = erfc(alpha*r)/r
  vlr_r0 = 2*alpha/sqrt(pi)
  # reciprocal-space part changes with dimension
  vlr_of_k2d(k) = 2*pi/k*erfc(k/(2*alpha))
  vlr_of_k3d(k) = 4*pi/(k*k)*exp(-k*k/(4*alpha*alpha))
  if ndim == 2
    vsr_k0 = 2*sqrt(pi)/alpha
    vlr_of_k = vlr_of_k2d
  elseif ndim == 3
    vsr_k0 = pi/(alpha*alpha)
    vlr_of_k = vlr_of_k3d
  else
    msg = "ndim=$ndim not implemented"
    err = ErrorException(msg)
    throw(err)
  end
  # perform Ewald sums
  raxes = 2*pi*transpose(inv(axes))
  vsr = sum_lattice(vsr_of_r, axes, nr)
  vlr = sum_lattice(vlr_of_k, raxes, nk)
  # collect results
  volume = abs(det(axes))
  vsr = (vsr - vlr_r0)/2
  vlr = (vlr - vsr_k0)/volume/2
  vmad = vsr+vlr
  return vmad
end

end

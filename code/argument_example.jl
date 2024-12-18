include("trapezium.jl")
using Plots, LaTeXStrings

# function with unknown zeros:
f(z) = sin(z) - cos(2z) + exp(3z)

# its derivative
df_dz(z) = cos(z) + 2sin(z) + 3exp(3z)

# change integration variable
z(θ) = exp(im*θ)
dz_dθ(θ) = im*exp(im*θ)

# resulting integrand of argument principle
F(θ) = (1/(2π*im)) * df_dz(z(θ))/f(z(θ)) * dz_dθ(θ)

# test for a smallish number of points
println("10-point trapezium rule estimates the number of zeros as: ", trap(F, 10))

# evaluate using trapezium rule
N_range = 1:50
count_ests = zeros(ComplexF64, length(N_range))
for N ∈ N_range
    count_ests[N] = trap(F, N)
end
plot(N_range, abs.(1 .- real.(count_ests)), xlabel=L"N", ylabel=L"|1-I_N|", yaxis=:log, labels="")

# now we know there is just one zero, we can estimate it using the argument principle:
println("10-point trapezium rule estimates the zero as: ", trap(θ->F(θ)*z(θ), 10))

# evaluate using trapezium rule
N_range = 1:50
count_ests = zeros(ComplexF64, length(N_range))
for N ∈ N_range
    count_ests[N] = trap(θ->F(θ)*z(θ), N)
end
plot(N_range, abs.(f.(count_ests)), xlabel=L"N", ylabel=L"|f(\vartheta^{(N)}_0)|", yaxis=:log, labels="")

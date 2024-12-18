function trap(f::Function, N::Integer; a=0::Number, b=2π::Number, periodic=false)
    L = b-a # width of full integral
    h = L/N # meshwidth, defaults to h = 2π/N
    θ = a .+ h*(1:N) # vector of nodes
    if periodic
        return h * sum(f.(θ))
    else
        return (h/2*f(a)) + (h*sum(f.(θ[1:(N-1)]))) + (h/2*f(θ[N]))
    end
end
# Usando paquetes
using LinearAlgebra, Statistics, Plots
#Usando funciones de un paquete
randn()

#Other functions require importing all of the names from an external library
using Plots
n = 100
ϵ = randn(n)
plot(1:n, ϵ)

# Arrays
#As a language intended for mathematical and scientific computing, 
#Julia has strong support for using unicode characters.
#The return type is one of the most fundamental Julia data types:an array

typeof(ϵ)

ϵ[1:5]

## Loops

# poor style
n = 100
ϵ = zeros(n)
for i in 1:n
    ϵ[i] = randn()
end

# better style
# While this example successfully fills in ϵ with the correct values,
# it is very indirect as the connection between the index i and the ϵ vector is unclear.
n = 100
ϵ = zeros(n)
for i in eachindex(ϵ)
    ϵ[i] = randn()
end
#Here, eachindex(ϵ) returns an iterator of indices which can be used to access ϵ.

# Loops over Arrays
ϵ_sum = 0.0 # careful to use 0.0 here, instead of 0
m = 5
for ϵ_val in ϵ[1:m]
    ϵ_sum = ϵ_sum + ϵ_val
end
ϵ_mean = ϵ_sum / m

# Julia there are built in functions to perform this calculation which we can compare against
ϵ_mean ≈ mean(ϵ[1:m])
ϵ_mean ≈ sum(ϵ[1:m]) / m
ϵ_mean == sum(ϵ[1:m]) / m
ϵ_mean === sum(ϵ[1:m]) / m

# User Defined functions# Lets go back to the or loop but restructure
# our program our program so that generation of random
# poor style
function generatedata(n)
    ϵ = zeros(n)
    for i in eachindex(ϵ)
        ϵ[i] = (randn())^2 # squaring the result
    end
    return ϵ
end

data = generatedata(10)
plot(data)

# better style
function generatedata(n)
    ϵ = randn(n) # use built in function
    return ϵ.^2
 end
data = generatedata(5)

# good style
generatedata(n) = randn(n).^2
data = generatedata(5)

# good style
f(x) = x^2 # simple square function
generatedata(n) = f.(randn(n)) # uses broadcast for some function `f`
data = generatedata(5)

generatedata(n, gen) = gen.(randn(n)) # uses broadcast for some function `gen`

f(x) = x^2 # simple square function
data = generatedata(5, f) # applies f
# direct solution with broadcasting, and small user-defined function
n = 100
f(x) = x^2

x = randn(n)
plot(f.(x), label="x^2")
plot!(x, label="x") # layer on the same plot
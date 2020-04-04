module nucleus

const proton_mass = 938.27209 # [MeV/c^2]
const neutron_mass = 939.56563 # [MeV/c^2]
const c = 299792458 # [m/s]

struct Atom
    neutrons::Integer
    protons::Integer
    function Atom(n::Integer, p::Integer)
        n >= 0 || throw(ArgumentError("Number of neutrons $n must be non-negative"))
        p >= 0 || throw(ArgumentError("Number of protons $p must be non-negative"))
        new(n, p)
    end
end

const a_V = 15.75 # [MeV]
const a_S = 17.8 # [MeV]
const a_C = 0.711 # [MeV]
const a_A = 23.7 # [MeV]
const a_P = 11.18 # [MeV]
const k_P = -1 / 2

function δ(N::T, Z::T, A::T) where {T <: Integer}
    δ_0 = a_P * A^k_P

    if iseven(N) && iseven(Z)
        return +1 * δ_0
    end
    if isodd(A)
        return 0
    end
    if isodd(N) && isodd(Z)
        return -1 * δ_0
    end
end

δ(N::T, Z::T) where {T <: Integer} = δ(N, Z, N + Z)

function E_B(N::T, Z::T, A::T) where {T <: Integer}
    return a_V * A - a_S * A^(2 / 3) - a_C * (Z * (Z - 1)) / A^(1 / 3) - a_A * (A - 2 * Z)^2 / A - δ(N, Z)
end

E_B(N::T, Z::T) where {T <: Integer} = E_B(N, Z, N + Z)
E_B(a::Atom) = E_B(a.neutrons, a.protons)

function m(a::Atom)
    (N, Z) = [a.neutrons, a.protons]
    return N * neutron_mass + Z * proton_mass  - E_B(a) / c^2
end

mev_over_c2_to_u(x) = x * 0.00107354411

uranium_235 = Atom(143, 92)
println(mev_over_c2_to_u(m(uranium_235)))
println(E_B(uranium_235))

end # module

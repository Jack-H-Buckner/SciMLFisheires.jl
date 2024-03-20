function FixedVariance(sigmas)
    parameters = NamedTuple()
    loss = (u,uhat,parameters) -> sum(((u .- uhat)./sigmas).^2)
    return loss, parameters
end


function EstimateVariance(sigma_0)
    parameters = (sigma = sigma_0)
    
    function loss(u,uhat,parameters) 
        nugget = 10^-6.0
        Z = 1 ./ (sqrt(2*3.14159)*parameters.sigma .+ nugget)
        ll = -0.5 * (u .- uhat).^2 ./ (parameters.sigma .^2 .+ nugget)
        return sum(ll .+ log.(Z))  
    end
        
    return loss, parameters
end
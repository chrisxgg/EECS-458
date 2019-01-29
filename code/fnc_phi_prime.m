function [ phi_prime ] = fnc_phi_prime(outputs)
    phi_prime = outputs.*(1-outputs);


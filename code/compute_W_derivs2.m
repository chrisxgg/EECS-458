function  dW_matrix = compute_W_derivs2(W_matrix,bias_matrix,training_data,targets,layer_matrix)
temp= size(layer_matrix);
N= temp(1);
dW_matrix_p=cell(N,1);
dW_matrix=cell(N,1);
for n=1:N
    dW_matrix_p{n}=0*W_matrix{n};
    dW_matrix{n}=0*W_matrix{n};
end

temp = size(targets);
P=temp(1);
delta = cell(N,1);

for p=1:P
    
stim_vec= training_data(p,:)';
output =eval_2layer_fdfwdnet(W_matrix,bias_matrix,stim_vec,layer_matrix);
err = output{N}-targets(p);
gprime_k = output{N}*(1-output{N});  
delta{N}= gprime_k*err;


for n=N:-1:2
f=fnc_phi_prime(output{n-1});
delta{n-1}=(W_matrix{n}'*delta{n}).*f;
dW_matrix_p{n} = delta{n}*output{n-1}';
end
dW_matrix_p{1} = delta{1}*stim_vec';
for n=N:-1:1
dW_matrix{n}=dW_matrix{n}+dW_matrix_p{n};
end
end

    

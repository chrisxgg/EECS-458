function output=eval_2layer_fdfwdnet(W_matrix,bias_matrix,stim_vec,layer_matrix)
u_net_layer=[];
temp = size (layer_matrix);
L=temp(1);
output=cell(L,1);
u_net_layer=cell(L,1);
u_net_layer{1}=W_matrix{1}*stim_vec+bias_matrix(1)*ones(layer_matrix(1),1);
output{1}=logsig(u_net_layer{1});
for a=2:L
    u_net_layer{a}=W_matrix{a}*output{a-1}+bias_matrix(a)*ones(layer_matrix(a),1);
    output{a}=logsig(u_net_layer{a});
end

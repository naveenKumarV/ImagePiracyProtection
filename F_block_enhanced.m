function F_out = F_block_enhanced(X, keys)
%% Chen's 4-Dimensional Hyper-chaotic Map
    
    % Parameters
    a = 36; 
    b = 3; 
    c = 28; 
    d = 16; 
    k = 0.2;
    
    % First Mapping
    X1 = zeros(size(X));
    X1(1) = bitand(a, abs(X(2)-X(1)));
    X1(2) = bitand(b, X(1)) + bitand(c, X(2)) - bitand(X(1), X(3)) - bitand(d, X(4));
    X1(3) = bitand(X(1), X(2)) - bitand(d, X(3));
    X1(4) = X(1) + k;
    
    % Second Mapping
    F_out = bitxor(uint8(abs(X1)), keys);
end
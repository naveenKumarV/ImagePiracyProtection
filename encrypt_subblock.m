function encryptedX = encrypt_subblock(X, K, sbox)
    L = X(1:4);
    R = X(5:8);
    for round = 1:4
        tmp = K((round-1)*4+1:round*4)';
        L = bitxor(L, tmp);
        % F_out = F_block(L, sbox);
        F_out = F_block_enhanced(L, tmp);
        R = bitxor(F_out, R);
        [L, R] = swap(L, R);
    end
    encryptedX = [L, R];
end
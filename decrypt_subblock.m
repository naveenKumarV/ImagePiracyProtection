function decryptedX = decrypt_subblock(X, K, sbox)
    L = X(1:4);
    R = X(5:8);
    range = fliplr(1:4);
    for round = range
        [L, R] = swap(L, R);
        tmp = K((round-1)*4+1:round*4)';
        F_in = L;
        L = bitxor(L, tmp);
        % F_out = F_block(F_in, sbox);
        F_out = F_block_enhanced(F_in, tmp);
        R = bitxor(F_out, R);
    end
    decryptedX = [L, R];
end
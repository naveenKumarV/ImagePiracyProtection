function encrypted_block = encrypt_block(block, SB, sbox)
    vector = block(:);
    N = length(block);
    l = N*N;
    encrypted_vector = zeros(l, 1);
    for i = 1:8:l
        encrypted_vector(i:i+7) = encrypt_subblock(vector(i:i+7), SB((i+7)/8, :), sbox);
    end
    encrypted_block = reshape(encrypted_vector, size(block));
    encrypted_block = arnold(encrypted_block, 3);
end
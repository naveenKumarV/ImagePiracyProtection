function decrypted_block = decrypt_block(block, SB, sbox)
    block = uint8(iarnold(block, 3));
    vector = block(:);
    N = length(block);
    l = N*N;
    decrypted_vector = zeros(l, 1);
    for i = 1:8:l
        decrypted_vector(i:i+7) = decrypt_subblock(vector(i:i+7), SB((i+7)/8, :), sbox);
    end
    decrypted_block = reshape(decrypted_vector, size(block));
end
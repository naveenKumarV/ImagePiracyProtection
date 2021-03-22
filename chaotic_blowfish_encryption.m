function encrypted_img = chaotic_blowfish_encryption(img, SB, N, sbox)
    [l, b, tmp] = size(img);
    encrypted_img = zeros(size(img));
    for i = 1:3
        for j = 1:N:l
            for k = 1:N:b
                encrypted_img(j:j+N-1, k:k+N-1, i) = encrypt_block(...
                                      img(j:j+N-1, k:k+N-1, i), SB, sbox);
            end
        end
    end
end
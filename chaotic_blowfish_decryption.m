function decrypted_img = chaotic_blowfish_decryption(encrypted_img, SB, N, sbox)
    [l, b, tmp] = size(encrypted_img);
    decrypted_img = zeros(size(encrypted_img));
    for i = 1:3
        for j = 1:N:l
            for k = 1:N:b
                decrypted_img(j:j+N-1, k:k+N-1, i) = decrypt_block(...
                                      encrypted_img(j:j+N-1, k:k+N-1, i), SB, sbox);
            end
        end
    end
end
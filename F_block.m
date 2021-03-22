function F_out = F_block(X, sbox)
    Y = uint32(zeros(size(X)));
    for i = 1:4
        Y(i) = sbox(i, X(i)+1);
    end
    tmp = mod(Y(1) + Y(2), 2^32);
    tmp = bitxor(tmp, Y(3));
    tmp = mod(tmp + Y(4), 2^32);
    masks = [255, 65280, 16711680, 4278190080];
    F_out = uint8(zeros(size(X)));
    for i = 1:4
        F_out(i) = bitand(tmp, masks(i));
    end
end
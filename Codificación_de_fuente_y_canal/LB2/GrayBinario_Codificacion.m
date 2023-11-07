function y = GrayBinario_Codificacion(x,type)
    bin = str2num(x);
    bin_size = length(bin);
    new_bin = zeros(1,bin_size);
    new_bin(1) = bin(1);
    for i = 2:bin_size
        if strcmp(type,'g2b')
            new_bin(i) = xor(new_bin(i-1),bin(i));
        elseif strcmp(type,'b2g')
            new_bin(i) = xor(bin(i-1),bin(i));
        end
    end
    chr = mat2str(new_bin);
    chr = strrep(chr, '[', '');
    y = strrep(chr, ']', '');
end
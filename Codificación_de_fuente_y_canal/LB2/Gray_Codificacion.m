function y = Gray_Codificacion(x,gray)
    chr = mat2str(x);
    chr = strrep(chr, '[', '');
    chr = strrep(chr, ']', '');
    bin = strsplit(chr,';');
    if gray == 0
        bin = cellfun(@(x) GrayBinario_Codificacion(x,'g2b'),bin,'UniformOutput',false);
    end
    y = cellfun(@delete_space,bin,'UniformOutput',false);
    function newarr = delete_space(strarr)
        newarr = strrep(strarr, ' ', '');
    end
end


function datos_decodificados = decodificarHamming74(codigo_hamming)
    % Calcula las paridades P1, P2 y P4
    P1 = xor(xor(codigo_hamming(3), codigo_hamming(5)), codigo_hamming(7));
    P2 = xor(xor(codigo_hamming(3), codigo_hamming(6)), codigo_hamming(7));
    P4 = xor(xor(codigo_hamming(5), codigo_hamming(6)), codigo_hamming(7));

    % Calcula el índice del bit erróneo
    indice_error = P1 * 1 + P2 * 2 + P4 * 4;

    % Corrige el bit erróneo (si hay errores)
    if indice_error ~= 0
        codigo_hamming(indice_error) = ~codigo_hamming(indice_error);
    end

    % Extrae los bits de datos originales
    datos_decodificados = [codigo_hamming(3), codigo_hamming(4), codigo_hamming(5), codigo_hamming(6)];
end

% Función generadora de bits 1 y 0 (equiprobables)
function lista = entrada_modulador(data)
    unos = ones(1, data / 2);
    ceros = zeros(1, data / 2);
    lista = [unos, ceros];
    % Mezcla de ceros y unos
    lista = lista(randperm(length(lista)));
end
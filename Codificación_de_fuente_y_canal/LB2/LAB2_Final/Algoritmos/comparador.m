% Función comparador que brinda la salida del demodulador
function lista = comparador(data)
    % Lista por comprensión que asigna los valores de salida del demodulador
    lista = data > 0;
end
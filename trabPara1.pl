%trab
gasto('01-09-2021', 'Cimento Campeão CPII', 'Loja do Zé', 20, saco, 28.00, 560.00).
gasto('02-09-2021', 'tijolo', 'Loja do Zé', 10, unidade, 10.00, 100.00).
gasto('02-09-2021', 'tijolo', 'Loja do Zé', 5, unidade, 10.00, 50.00).
gasto('02-09-2021', 'Sabao', 'Loja do Zé', 5, unidade, 10.00, 50.00).
gasto('teste', 'teste', 'teste', 1, unidade, 1, 1).

% comprado_em(’10-09-2021’).
% produto_mais_comprado(X). -> ‘cimento’

compramos(X):- gasto(_, X, _, _, _, _, _), !.

quantos(Produto, Quantidade) :-
    findall(Qtd, gasto(_, Produto, _, Qtd, _, _, _), Soma),
    sumlist(Soma, Quantidade).

valor(Produto, Valor) :-
    findall(Valor, gasto(_, Produto, _, _, _, _, Valor), Soma),
    sumlist(Soma, Valor).

comprado_em(Data, Produtos) :-
    findall(Produtos, gasto(Data, Produtos, _, _, _, _, _), Prods),
    write(Prods).

compra_na_loja(Loja, Valor) :-
    findall(Valor, gasto(_, _, Loja, _, _, _, Valor), Soma),
    sumlist(Soma, Valor).

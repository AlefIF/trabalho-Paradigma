%============================== exer 1 ==============================
% letra B
homem(ivo).
homem(noe).
homem(rai).
homem(gil).
homem(ary).

mulher(ana).
mulher(eva).
mulher(bia).
mulher(clo).
mulher(gal).
mulher(lia).

% letra C
gerou(ivo,eva).
gerou(ana,eva).
gerou(eva,noe).
gerou(rai,noe).
gerou(bia,clo).
gerou(gil,clo).
gerou(bia,rai).
gerou(gil,rai).
gerou(bia,ary).
gerou(gil,ary).
gerou(ary,gal).
gerou(lia,gal).

% letra A
mae(Mae, Filho) :- mulher(Mae), gerou(Mae,Filho).
pai(Pai, Filho) :- homem(Pai), gerou(Pai,Filho).

% letra D
filho(Filho, Pai) :- homem(Filho), gerou(Pai, Filho).
filha(Filho, Pai) :- mulher(Filho), gerou(Pai, Filho).

irmao(Irmao, Pessoa) :- gerou(Pai, Irmao), gerou(Pai, Pessoa), Irmao \== Pessoa, homem(Irmao).
irma(Irma, Pessoa) :- gerou(Pai, Irma), gerou(Pai, Pessoa), Irma \== Pessoa, mulher(Irma).

tio(Tio, Sobrinho) :- homem(Tio), gerou(Pai,Sobrinho), irmao(Tio, Pai).
tia(Tia, Sobrinho) :- mulher(Tia), gerou(Pai,Sobrinho), irma(Tia, Pai).

primo(Primo, Primo2) :- homem(Primo), gerou(X,Primo), (irmao(Tio,X) ; irma(Tio,X)), gerou(Tio,Primo2).
prima(Prima, Primo) :- mulher(Prima), gerou(X,Prima), (irmao(Tio,X) ; irma(Tio,X)), gerou(Tio,Primo).

avo(Avo,Neto) :- homem(Avo), gerou(Avo,X), gerou(X,Neto).
avoh(Avoh,Neto) :- mulher(Avoh), gerou(Avoh,X), gerou(X,Neto).

%============================== exer 2 ==============================

% letra A
feliz(Pessoa) :- gerou(Pessoa,_).
% letra B
casal(Pessoa1, Pessoa2):- gerou(Pessoa1,X), gerou(Pessoa2,X).

%============================== exer 3 ==============================


%============================== exer 4 ==============================
funcionario(1, ana, 1000.90, "ary").
funcionario(2, bia, 1200.00, ------ ).
funcionario(3, ivo, 903.50, "rai, eva").
% letra A
mostrarDependentesIvo() :- (funcionario(_, ivo, _, _, Dep)), write(Dep).
% letra B
mostrarAryResponsavel() :- (funcionario(_, Resp, _, _, "ary")), write(Resp).
% letra C
mostrarDependentes950() :- (funcionario(_, _, Sal, Dep)), Sal < 950.00, write(Dep).
% letra D
mostrarFuncionarioSemDependente() :- (funcionario(_, Fun, _, Dep)), Dep = ------, write(Fun).
%============================== exer 5 ==============================
joga(ana,volei).
joga(bia,tenis).
joga(ivo,basquete).
joga(eva,volei).
joga(leo,tenis).
consultarParceiro(Jogador) :- (joga(Parceiro,tenis), Parceiro \==Jogador), listing(joga(Parceiro,tenis)).


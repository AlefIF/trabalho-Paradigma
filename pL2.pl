%============================== exer 1 ==============================
%(’ ’ = erro de sintaxe, usei ' ')
%?- =(mia,mia).  										 => true
%?- =(mia,vincent).										 => false	
%?- mia = mia.											 => true
%?- 2 = 2.									 			 => true
%?- mia = vincent.										 => false
%?- ’mia’ = mia. 	 									 => true
%?- ’2’ = 2									 			 => false
%?- mia = X.											 => true (X = mia)
%?- X = mia, X = vincent.								 => false
%?- k(s(g),Y) = k(X,t(k)).								 => true (X = s(g), Y = t(k))
%?- k(s(g), t(k)) = k(X,t(Y)).							 => true (X = s(g), Y = k)
%?- loves(X,X) = loves(marcellus,mia).					 => false
%?- [Head|Tail] = [mia, vincent, jules, yolanda].		 => true (Head = mia, Tail = [vincent, jules, yolanda])
%?- [X,Y | W] = [[], dead(z), [2, [b, c]], [], Z].		 => true (W = [[2, [b, c]], [], Z], X = [], Y = dead(z))
%?- [_,X,_,Y|_] = [[], dead(z), [2, [b, c]], [], Z].	 => true (X = dead(z),Y = [])
%============================== exer 2 ==============================
tamanhoAB([], []).
tamanhoAB([_|Ta], [_|Tb]) :- tamanhoAB(Ta, Tb).
%============================== exer 3 ==============================
%1. [a,b,c,d] = [a,[b,c,d]].	=> false
%2. [a,b,c,d] = [a|[b,c,d]].	=> true
%3. [a,b,c,d] = [a,b,[c,d]].	=> false
%4. [a,b,c,d] = [a,b|[c,d]].	=> true
%5. [a,b,c,d] = [a,b,c,[d]].	=> false	
%6. [a,b,c,d] = [a,b,c|[d]].	=> true
%7. [a,b,c,d] = [a,b,c,d,[]].	=> false
%8. [a,b,c,d] = [a,b,c,d|[]].	=> true
%9. [] = [_|[]].				=> false
%10. [] = [_].					=> false
%11. [] = _.					=> true
%============================== exer 4 ==============================
segundo(X,[_,X|_]).
%============================== exer 5 ==============================
troca12([L1e1,L1e2|L1t], [L2e1,L2e2|L2t]) :- 
    L1e1 = L2e2, L1e2 = L2e1, L1t = L2t.
%============================== exer 6 ==============================
%
%============================== exer 7 ==============================
cabe(irina, natasha).
cabe(natasha, olga).
cabe(olga, katarina).
dentro(X, Y) :- cabe(X, Y).
dentro(X, Y) :- cabe(X, W), dentro(W, Y).
%============================== exer 8 ==============================
train(eins,um).
train(zwei,dois).
train(drei,tres).
train(vier,quatro).
train(fuenf,cinco).
train(sechs,seis).
train(sieben,sete).
train(acht,oito).
train(neun,nove).
listatrain([H], X) :- train(H,B), X = B. 
listatrain([H|T], X) :- train(H, B), X = (B,X1), listatrain(T, X1). 
%============================== exer 9 ==============================
duasVezes([T],X) :- X = (T,T).
duasVezes([H|T],X) :- X = (H,H,X1), duasVezes(T,X1).











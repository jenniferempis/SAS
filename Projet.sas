/* Projet */

/* Approche statistique */

/* Premiere partie */

%window Fen
#8 'Nombre de simulations désirées : ' y 9 attr=underline
#25 'APPUYER SUR ENTREE';
%macro inter;
%display Fen;
%mend inter;

Data Simulation;
  %inter;
  Title 'Loi de X pour '&y' simulations';
  Do I=1 to &y;
   X1=int(6*UNIFORM(0))+1;
   X2=int(6*UNIFORM(0))+1;
   X=min(X1,X2);
   Put X=;
   Output;
  End;
Run;

Proc Gchart data=Simulation;
 Hbar X / midpoints=1 2 3 4 5 6 space=0;
Run;

Proc Means data=Simulation;
 Var X;
Run;

/* Deuxieme partie */

%window Fen
#8 'Nombre de simulations désirées : ' y 9 attr=underline
#9 'Valeur du gros lot : ' d 9 attr=underline
#25 'APPUYER SUR ENTREE';
%macro inter;
%display Fen;
%mend inter;

Data Simulation6;
 %inter;
 Title 'Loi uniforme de '&y' simulations';
  Do I=1 to &y;
   X1=int(6*UNIFORM(0))+1;
   X2=int(6*UNIFORM(0))+1;
   X=min(X1,X2);
   Put X=;
   SELECT (X);
    When (1) Y=10;
    When (2) Y=5;
    When (3) Y=0;
    When (4) Y=-5;
    When (5) Y=-10;
    When (6) Y=-&d;
  End;
  Output;
 End;
Run;
 
Proc Univariate data=Simulation6;
 Var Y;
Run;

/* Troisieme partie */

%window Fen3
#8 'Valeur du gros lot : ' d 9 attr=underline
#9 'Coefficient : ' alpha 9 attr=underline
#10 'Rayon : ' r 9 attr=underline
#25 'APPUYER SUR ENTREE';
%macro inter;
%display Fen3;
%mend inter3;

Data Simulation12;
 %inter;
 p=(&alpha)/2;
 t=PROBIT(1-p);
 n1=53000.0+200.0*(&d)+35.0*(&d)*(&d);
 n2=1.0/(1296.0*(&r)*(&r));
 n=n1*t*t*n2;
 n=int(n)+1;
 Title '100 simulations de taille n';
 Do I=1 to 100;
   somme=0;
   Do J=1 to n;
     X1=int(6*UNIFORM(0))+1;
     X2=int(6*UNIFORM(0))+1;
     X=min(X1,X2);
     SELECT (X);
      When (1) Y=10;
      When (2) Y=5;
      When (3) Y=0;
      When (4) Y=-5;
      When (5) Y=-10;
      When (6) Y=-&d;
     End;
   somme=somme+Y;
   End;
   M=somme/n ;
   Put M= ;
   output;
 End;
 Put n= ;
Run;

Proc print data=Simulation12;
Run;

Axis1 order=(-1 to 1 by 0.25) ;
Proc Gplot data=Simulation12;
	Plot M*M / vref=0.25 0.5 0.75 lvref=20 frame vaxis=axis1 haxis=axis1;
Run;

Proc Gchart data=Simulation12;
	Pie M / midpoints=0.25 0.75 ;
Run;
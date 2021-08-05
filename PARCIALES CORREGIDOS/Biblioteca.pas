{La biblioteca de la Universidad Nacional de La Plata necesita un programa para administrar
información de préstamos de libros efectuados en marzo de 2020. Para ello, se debe leer la
información de los préstamos realizados. De cada préstamo se lee: nro. de préstamo, ISBN
del libro prestado, nro. de socio al que se prestó el libro, día del préstamo (1..31). La
información de los préstamos se lee de manera ordenada por ISBN y finaliza cuando se
ingresa el ISBN -1 (que no debe procesarse).
Se pide:
A) Generar una estructura que contenga, para cada ISBN de libro, la cantidad de veces
que fue prestado. Esta estructura debe quedar ordenada por ISBN de libro.
B) Calcular e informar el día del mes en que se realizaron menos préstamos.
C) Calcular e informar el porcentaje de préstamos que poseen nro. de préstamo impar y
nro. de socio par.}

program Biblioteca;

type
	rango=1..31;
	prestamo=record
		nro:integer;
		isbn:integer;
		socio:integer;
		dia:rango;
	end;
	libro=record
		isbn: Integer;
		prestamo:integer;
	end;
	lista= ^nodo;
	nodo=record
		dato:libro;
		sig:lista;
	end;
	vectorcontador=array[rango] of integer;

procedure Inicializarvector(var vc:vectorcontador);
var
	i:integer;
begin
	for i:=1 to 31 do
	begin
		vc[i]:=0;
	end;
end;

procedure leerprestamo(var p:prestamo);
begin
	readln(p.isbn);
	if(p.isbn<>-1) then
	begin
		readln(p.nro);
		readln(p.socio);
		readln(p.dia);
	end;
end;

procedure Insertarordenado (var pri:lista; isbnact:integer; num:integer);
var 
	nue,ant,act:lista;
begin
	new(nue);
	nue^.dato.isbn:=isbnact;
	nue^.dato.prestamo:=num;
	ant:=pri;
	act:=pri;
	while(act<>nil) and (isbnact>act^.dato.isbn) do
	begin
		ant:=act;
		act:=act^.sig;
	end;
	if(ant=act) then
	pri:=nue
	else
		ant^.sig:=nue;
	nue^.sig:=act;
end;
	
procedure cargarLista(var pri:lista; var vc:vectorcontador;var k,n:integer);
var
	p:prestamo; isbnact:integer; num:integer;
begin
	leerprestamo(p);
	while(p.isbn<>-1) do
	begin
		isbnact:=p.isbn;
		num:=0;
		while (p.isbn<>-1) and (p.isbn=isbnact) do
		begin
			num:=num+1;
			n:=n+1;
			if(nro mod 2 <>0) and (socio mod 2=0) then k:=k+1;
			vc[p.dia]:=vc[p.dia]+1;
		end;
		Insertarordenado(pri,isbnact,num);
	end;
end;

procedure minimizarvector (vc:vectorcontador,imin:rango);
vari:integer;
	min:integer;
begin
	for i:=1 to 31 do
	if(vc[i]<min) then
	begin
		imin:=i;
		min:=vc[i];
	end;
end;
	
	


procedure Informar(k,n:integer;imin:rango);
begin
	writeln('El dia del mes con menor cantidad de prestamos fue',imin);
	writeln('El porcentaje de prestamos que poseen numero impar y numero de socio par fue',k/n*100);
end;


var
	pri:lista;
	vc:cectorcontador;
	k,n:integer;
	imin:rango;
	
begin
	pri:=nil;
	n:=0;
	k:=0;
	Inicializarvector(vc);
	cargarLista(pri,vc,k,n);
	minimizarvector(vc);
	Informar(k,n,imin);
end.

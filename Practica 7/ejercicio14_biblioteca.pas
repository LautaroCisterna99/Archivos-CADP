program ejercicio14;
{14. La biblioteca de la Universidad Nacional de La Plata necesita un programa para administrar
información de préstamos de libros efectuados en marzo de 2020. Para ello, se debe leer la información
de los préstamos realizados. De cada préstamo se lee: nro. de préstamo, ISBN del libro prestado, nro. de
socio al que se prestó el libro, día del préstamo (1..31). La información de los préstamos se lee de manera
ordenada por ISBN y finaliza cuando se ingresa el ISBN -1 (que no debe procesarse).
* A) Generar una estructura que contenga, para cada ISBN de libro, la cantidad de veces que fue prestado.
Esta estructura debe quedar ordenada por ISBN de libro.
B) Calcular e informar el día del mes en que se realizaron menos préstamos.
C) Calcular e informar el porcentaje de préstamos que poseen nro. de préstamo impar y nro. de socio
par.
}
const
	DIMF=31;
type
	rango = 1..DIMF;
	prestamo = record
		nroprestamo:integer;
		isbn:integer;
		nrosocio:integer;
		dia:rango;
	end;
	estructura = record
		isbn:integer;
		cantprestamo:integer;
	end;
	lista = ^nodo;
	nodo = record
		dato:estructura;
		sig:lista;
	end;
	vcontador = array [rango] of integer;
procedure inicializarvector(var vc:vcontador);
var
	i:integer;
begin
	for i:=1 to DIMF do begin
		vc[i]:=0;
	end;
end;

procedure leerprestamo(var p:prestamo);
begin
	writeln('INGRESE EL ISBN DEL LIBRO');
	readln(p.isbn);
	if(p.isbn <> -1) then begin
	writeln('INGRESE EL NUMERO DEL PRESTAMO');
	readln(p.nroprestamo);
	writeln('INGRESE EL NUMERO DE SOCIO');
	readln(p.nrosocio);
	writeln('INGRESE EL DIA DE 1 A',DIMF);
	readln(p.dia);
end;
end;
procedure Insertarordenado (var pri:lista; isbnact:integer; num:integer);
var 
	nue,ant,act:lista;
begin
	new(nue);
	nue^.dato.isbn:=isbnact;
	nue^.dato.cantprestamo:=num;
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
function cumple(numprestamo:integer;numsocio:integer):boolean;
begin
	cumple:=(numsocio mod 2 = 0) and (numprestamo  mod 2 <> 0); 
end;
procedure cargarlibros(var l:lista; var porcentaje:real;var vc:vcontador);
{Calcular e informar el día del mes en que se realizaron menos préstamos.}
var
	p:prestamo;
	cant:integer;
	total,aux,isbnact:integer;
begin
	aux:=0;
	total:=0;
	porcentaje:=0;
	leerprestamo(p);
	while(p.isbn <> -1) do begin
		isbnact:=p.isbn;
		cant:=0;
	while(p.isbn <> -1) and (p.isbn = isbnact) do begin
		total:=total+1;
		cant:=cant+1;
		//INSERTAR ATRAS
		Insertarordenado(l,isbnact,cant);
		if(cumple(p.nroprestamo,p.nrosocio)) then aux:=aux+1;
		vc[p.dia]:=vc[p.dia] + 1;
		leerprestamo(p);
	end;

end;
	porcentaje:= aux*100/total;
end;
procedure informar(vc:vcontador; var diamin:rango);
var
	min,i:integer;
begin
	min:=9999;
	for i:=1 to DIMF do begin
		if(vc[i] < min) then begin
			diamin:=i;
			min:=vc[i];
		end;
	end;
end;
var
	l:lista;
	porcentaje:real;
	vc:vcontador;
	diamin:rango;
begin
	inicializarvector(vc);
	cargarlibros(l,porcentaje,vc);
	informar(vc,diamin);
	writeln('porcentaje de préstamos que poseen nro. de préstamo impar y nro de socio par',porcentaje:2:2);
	writeln('Dia en el que se realizaron menos prestamos',diamin);
end.

program ejercicio9;
const
	DIMF = 8;
type
	rango = 1..DIMF;
	cadena50= string[50];
	vcontador = array[rango] of real;
	pelicula = record
		codpelicula:integer;
		titulo:cadena50;
		codgenero: rango;
		puntajeprom: real;
	end;
	critica = record
		codigopelicula:integer;
		dni:integer;
		apell:cadena50;
		nom:cadena50;
		puntaje: integer;
	end;
lista = ^nodo;
nodo = record
	dato: pelicula;
	sig:lista;
end;
procedure inicializarvector(var vc:vcontador);
var
	i:integer;
begin
	for i:=1 to DIMF do begin
		vc[i]:=0;
	end;
end;
procedure leerpelicula(var p:pelicula);
begin
	writeln('PELICULA');
	writeln('LEER CODIGO DE PELICULA');
	readln(p.codpelicula);
	if(p.codpelicula <> -1) then begin
	writeln('LEER TITULO DE LA PELICULA');
	readln(p.titulo);
	writeln('LEER CODIGO DE GENERO');
	readln(p.codgenero);
end;
end;
procedure leercritica(var c:critica);
begin
	writeln('CRITICA');
	writeln('INGRESE EL CODIGO DE PELICULA');
	readln(c.codigopelicula);
	if(c.codigopelicula <> -1) then begin
	writeln('LEER DNI DEL CRITICO');
	readln(c.dni);
	writeln('INGRESE EL APELLIDO DEL CRITICO');
	readln(c.apell);
	writeln('INGRESE EL NOMBRE DEL CRITICO');
	readln(c.nom);
	writeln('INGRESE EL PUNTAJE');
	readln(c.puntaje);
end;
end;
procedure armarnodo(var pri:lista; p:pelicula);
var
	aux:lista;
begin
	new(aux);
	aux^.dato:=p;
	aux^.sig:=pri;
	pri:=aux;
end;
procedure cargarListaPeliculas(var pri:lista);
var
	p:pelicula;
begin
	pri:=nil;
	leerpelicula(p);
	while(p.codpelicula <> -1) do begin
		armarnodo(pri,p);
		leerpelicula(p);
	end;
end;
function cumple(num:integer):boolean;
var
	i,j:integer;
begin
	i:=0;
	j:=0;
	while(num <> 0) do begin
		if((num mod 10)mod 2=0) then i:=i+1
		else
			j:=j+1;
	num:=num DIV 10;
end;
	cumple:=(i=j);
end;

procedure maxgenero(vc:vcontador;var maxgen:rango);
var
	i:integer;
	max:real;
begin
	max:=-9999;
	for i:=1 to DIMF do begin
	if(vc[i] > max) then begin
		maxgen:=i;
		max:=vc[i];
	end;
end;
end;
procedure actualizar(var l:lista;var vc:vcontador;codact:integer;promedio:real;var suma:real);
var
	aux:lista;
begin
	aux:=l;
	while(aux^.dato.codpelicula <> codact) do begin
		aux:=aux^.sig;
	end;
	l^.dato.puntajeprom:=promedio;
	vc[aux^.dato.codgenero]:=vc[aux^.dato.codgenero] + suma;
end;
procedure cargarcriticas(var l:lista;var vc:vcontador);
var
	codact,n:integer;
	c:critica;
	suma,promedio:real;
begin
	suma:=0;
	n:=0;
	promedio:=0;
	leercritica(c);
	while(c.codigopelicula <> -1) do begin
		codact:=c.codigopelicula;
		suma:=0;
		n:=0;
	while(c.codigopelicula <> -1) and(c.codigopelicula = codact) do begin
		n:=n+1;
		suma:= suma + c.puntaje;
		if(cumple(c.dni)) then writeln('el critico:',c.nom,c.apell,'tiene el mismo numero de digitos pares e impares en su dni');
		leercritica(c);	
	end;
	promedio:=suma/n;
	actualizar(l,vc,codact,promedio,suma);
	end;
end;
procedure eliminar(var pri:lista;codigo:integer);
var
	ant,act:lista;
	exito:boolean;
begin
	exito:=false;
	ant:=pri;
	act:=pri;
	while(act <> nil) and (act^.dato.codpelicula <> codigo) do begin
		ant:=act;
		act:=act^.sig;
	end;
	if(act<>nil) then begin 
		exito:=true;
		if(act = pri) then	pri:=act^.sig {si act no llegó al final de la lista}
	else
		ant^.sig:=act^.sig;
	dispose(act);
	end;
	if(exito = true) then writeln('existe y se elimino')
	else
		writeln('no existe o no se elimino');
end;
var
	pri:lista;
	vc:vcontador;
	codigo:integer;
	maxgen:rango;
begin
	inicializarvector(vc);
	cargarListaPeliculas(pri); {SE DISPONE}
	cargarcriticas(pri,vc);
	maxgenero(vc,maxgen);
	writeln('El genero con max puntaje acumulado fue',maxgen);
	writeln('-----------');
	writeln('ingresar un codigo para eliminar');
	readln(codigo);
	eliminar(pri,codigo);
	
end.


program ejercicio1;
const
	FIN = 5;
	CUMPLE= 3355;
type
	cadena50 = string[50];
	rango = 1..FIN;
	vcontador = array[rango] of integer;
	extra = record
		dni:integer;
		nom:cadena50;
		apell:cadena50;
		edad:integer;
		codgenero:rango;
	end;
	lista = ^nodo;
	nodo = record
		dato:extra;
		sig:lista;
	end;
procedure inicializarvector(var vc:vcontador);
var
	i:integer;
begin
	for i:=1 to FIN do begin
		vc[i]:=0;
	end;
end;

procedure leerextra(var e:extra);
begin
	writeln('INGRESE EL DNI DEL EXTRA');
	readln(e.dni);
	writeln('INGRESE EL NOMBRE DEL EXTRA');
		readln(e.nom);
	writeln('INGRESE EL APELLIDO DEL EXTRA');
		readln(e.apell);
	writeln('INGRESE LA EDAD DEL EXTRA');
		readln(e.edad);
	writeln('INGRESE EL CODIGO DEL GENERO DE 1 A',FIN);
		readln(e.codgenero);
end;

procedure armarNodo(var l:lista; e:extra);
var
	aux:lista;
begin
	new(aux);
	aux^.dato:=e;
	aux^.sig:=l;
	l:=aux;
end;

procedure cargarLista(var l:lista);
var
	e:extra;
begin
	l:=nil;
	repeat
		leerextra(e);
		armarNodo(l,e);
	until(e.dni = CUMPLE);
end;
function masdigpares(num:integer):boolean;
var
	i,j:integer;
begin
	i:=0;
	j:=0;
	while(num <> 0) do begin
		if((num mod 10)mod 2 = 0) then i:=i+1
		else
			j:=j+1;
	num:=num DIV 10;
end;
	masdigpares:=(i>j);
end;

procedure dosmaxgenero(v:vcontador;var imax1,imax2:rango);
var
	max1,max2,i:integer;
begin
	max1:=-9999;
	max2:=-9999;
	for i:=1 to 5 do
	begin
		if (v[i]>max1) then
		begin
			max2:=max1;
			imax2:=imax1;
			imax1:=i;
			max1:=v[i];
		end
		else
			if(v[i]>max2) then
			begin
				imax2:=i;
				max2:=v[i];
			end;
	end;
end;

procedure buscaryeliminar(var l:lista;x:integer;var exito:boolean);
var
	ant,act:lista;
begin
	exito:=false;
	act:=l;
	while(act <>nil) and (act^.dato.dni <> x) do begin
		ant:=act;
		act:=act^.sig;
	end;
	if(act <> nil) then begin
		exito:=true;
		if(act = L) then l:=act^.sig
				else
					ant^.sig:=act^.sig;
	dispose(act);
end;
end;

procedure procesarLista(l:Lista;var cant:integer; var vc:vcontador);

begin
	cant:=0;
	while(l <> nil) do begin
		vc[l^.dato.codgenero]:=vc[l^.dato.codgenero]+1;
		if(masdigpares(l^.dato.codgenero)) then cant:=cant+1;
		writeln('cant:',cant);
	l:=l^.sig;
	end;
end;

var
	l:lista;
	vc:vcontador;
	exito:boolean;
	dni,cant:integer;
	maxcod1,maxcod2:rango;
	
begin
	inicializarvector(vc);
	cargarLista(l);
	procesarLista(l,cant,vc);
	dosmaxgenero(vc,maxcod1,maxcod2);
	writeln('la cantidad de personas con mas digitos pares que impares:',cant);
	writeln('los dos codigos de genero mas elegidos son:',maxcod1,'y',maxcod2);
	readln(dni);
	buscaryeliminar(l,dni,exito);

end.

	{dosmaxgenero(vc,maxcod1,maxcod2);
	writeln('la cantidad de personas con mas digitos pares que impares:',cant);
	writeln('los dos codigos de genero mas elegidos son:',maxcod1,'y',maxcod2);
	readln(dni);
	buscaryeliminar(l,dni,exito);}

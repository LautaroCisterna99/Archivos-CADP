program ejercicio6;
const
	DIMF = 7;
	EXITO = 'galileo galilei';
type
	cadena50=string[50];
	rango = 1..DIMF;
	objeto = record
		cod:integer;
		catob:rango;
		nom:cadena50;
		distancia:real;
		nomDescubridor:cadena50;
		anioDescubrimiento:integer;
	end;
	vcontador = array[rango] of integer;
	lista = ^nodo;
	nodo = record
		dato:objeto;
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

procedure leerobjeto(var o:objeto);
begin
	writeln('INGRESE EL CODIGO DEL OBJETO');
	readln(o.cod);
	if(o.cod <> -1) then begin
		writeln('INGRESE LA CATEGORIA DEL OBJETO DE 1 A',DIMF);
		readln(o.catob);
		writeln('INGRESE EL NOMBRE DEL OBJETO');
		readln(o.nom);
		writeln('INGRESE LA DISTANCIA A LA TIERRA');
		readln(o.distancia);
		writeln('INGRESE EL NOMBRE DEL DESCUBRIDOR');
		readln(o.nomDescubridor);
		writeln('INGRESE EL ANIO DEL DESCUBRIMIENTO');
		readln(o.anioDescubrimiento);
	end;
end;

procedure agregarAtras(var l,ult:lista;o:objeto);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=o;
	nue^.sig:=nil;
	if(l=nil)then l:=nue
	else
		ult^.sig:=nue;
ult:=nue;
end;

procedure cargarLista(var l:lista);
var
	o:objeto;
	ult:lista;
begin
	l:=nil;
	leerobjeto(o);
	while(o.cod <> -1) do begin
		agregarAtras(l,ult,o);
		leerobjeto(o);
	end;
end;
procedure dosmaslejanos(codigo:integer;distancia:real; var maxcod1,maxcod2:integer;var maxdistancia1,maxdistancia2:real);
begin
	if(distancia > maxcod1) then begin
		maxcod2:=maxcod1;
		maxdistancia2:=maxdistancia1;
		maxcod1:=codigo;
		maxdistancia1:=distancia
	end
	else
		if(distancia > maxcod2) then begin
			maxcod2:=codigo;
			maxdistancia2:=distancia;
end;
end;

function cumple(num:integer):boolean;
var
	i,j:integer;
begin
	i:=0;
	j:=0;
	while(num <> 0) do begin
		if((num mod 10) mod 2 =0)then i:=i+1
		else
			j:=j+1;
	num:=num DIV 10;
end;
	cumple:=(i>j);
end;

procedure Informar(vc:vcontador);
var
	i:integer;
begin
	for i:=1 to DIMF do begin
		writeln('cantidad de objetos observados en la categoria:',i,'son:',vc[i]);
	end;
end;

procedure procesarLista(l:lista;var vc:vcontador;var maxcod1,maxcod2:integer;var cant:integer);
var
	
	maxdistancia1,maxdistancia2:real;
begin
	maxdistancia1:=-9999;
	maxdistancia2:=-9999;
	maxcod1:=0;
	maxcod2:=0;
	cant:=0;
	while(l <> nil) do begin
		writeln;
		vc[L^.dato.catob]:=vc[l^.dato.catob]+1;
		dosmaslejanos(l^.dato.cod,l^.dato.distancia,maxcod1,maxcod2,maxdistancia1,maxdistancia2);
		if(cumple(l^.dato.cod)) then writeln('4)',l^.dato.nom,'posee mas digitos pares que impares');
		if(l^.dato.nomDescubridor = EXITO)and (l^.dato.anioDescubrimiento < 1600) then cant := cant+1;
		writeln;
	l:=l^.sig;
	end;
end;
var
	l:lista;
	vc:vcontador;
	cant,maxcod1,maxcod2:integer;
begin
	inicializarvector(vc);
	cargarLista(l);
	procesarLista(l,vc,maxcod1,maxcod2,cant);
	informar(vc);
	writeln('1) los codigos de los dos objetos mas lejanos de la tierra son',maxcod1,'y',maxcod2);
	writeln('2) cantidad de planetas descubiertos por galileo galilei antes del anio 1600',cant);
end.

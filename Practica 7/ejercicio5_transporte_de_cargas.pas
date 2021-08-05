program empresa;
const
	DIMF = 2;
type
	rango = 1..DIMF;
	rango2= 1800..2021;
	cadena50=string[50];
	camion = record
		patente:cadena50;
		anioFab:rango2;
		capacidad:real;
	end;
	viaje = record
		codviaje:integer;
		codcamion:rango;
		distancia:real;
		ciudaddest:cadena50;
		anioviaje: rango2;
		dni:integer;
	end;
	vectorcamiones = array[rango] of camion; {se dispone}
	lista = ^nodo;
	nodo = record
		dato:viaje;
		sig:lista;
	end;
	vcontador = array[rango]of real;
procedure inicializarvector(var vc:vcontador);
var
	i:integer;
begin
	for i:=1 to DIMF do begin
		vc[i]:=0;
	end;
end;
procedure leercamion(var c:camion);
begin
	writeln('VECTOR CAMIONES');
	writeln('INGRESE LA PATENTE');
		readln(c.patente);
	writeln('INGRESE EL ANIO DE FABRICACION');
		readln(c.anioFab);
	writeln('INGRESE LA CAPACIDAD EN TONELADAS');
		readln(c.capacidad);
end;

procedure cargarCamiones(var v:vectorcamiones);
var
	i:integer;
	c:camion;
begin
	for i:=1 to DIMF do begin
		leercamion(c);
		v[i]:=c;
	end;
end;
procedure leerviaje(var v:viaje);
begin
	writeln('LISTA VIAJES');
	writeln('INGRESE EL CODIGO DEL VIAJE');
	readln(v.codviaje);
	if(v.codviaje <> -1) then begin
		writeln('INGRESE EL CODIGO DEL CAMION');
		readln(v.codcamion);
		writeln('INGRESE LA DISTANCIA RECORRIDA');
		readln(v.distancia);
		writeln('INGRESE LA CIUDAD DE DESTINO');
		readln(v.ciudaddest);
		writeln('INGRESE EL ANIO DEL VIAJE');
		readln(v.anioviaje);
		writeln('INGRESE EL DNI DEL CHOFER');
		readln(v.dni);
	end;
end;

procedure armarnodo(var l:lista; v:viaje);
var
	aux:lista;
begin
	new(aux);
	aux^.dato:=v;
	aux^.sig:=l;
	l:=aux;
end;

procedure cargarLista(var l:lista);
var
	v:viaje;
begin
	l:=nil;
	leerviaje(v);
	while(v.codviaje <> -1) do begin
		armarNodo(l,v);
		leerviaje(v);
	end;
end;


procedure maxkmrecorrido(vc:vcontador;var kmax1:rango);
var
	i:integer;
	max:real;
begin
	max:=-9999;
	for i:=1 to DIMF do begin
		if(vc[i] > max) then begin
			max:=vc[i];
			kmax1:=i;
	end;
end;
end;
//<>
//  []
procedure minkmrecorrido(vc:vcontador;var kmin1:rango);
var
	i:integer;
	min:real;
begin
	min:=9999;
	for i:=1 to DIMF do begin
		if(vc[i] < min) then begin
			kmin1:=i;
			min:=vc[i];
		end;
	end;
end;
function cumple(num:integer):boolean;
begin
	while(num <> 0) do begin
		if((num mod 10) mod 2 <> 0) then cumple:=true
	else num:=num DIV 10
end
end;
procedure procesarLista(l:lista;v:vectorcamiones; var vc:vcontador;var j:integer);
begin
	j:=0;
	while(l <> nil) do begin
		vc[l^.dato.codcamion] := vc[l^.dato.codcamion] + l^.dato.distancia;
	{b}	if(v[l^.dato.codcamion].capacidad > 30.5) and (l^.dato.anioviaje - v[l^.dato.codcamion].anioFab > 5) then j:=j+1;
	{c)}if(cumple(l^.dato.dni)) then writeln('el viaje de codigo',l^.dato.codviaje,'fue realizado por un chofer de dni con digitos impares');		
		l:=l^.sig;
	end;
end;
var
	l:lista;
	v:vectorcamiones;
	vc:vcontador;
	kmin1,kmax1:rango;
	j:integer;
begin
	inicializarvector(vc);
	cargarCamiones(v);{se dispone}
	cargarLista(l); {lista viajes}
	procesarLista(l,v,vc,j);
	minkmrecorrido(vc,kmin1);
	maxkmrecorrido(vc,kmax1);
	writeln('cantidad de viajes que se han realizados en camiones con capacidad mayor a 30.5 toneladas y que poseen una antiguedad mayor a 5 anios:',j);
	writeln('patente del camion que mas kilometros recorridos posee es:',v[kmax1].patente);
	writeln('patente del camion que menos kilometros recorridos posee es',v[kmin1].patente);
end.

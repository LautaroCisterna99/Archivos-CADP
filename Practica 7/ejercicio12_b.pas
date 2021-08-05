program fortaco;
{12. El centro de deportes Fortaco’s quiere procesar la información de los 4 tipos de suscripciones que
ofrece: 1)Musculación, 2)Spinning, 3)Cross Fit, 4)Todas las clases. Para ello, el centro dispone de una tabla
con información sobre el costo mensual de cada tipo de suscripción.
Realizar un programa que lea y almacene la información de los clientes del centro. De cada cliente se
conoce el nombre, DNI, edad y tipo de suscripción contratada (valor entre 1 y 4). Cada cliente tiene una
sola suscripción. La lectura finaliza cuando se lee el cliente con DNI 0, el cual no debe procesarse.
Una vez almacenados todos los datos, procesar la estructura de datos generada, calcular e informar:
- La ganancia total de Fortaco’s
- Las 2 suscripciones con más clientes.
- Genere una lista con nombre y DNI de los clientes de más de 40 años que están suscritos a
CrossFit o a Todas las clases. Esta lista debe estar ordenada por DNI.}
const
	DIMF = 4;
type
	rango = 1..DIMF;
	cadena50= string[50];
	cliente = record
		dni:integer;
		nom:cadena50;
		edad:integer;
		tipo:rango;
	end;
	lista = ^nodo;
	nodo = record
		dato: cliente;
		sig:lista;
	end;
	vtabla = array[rango] of real;
	vcontador = array[rango] of integer;
procedure cargartabla(var vt:vtabla);
begin
	vt[1]:=4.50;
	vt[2]:=7.50;
	vt[3]:=6.50;
	vt[4]:=3.50;
end;
procedure inicializarvector(var vc:vcontador);
var
	i:integer;
begin
	for i:=1 to DIMF do begin
		vc[i]:=0;
	end;
end;
	
procedure insertarOrdenado (var l:lista; c:cliente);
var
	nue,act,ant:lista;
begin
	new(nue);
	nue^.dato:=c;
	act:=l;
	ant:=l;
	
	while(act<>nil) and (c.dni>act^.dato.dni) do
	begin
		ant:=act;
		act:=act^.sig;
	end;
	if(act=ant) then
	begin
		l:=nue;
	end
	else
		ant^.sig:=nue;
	nue^.sig:=act;
end;
	
procedure leercliente(var c:cliente);
begin
	writeln('INGRESE EL DNI DEL CLIENTE');
	readln(c.dni);
	if(c.dni<>0) then begin
		writeln('INGRESE EL NOMBRE DEL CLIENTE');
		readln(c.nom);
		writeln('INGRESE LA EDAD DEL CLIENTE');
		readln(c.edad);
		writeln('INGRESE EL TIPO DE SUSCRIPCION DEL CLIENTE DE 1 A',DIMF);
		readln(c.tipo);
	end;
end;


procedure cargarListaclientes(var pri2:lista;vt:vtabla;var vc:vcontador; var gananciatotal:real);
var
	c:cliente;
begin

	pri2:=nil;
	gananciatotal:=0;
	leercliente(c);
	while(c.dni  <> 0)do begin
		gananciatotal:= gananciatotal + vt[c.tipo];
		vc[c.tipo]:=vc[c.tipo]+1;
		if(c.edad = 40) and (c.tipo = 3) or (c.tipo = 4) then insertarOrdenado(pri2,c);
		leercliente(c);
	end;
end;
procedure maxsuscripciones(vc:vcontador;var maxsus1,maxsus2:rango);
var
	i,max1,max2:integer;
begin
	max1:=-9999;
	max2:=-9999;
	for i:=1 to DIMF do begin
		if(vc[i] > max1) then begin
			max2:=max1;
			maxsus2:=maxsus1;
			max1:=vc[i];
			maxsus1:=i;
		end
		else
		if(vc[i] > max2) then begin
			max2:=vc[i];
			maxsus2:=i;
		end;
	end;
end;

var
	pri2:lista;
	vt:vtabla;
	vc:vcontador;
	gananciatotal:real;
	maxsus1,maxsus2:rango;
begin
	inicializarvector(vc);
	cargartabla(vt);
	cargarListaclientes(pri2,vt,vc,gananciatotal);
	maxsuscripciones(vc,maxsus1,maxsus2);
	writeln('la ganancia total de fortacos es:',gananciatotal:2:2);
	writeln('la dos suscripciones con mas clientes son:',maxsus1,'y',maxsus2);
end.

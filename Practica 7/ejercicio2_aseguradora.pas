{2. Implementar un programa que lea y almacene información de clientes de una empresa aseguradora
automotriz. De cada cliente se lee: código de cliente, DNI, apellido, nombre, código de póliza
contratada (1..6) y monto básico que abona mensualmente. La lectura finaliza cuando llega el cliente
con código 1122, el cual debe procesarse.
La empresa dispone de una tabla donde guarda un valor que representa un monto adicional que el
cliente debe abonar en la liquidación mensual de su seguro, de acuerdo al código de póliza que tiene
contratada.
Una vez finalizada la lectura de todos los clientes, se pide:
a. Informar para cada cliente DNI, apellido, nombre y el monto completo que paga mensualmente
por su seguro automotriz (monto básico + monto adicional).
b. Informar apellido y nombre de aquellos clientes cuyo DNI contiene al menos dos dígitos 9.
c. Realizar un módulo que reciba un código de cliente, lo busque (seguro existe) y lo elimine de la
estructura.}
program ejer2;
const
	DIMF = 6;
	CUMPLE = 1122;
type
	rango = 1..DIMF;
	cadena50 = string[50];
	vcontador = array [rango] of integer;
	cliente = record
		codcliente:integer;
		dni:integer;
		apell:cadena50;
		nom:cadena50;
		codpoliza:rango;
		monto:real;
	end;
	vprecios= array[rango] of real;
	lista = ^nodo;
	nodo = record
		dato:cliente;
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

procedure cargarprecios(var vp:vprecios);

begin
	vp[1]:=22.5;
	vp[2]:=12.5;
	vp[3]:=9.5;
	vp[4]:=4.5;
	vp[5]:=5.5;
	vp[6]:=8.5;
end;

procedure leercliente(var c:cliente);
begin
		writeln('INGRESE CODIGO DEL CLIENTE');
		readln(c.codcliente);
		writeln('INGRESE DNI DEL CLIENTE');
		readln(c.dni);
		writeln('INGRESE APELLIDO DEL CLIENTE');
		readln(c.apell);
		writeln('INGRESE NOMBRE DEL CLIENTE');
		readln(c.nom);
		writeln('INGRESE CODIGO DE LA POLIZA DE 1 A ',DIMF);
		readln(c.codpoliza);
		writeln('INGRESE MONTO DEL CLIENTE');
		readln(c.monto);
end;
procedure armarnodo(var l:lista; c:cliente);
var
	aux:lista;
begin
	new(aux);
	aux^.dato:=c;
	aux^.sig:=l;
	l:=aux;
end;

procedure cargarLista(var l:lista);
var
	c:cliente;
begin
	l:=nil;
	repeat
		leercliente(c);
		armarNodo(l,c);
	until(c.codcliente = CUMPLE);
end;
procedure incisoA(c:cliente; vp:vprecios);
var
	montocompleto:real;
{DNI, apellido, nombre y el monto completo que paga mensualmente
por su seguro automotriz (monto básico + monto adicional).}
begin
	writeln;
	montocompleto:=0;
	writeln('INCISO A');
	writeln('Documento del cliente');
	writeln(c.dni);
	writeln('Nombre del cliente ');
	writeln(c.nom);
	writeln('Apellido del cliente');
	writeln(c.apell);
	montocompleto:= c.monto + vp[c.codpoliza];
	writeln('el monto completo es:',montocompleto:2:2);
	writeln;
end;

function almenosdosdigitos9 (num:integer):boolean;
var
	i:integer;
begin
	i:=0;
	while(num <> 0) and (i < 2) do begin
		if((num mod 10)=9) then i:=i+1;
		num:=num DIV 10;
	end;
almenosdosdigitos9:=(i >= 2);
end;
{b. Informar apellido y nombre de aquellos clientes cuyo DNI contiene al menos dos dígitos 9.}

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
	if(exito = true) then writeln('se elimino')
	else
		writeln('No se elimino');
end;
end;

{c. Realizar un módulo que reciba un código de cliente, lo busque (seguro existe) y lo elimine de la
estructura.}

procedure procesarLista(l:lista; var vc:vcontador;vp:vprecios);
begin
	while(l <> nil) do begin
		vc[l^.dato.codpoliza]:=vc[l^.dato.codpoliza]+1;
		incisoA(l^.dato,vp);
		if(almenosdosdigitos9(l^.dato.dni)) then begin
			writeln('INCISO B');
			writeln('Nombre del cliente con al menos dos digitos 9');
			writeln(l^.dato.nom);
			writeln('Apellido del cliente con al menos dos digitos 9');
			writeln(l^.dato.apell);
		end;
	l:=l^.sig;
	end;
end;
var
	l:lista;
	vc:vcontador;
	vp:vprecios;
	exito:boolean;
	dni:integer;
begin
	cargarprecios(vp);
	inicializarvector(vc);
	cargarLista(l);
	procesarLista(l,vc,vp);
	writeln('ingrese un dni pa borrar');
	readln(dni);
	buscaryeliminar(l,dni,exito);
end.

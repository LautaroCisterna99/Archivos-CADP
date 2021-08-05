program concesionaria;
{Una concesionaria de la ciudad de La Plata necesita un programa para administrar
información de ventas de autos efectuadas en febrero de 2020. Para ello, se debe leer la
información de las ventas realizadas. De cada venta se lee: código de venta, modelo de
auto, DNI del cliente al que se vendió el auto, día de la venta (1..28). La información de las
ventas se lee de manera ordenada por modelo de auto y finaliza cuando se ingresa el
modelo ‘ZZZ’ (que no debe procesarse).
Se pide:
A) Generar una estructura que contenga, para cada modelo de auto, la cantidad de veces
que fue vendido. Esta estructura debe quedar ordenada por modelo de auto.
B) Calcular e informar el día del mes en que se realizaron más ventas a clientes con DNI
impar.
C) Calcular e informar el porcentaje de ventas con código par.
INSTRUCCIONES PARA ENVIAR DEL PARCIA
* }
const
	fin='zzz';
type
	cadena50=string[50];
	rango = 1..28;
	venta = record
		modauto:cadena50;
		codventa:integer;
		dni:integer;
		diaventa:rango;
	end;
	ventaModelo= record	//estructura nueva
		modelo: cadena50;
		cantidad:integer;
	end;
	vcontador=array[rango]of integer;
lista = ^nodo;
nodo = record
	dato: ventaModelo;
	sig:lista;
end;
procedure inicializarvector(var vc:vcontador);
var
	i:integer;
begin
	for i:=1 to 28 do begin
		vc[i]:=0;
	end;
end;

procedure leerventa(var v:venta);
begin
	writeln('INGRESE EL MODELO DEL AUTO');
	readln(v.modauto);
	if(v.modauto <> fin) then begin
		writeln('INGRESE EL CODIGO DE VENTA');
		readln(v.codventa);
		writeln('INGRESE EL DOCUMENTO');
		readln(v.dni);
		writeln('INGRESE EL DIA DE VENTA (1 A 28)');
		readln(v.diaventa);
	end;
end;
function espar(num:integer):boolean;
begin
	espar:=(num mod 2=0);
end;
procedure insertar(var l:lista; var ult:lista; modactual:ventaModelo);
var
	aux:lista;
begin
	new(aux);
	aux^.dato:=modactual;
	aux^.sig:=nil;
	if(l=nil) then l:=aux
		else
			ult^.sig:=aux;
	ult:=aux;
end;
procedure procesarventas(var l:lista;var porcentaje:real; var vc:vcontador);
var
	canttotal,cantpar:integer;
	v:venta;
	ult:lista;
	modactual:ventaModelo;	{el segundo registro}
begin
	l:=nil;
	canttotal:=0;
	cantpar:=0;
	leerventa(v);
	while(v.modauto <> fin)do begin
		modactual.modelo:= v.modauto;
		modactual.cantidad:=0;
	while(v.modauto <> fin) and (v.modauto = modactual.modelo) do begin
		canttotal:=canttotal+1;
		modactual.cantidad:=modactual.cantidad+1;
		if(espar(v.dni)) then  cantpar:=cantpar+1;
		{if(par(v.dni)) then vc[v.diaventa]:=v[v.diaventa]+1;}
		if(not espar(v.dni))then vc[v.diaventa]:=vc[v.diaventa]+1;
		leerventa(v);
	end;
	insertar(l,ult,modactual);
end;
	porcentaje:=(cantpar * 100) / canttotal;
end;
procedure calcularmaximo(vc:vcontador;var diamaxventa:integer);
var
	i:integer;
	max:integer;
begin
	max:=-9999;
	for i:=1 to 28 do begin
		if(vc[i] > max) then begin
			max:=vc[i];
			diamaxventa:=i;
		end;
	end;
end;
var
	l:lista;
	vc:vcontador;
	diamaxventa:integer;
	porcentaje:real;
begin
	l:=nil;
	inicializarvector(vc);
	procesarventas(l,porcentaje,vc);
	calcularmaximo(vc,diamaxventa);
	writeln('el dia del mes en que se realizaron mas ventas a clientes con dni impar es el:',diamaxventa);
	writeln('el porcentaje de ventas con codigo par es:',porcentaje:2:2);
end.

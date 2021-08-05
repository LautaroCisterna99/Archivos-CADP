
program partidos;
const DIMF = 38;
type
    cadena50=string[50];
    rango = 1..DIMF;
    venta = record
        codpartido: rango;
        codcliente:integer;
        cantentradas:integer;
    end;
    partido = record
        codpartido:rango;
        nom:cadena50;
        capacidad:integer;
        horaI:integer;
    end;
    estructura = record
        codigo:rango;
    end;
lista = ^nodo;
nodo = record
    dato:venta;
    sig:lista;
end;
lista2 = ^nodo2;
nodo2=record
dato2:estructura;
sig2:lista2;
end;
vcontador = array[rango] of integer;
vpartido = array[rango]of partido;
procedure inicializarvector(var vc:vcontador);
var
    i:integer;
begin
    for i:=1 to DIMF do 
        vc[i]:=0;
    end;
procedure leerpartido(var p:partido);
begin
    readln(p.codpartido);
    readln(p.nom);
    readln(p.capacidad);
    readln(p.horaI);
end;

procedure cargarpartidos(var v:vpartido);
var
    i:integer;
    p:partido;
begin
    for i:=1 to DIMF do begin
        leerpartido(p);
        v[p.codpartido]:=p;
    end;
end;

procedure armarnodo(var l:lista2;codigo:rango);
var
    aux:lista2;
begin
    new(aux);
    aux^.dato2.codigo:=codigo;
    aux^.sig2:=l;
    l:=aux;
end;

function cumple(num:integer):boolean;
begin
    cumple:=((num mod 100)>=30) or((num mod 100)<=39);
end;

procedure procesarlista(l:lista; vp:vpartido; var cantventas:integer; var pri:lista2);
var
    vc:vcontador;
    i:integer;
begin
    pri:=nil;
    cantventas:=0;
    inicializarvector(vc);
    while(l<>nil)do begin
        vc[l^.dato.codpartido]:=vc[l^.dato.codpartido]+l^.dato.cantentradas;
        if(l^.dato.cantentradas > 5) and (cumple(l^.dato.codcliente)) then cantventas:=cantventas+1;
    l:=l^.sig;
    end;
    for i:=1 to DIMF do begin
        if(vc[i]>vp[i].capacidad / 2) then armarnodo(pri,i);
    end;
end;
var
    l:lista;
    pri:lista2;
    vp:vpartido;
    cant:integer;
begin
	l:=nil;
    cargarpartidos(vp);
    cargarlista(l); //se dispone
    procesarlista(l,vp,cant,pri);
    writeln('cantidad de ventas de menos de 5 entradas cuyo codigo de cliente termina en 30 o 39',cant);
end.
begin
  writeln ('Hello World')
end.


program ejercicio11;
const
	DIMF = 100;
	DIMF2 = 5;
type
	cadena50=string[50];
	rango = 1..DIMF;
	rango2 = 1..DIMF2;
	evento = record
		nomEvento:cadena50;
		tipo: rango2;
		lugar: cadena50;
		cantmaxima:integer;
		costo:real;
	end;
	venta = record
		codventa:integer;
		numevento:rango;
		dni:integer;
		cantentradas:integer;
	end;
	vectoreventos = array[rango] of evento; {se DISPONE}
	vcontador = array[rango] of real;
	lista = ^nodo;
	nodo = record
		dato:venta;
		sig:lista;
	end;
procedure inicializarvector(var vc:vcontador);
var
    i:integer;
begin
    for i:=1 to DIMF do
        vc[i]:=0;
end;
{procedure cargarVector(var v:vectorevento); SE DISPONE}
procedure leerventa(var v:venta);
begin
	writeln('-------VENTA-------');
	writeln('INGRESE EL CODIGO DE VENTA');
	readln(v.codventa);
	if(v.codventa <> -1) then begin
	writeln('INGRESE EL NUMERO DE EVENTO');
	readln(v.numevento);
	writeln('INGRESE EL DNI DEL COMPRADOR');
	readln(v.dni);
	writeln('INGRESE LA CANTIDAD DE ENTRADAS ADQUIRIDAS');
	readln(v.cantentradas);
end;
end;
procedure leerevento(var e:evento);
begin
	writeln('NOMBRE DEL EVENTO:');
	readln(e.nomEvento);
	writeln('TIPO DEL EVENTO DE 1 A',DIMF2);
	readln(e.tipo);
	writeln('LUGAR DEL EVENTO');
	readln(e.lugar);
	writeln('CANTIDAD MAXIMA DE PERSONAS');
	readln(e.cantmaxima);
	writeln('COSTO DE LA ENTRADA');
	readln(e.costo);
end;
procedure armarnodo(var l:lista; v:venta);
var
	aux:lista;
begin
	new(aux);
	aux^.dato:=v;
	aux^.sig:=l;
	l:=aux;
end;
procedure cargarEventos(var v:vectoreventos);
var
	e:evento;
	i:integer;
begin
	for i:=1 to DIMF do begin
		leerevento(e);
		v[i]:=e;
	end;
end;
procedure cargarLista(var l:lista);
var
	v:venta;
begin
	l:=nil;
	leerventa(v);
	while(v.codventa <> -1) do begin
	armarNodo(l,v);
	leerventa(v);
	end;
end;
procedure mindoseventos(vc:vcontador; var mincod1,mincod2:rango);
var
    i:integer;
    min1,min2:real;
begin
    min1:=9999;
    min2:=9999;
    for i:=1 to DIMF do begin
        if(vc[i]<min1) then begin
            min2:=min1;
            mincod2:=mincod1;
            min1:=vc[i];
            mincod1:=i;
        end
        else
        if(vc[i]<min2)then begin
            min2:=vc[i];
            mincod2:=i;
        end;
    end;
end;
function cumple(num:integer):boolean;
var
	i,j:integer;
begin
	i:=0;
	j:=0;
	while(num <> 0) do begin
		if((num mod 10) mod 2 = 0) then i :=i +1
		else
			j:=j+1;
		num:=num DIV 10;
	end;
	cumple:=(i>j);
end;
function incisoC(cantmax:integer;cant:integer):boolean;
var
	ok:boolean;
begin
	ok:=false;
	if(cantmax = cant) then ok := true;
	incisoC:=ok;
end;
procedure procesarLista(l:Lista; v:vectoreventos;var vc:vcontador;var cant:integer);
var
	cantaux:integer;
	recaudacion:real;
begin
	cant:=0;
	cantaux:=0;
	while(l<>nil) do begin
	    recaudacion:= v[l^.dato.numevento].costo + l^.dato.cantentradas;
	   vc[l^.dato.numevento]:=vc[l^.dato.numevento]+recaudacion;
	if(cumple(l^.dato.dni)) and (v[l^.dato.numevento].tipo = 3)then cant:=cant+1;
	if(l^.dato.numevento = 50) then cantaux:=cantaux+1;
	l:=l^.sig;
	end;
		if(incisoC(v[50].cantmaxima,cantaux)) then  writeln ('se lleno')
	else
		writeln('todavia no se lleno');
end;

var
	l:lista;
	v:vectoreventos;
	cant:integer;
	mincod1,mincod2:rango;
	vc:vcontador;
begin
    inicializarvector(vc);
	cargarEventos(v);{SE DISPONE}
	cargarLista(l);
	procesarlista(l,v,vc,cant);
	mindoseventos(vc,mincod1,mincod2);
	writeln;
	writeln('el nombre y lugar de los dos eventos que han tenido menos recaudacion son:');
	writeln('nombre evento 1 ==',v[mincod1].nomEvento,'lugar del evento ===',v[mincod1].lugar);
	writeln('nombre evento 2 ==',v[mincod2].nomEvento,'lugar del evento ===',v[mincod2].lugar);
	writeln;
	writeln('cantidad de entradas vendidas cuyo comprador contiene en su dni mas digitos pares que impares y "obra de teatro"',cant);
	writeln;

end.

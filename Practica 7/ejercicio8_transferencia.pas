program ejercicio8;
const
	DIMF = 7;
type
	rango = 1..DIMF;
	cadena50=string[50];
	fechas = record
		dia: 1..31;
		mes:1..12;
		anio:1700..2021;
	end;
	vcontador = array[rango] of integer;
	transferencia = record
		nrocuentaOrigen:integer;
		dniOrigen:integer;
		numDestino:integer;
		DniDestino:integer;
		fecha:fechas;
		hora: cadena50;
		monto:real;
		codigo:rango;
		
	end;
	lista = ^nodo;
	nodo = record
		dato:transferencia;
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
procedure leerfecha(var f:fechas);
begin
	writeln('INGRESE EL DIA');
	readln(f.dia);
	writeln('INGRESE EL MES');
	readln(f.mes);
	writeln('INGRESE EL ANIO');
	readln(f.anio);
end;
procedure leertransferencia(var t:transferencia);
begin
	writeln('INGRESE LA CUENTA DE ORIGEN');
	readln(t.nrocuentaOrigen);
	if(t.nrocuentaOrigen <> 0) then begin
	writeln('INGRESE EL DNI DE LA CUENTA DE ORIGEN');
		readln(t.dniOrigen);
	writeln('INGRESE EL NUMERO DE LA CUENTA DESTINO');
		readln(t.numDestino);
	writeln('INGRESE EL DNI DE LA CUENTA DESTINO');
		readln(t.DniDestino);
	writeln('INGRESE LA FECHA DE LA TRANSFERENCIA');
		leerfecha(t.fecha);
	writeln('INGRESE LA HORA DE LA TRANSFERENCIA');
		readln(t.hora);
	writeln('INGRESE EL MONTO DE LA TRANSFERENCIA');
		readln(t.monto);
	writeln('INGRESE EL CODIGO DE LA TRANSFERENCIA DE 1 A',DIMF);
		readln(t.codigo);
end;
end;
procedure insertarOrdenado(var l:lista; t:transferencia);
var
	ant,act,nue:lista;
begin
	new(nue);
	nue^.dato:=t;
	ant:=l;
	act:=l;
	while(act <> nil) and (l^.dato.nrocuentaOrigen < t.nrocuentaOrigen) do begin
		ant:=act;
		act:=act^.sig;
	end;
	if(act=ant) then l:=nue
	else
		ant^.sig:=nue;
nue^.sig:=act;
end;

procedure armarnodo(var l:lista; t:transferencia); {ESTO NO VA}
var
	aux:lista;
begin
	new(aux);
	aux^.dato:=t;
	aux^.sig:=l;
	l:=aux;
end;

procedure cargarLista(var l:lista);
var
	t:transferencia;
begin
	l:=nil;
	leertransferencia(t);
	while(t.nroCuentaOrigen <> 0) do begin
		armarNodo(l,t);
		leertransferencia(t);
	end;
end;

procedure generarLista(pri:lista; var l:lista);
begin
	l:=nil;
	while(pri <> nil)do begin
		if(pri^.dato.nrocuentaOrigen <> pri^.dato.numDestino) then insertarOrdenado(l,pri^.dato);
	pri:=pri^.sig
	end;
end; 

procedure procesarLista(l:lista;var vc:vcontador; var cant:integer; var maxcod:rango);
function cumple(num:integer):boolean;
var
	i,j:integer;
begin
	i:=0;
	j:=0;
	while(num <> 0) do begin
		if((num mod 10) mod 2= 0) then i:=i+1
		else
			j:=j+1;
	num:=num DIV 10;
	end;
	cumple:=(i<j);
end;
function montototal(t:transferencia):real;
begin
	montototal:=0;
	montototal:= montototal + t.monto;
end;
procedure maxcodigo(vc:vcontador;var maxcod:rango;max:integer);
var
	i:integer;
begin
	for i:=1 to DIMF do begin
		if(vc[i] > max) then begin
			maxcod:=i;
			max:=vc[i];
		end;
end;
end;
var
	max,cuentactual:integer;
begin
	cant:=0;
	max:=-9999;
	while(l <> nil) do begin
		cuentactual:= l^.dato.nrocuentaOrigen;
	while(l<> nil) and (cuentactual = l^.dato.nrocuentaOrigen) do begin
		writeln('monto total transferido a terceros:',montototal(l^.dato):2:2);
		vc[l^.dato.codigo]:=vc[l^.dato.codigo] +1;
		maxcodigo(vc,maxcod,max);
		if(cumple(l^.dato.numDestino)) and (l^.dato.fecha.mes =6) then cant:=cant+1;
	l:=l^.sig;
	end;
end;
end;
var
	pri,l:lista;
	vc:vcontador;
	cant:integer;
	maxcod:rango;
begin
	inicializarvector(vc);
	cargarLista(pri);
	generarLista(pri,l);
	procesarLista(l,vc,cant,maxcod);
	writeln('el codigo que mas transferencias a terceros tuvo es:',maxcod);
	writeln('cantidad de transferencias a terceros realizados en el mes de junio...',cant);
end.

program fortaco;
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
	estructura = record
		nom:cadena50;
		dni:integer;
	end;
	listaNueva = ^nodo2;
	nodo2= record
		dato2:estructura;
		sig2:listaNueva;
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
	
procedure insertarOrdenado (var l:listaNueva; nom:cadena50; dni:integer);
var
	nue,act,ant:listaNueva;
begin
	new(nue);
	nue^.dato2.nom:=nom;
	nue^.dato2.dni:=dni;
	act:=l;
	ant:=l;
	while(act<>nil) and (act^.dato2.dni > dni) do
	begin
		ant:=act;
		act:=act^.sig2;
	end;
	if(act=ant) then
	begin
		l:=nue;
	end
	else
		ant^.sig2:=nue;
	nue^.sig2:=act;
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

procedure armarnodo(var l:lista; c:cliente);
var
	aux:lista;
begin
	new(aux);
	aux^.dato:=c;
	aux^.sig:=l;
	l:=aux;
end;

procedure cargarListaclientes(var l:lista);
var
	c:cliente;
begin
	l:=nil;
	leercliente(c);
	while(c.dni  <> 0)do begin
		armarnodo(l,c);
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
procedure procesarLista(l:lista;var pri2:listaNueva;vt:vtabla;var vc:vcontador; var gananciatotal:real);
begin
	gananciatotal:=0;
	pri2:=nil;
	while(l <> nil) do begin
	gananciatotal:= gananciatotal + vt[l^.dato.tipo];
	vc[l^.dato.tipo]:=vc[l^.dato.tipo]+1;
	if(l^.dato.edad > 40) and (l^.dato.tipo = 3) or (l^.dato.tipo = 4) then insertarOrdenado(pri2,l^.dato.nom,l^.dato.dni);
	l:=l^.sig;
	end;
end;
procedure recorrerlista(pri:listaNueva);
begin
	while(pri <> nil) do begin
		writeln('dni:',pri^.dato2.dni);
	pri:=pri^.sig2;
	end;
end;
var
	l:lista;
	pri2:listaNueva;
	vt:vtabla;
	vc:vcontador;
	gananciatotal:real;
	maxsus1,maxsus2:rango;
begin
	inicializarvector(vc);
	cargartabla(vt);
	cargarListaclientes(l);
	procesarLista(l,pri2,vt,vc,gananciatotal);
	recorrerlista(pri2);
	maxsuscripciones(vc,maxsus1,maxsus2);
	writeln('la ganancia total de fortacos es:',gananciatotal:2:2);
	writeln('la dos suscripciones con mas clientes son:',maxsus1,'y',maxsus2);
end.

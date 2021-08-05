program ejercicio10;
const
	DIMF = 20;
	DIMF2= 4;
	SMDM = 'san miguel del monte';
type
	cadena50=string[50];
	rango = 1..DIMF;
	rango2 = 1..DIMF2;
	cultivo = record
		tipo: rango2;
		canthectareas: integer;
		cantmeses:integer;
	end;
	vectorcultivos = array[rango] of cultivo;
	empresa = record
		codempresa:integer;
		nom:cadena50;
		estatal:boolean; {E: estatal o P:privada}
		ciudad:cadena50;
		nrocult: integer;
		cultivos: vectorcultivos;
	end;
lista = ^nodo;
nodo = record
	dato: empresa;
	sig:lista;
end;
procedure leercultivo(var c:cultivo);
begin
	writeln('INGRESE LA CANTIDAD DE HECTAREAS');
	readln(c.canthectareas);
	if(c.canthectareas <> 0) then begin
	writeln('INGRESE EL TIPO DE CULTIVO DE 1 A',DIMF2);
	readln(c.tipo);
	writeln('INGRESE LA CANTIDAD DE MESES');
	readln(c.cantmeses);
end;
end;
procedure cargarempresa(var e:empresa);
var
c:cultivo;
gestion: cadena50;
begin
	writeln('INGRESE CODIGO DE EMPRESA');
	readln(e.codempresa);
	if(e.codempresa <> -1) then begin
		e.estatal:=true;
		writeln('INGRESE EL NOMBRE DE LA EMPRESA');
		readln(e.nom);
		writeln('INGRESE SI ES ESTATATAL O PRIVADA');
		readln(gestion);
		if(gestion = 'privada') then e.estatal := false;
		writeln('INGRESE LA CIUDAD DONDE ESTA RADICADA');
		readln(e.ciudad);
		e.nrocult:=0;
		writeln('CULTIVOS');
		leercultivo(c);
		while(c.canthectareas <> 0) do begin
			e.nrocult:=e.nrocult+1;
			e.cultivos[e.nrocult]:=c;
			writeln('CULTIVOS');
			leercultivo(c);
		end;
end;
end;
procedure armarnodo(var l:lista; e:empresa);
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
	e:empresa;
begin
	cargarempresa(e);
	while(e.codempresa <> -1) do begin
		armarnodo(l,e);
		cargarempresa(e);
	end;
end;
function cumple(num:integer):boolean;
var
	cant:integer;
begin
	cant:=0;
	while(num <> 0) and (cant < 2) do begin
		if((num mod 10) = 0) then cant:=cant+1;
		num:=num DIV 10;
	end;
	cumple:=(cant = 2);
end;
function cumpletrigo(v:vectorcultivos;dimL:integer):boolean;
var
	aux:boolean;
	i:integer;
begin
	i:=0;
	aux:=false;
	while(aux = false) and (i <= dimL) do begin
		i:=i+1;
		aux:=(v[i].tipo = 1);
	end;
	cumpletrigo:= aux;
end;
procedure incisos(v:vectorcultivos;dimL:integer; e:empresa; var maxnom:cadena50);
var
	i,cant,max,canthectareastotal:integer;
	porcentaje:real;
begin
	max:=-9999;
	cant:=0;
	porcentaje:=0;
	canthectareastotal:=0;
	{b}if(e.ciudad = SMDM) and (cumpletrigo(v,diml)) and (cumple(e.codempresa)) then 
		writeln('nombre de la empresas radicadas en',SMDM,'que cultivan trigo y cuyo codigo de empresa posee al menos dos ceros es == ',e.nom);	
	for i:=1 to dimL do begin
		if(v[i].tipo = 2) and (v[i].cantmeses > max) then begin
			max:=v[i].cantmeses;{d}
			maxnom:=e.nom;
		end;
		{e}if(v[i].tipo = 4) and (v[i].canthectareas < 5) and (e.estatal = false) then v[i].cantmeses:=v[i].cantmeses+1;
			canthectareastotal:=canthectareastotal+v[i].canthectareas;
		{c}if(v[i].tipo = 3) then 
			cant:=cant +1;
end;
porcentaje:= cant*100/canthectareastotal;
writeln('C)cantidad de hectareas dedicadas al cultivo de soja',cant,'porcentaje de las hectareas con respecto al total de hectareas',porcentaje:2:2);
end;
procedure procesarLista(l:Lista; var maxnom:cadena50);
begin
	while(l <> nil) do begin
		incisos(l^.dato.cultivos,l^.dato.nrocult,l^.dato,maxnom);
	l:=l^.sig;
end;
	{promedio:= canthectareastotal/cant;}
end;
var
	l:lista;
	maxnom:cadena50;
begin
	cargarlista(l);
	procesarLista(l,maxnom);
	writeln('D) la empresa que dedica mas tiempo al cultivo de maiz es:',maxnom);
end.

{La plataforma YouTube está analizando algunos de sus principales canales de video. Para
ello, YouTube cuenta con una tabla con el nombre de las 60 categorías que utilizan para
clasificar los videos (Música, Educación y Ciencia, Hogar, Deportes, etc.).
De cada video se conoce su título, nombre del canal donde fue publicado, duración en
segundos, año de publicación, cantidad de visualizaciones y código de categoría a la que
pertenece el video (1..60).
Realizar un programa que:
A. Invoque a un módulo que lea la información de los videos hasta ingresar un video de
duración -1 ( que no debe procesarse) y devuelva en una estructura de datos adecuada,
para el canal “Paulina Cocina”, la siguiente información:
- Nombre del canal
- Año de publicación del video más reciente
- Cantidad de videos publicados
- Cantidad total de visualizaciones entre todos los videos.
- Detalle con Título, nombre de la categoría y duración de todos los videos con más de
1.000 visualizaciones}

program Amazon;
type
	rango=1..60;
	cadena30=string[30];
	video=record
		titulo:cadena30;
		canal:cadena30;
		duracion:integer;
		aniopub:integer;
		cant:integer;
		categoria:rango;
	end;
	videos=record
		titulo:cadena30;
		categoria:cadena30;
		duracion:integer;
	end;
	
	lista=^nodo;
	nodo=record
		dato:libros;
		sig:lista;
	end;
	
	
	estructura=record;
		nombrecan:cadena30;
		mayoranio:integer;
		cantidad:integer;
		visuliazaciones:integer;
		videosesp:lista;
	end;

	vectortabla:array[rango] of cadena30;



procedure leervideo(var v:video);

begin
	readln(v.duracion);
	if(v.duracion<>-1) then
	begin
		readln(v.titulo);
		readln(v.canal);
		readln(v.aniopub);
		readln(v.cant);
		readln(v.categoria);
	end;
end;



procedure cargarlista(var videosesp:lista; v:video;vt:vectortabla);
var 
	aux:lista;
begin
	new(aux);
	aux^.dato.titulo:=v.titulo;
	aux^.dato.categoria:=vt[v.categoria];
	aux^.dato.duracion:=v.duracion;
	aux^.sig:=videosesp;
	videosesp:=aux;
end;




procedure leerlibros (var e:estructura)

var
	l:libro;
begin
	e.cantidad:=0;
	e.visualizaciones:=0;
	e.mayoranio:=0;
	e.nombrecan:='Paulina cocina';
	leervideo(v);
	while(v.duracion<>-1) do
	begin
		if(v.nombrecan='Paulina cocina') then
		begin
			if(v.aniopub>e.mayoranio) then
				e.mayoranio:=l.aniopub;
			e.cantidad:=e.cantidad+1;
			e.visualizaciones:=e.visualizaciones+l.cant;
			if(l.cant>1000) then
				cargarLista(e.videosesp);
		end;
		leervideo(v);
	end;
			

end;


procedure Informar (e:estructura);
begin
	while(e.videosesp<>nil) do
	begin
		writeln('El video',e.videosesp^.dato.titulo,'del canal',e.nombrecan,'tiene mas de 1000 visualizaciones');
		e.videosesp:=videosesp^.sig;
	end;
end;

var 

	e:estructura;
	vt:vectortabla;


begin
	pri:=nil;
	leervideos(e)
	Informar (e);
end.

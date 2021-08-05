{La tienda de libros Amazon Books está analizando información de algunas editoriales. Para ello,
Amazon cuenta con una tabla con las 35 áreas temáticas utilizadas para clasificar los libros (Arte y Cultura,
Historia, Literatura, etc.).
De cada libro se conoce su título, nombre de la editorial, cantidad de páginas, año de edición, cantidad de
veces que fue vendido y código del área temática (1..35).
Realizar un programa que:
A) Invoque a un módulo que lea la información de los libros hasta ingresar el título “Relato de un
náufrago” (que debe procesarse) y devuelva en una estructura de datos adecuada para la
editorial “Planeta Libros”, con la siguiente información:
- Nombre de la editorial
- Año de edición del libro más antiguo
- Cantidad de libros editados
- Cantidad total de ventas entre todos los libros
- Detalle con título, nombre del área temática y cantidad de páginas de todos los libros con
más de 250 ventas.
B) Invoque a un módulo que reciba la estructura generada en A) e imprima el nombre de la editorial
y el título de cada libro con más de 250 ventas.}
program ejercicio13;
const
	DIMF = 4;
	RDUN = 'relato de un naufrago';
{- Nombre de la editorial
- Año de edición del libro más antiguo
- Cantidad de libros editados
- Cantidad total de ventas entre todos los libros
- Detalle con título, nombre del área temática y cantidad de páginas de todos los libros con
más de 250 ventas.}
type
	cadena50=string[50];
	rango =1..DIMF;
	libro = record
		titulo:cadena50;
		nomeditorial:cadena50;
		cantpaginas:integer;
		anioedicion:1..2021;
		cantventas:integer;
		codarea:rango;
	end;
	
	libros = record	{Detalle con título, nombre del área temática y cantidad de páginas de todos los libros con
más de 250 ventas.}
		titulo:cadena50;
		area:cadena50;
		cantpaginas:integer;
	end;
	lista = ^nodo;
	nodo=record
		dato:libros;
		sig:lista;
	end;
	estructura = record	{estructura de datos adecuada}
		titulo:cadena50;
		nomeditorial:cadena50;
		aniomin:integer;
		cantidadedicion:integer;
		cantpaginas:integer;
		cantventas:integer;
		libros:lista;
	end;
	vtabla = array[rango]of cadena50;
	
{Invoque a un módulo que lea la información de los libros hasta ingresar el título “Relato de un
náufrago” (que debe procesarse) y devuelva en una estructura de datos adecuada para la
editorial “Planeta Libros”, con la siguiente información}
procedure cargartabla(var vt:vtabla);
begin
	vt[1]:='Arte';
	vt[2]:='Cultura';
	vt[3]:='Historia';
	vt[4]:='Literatura';
end;
procedure leerlibro(var l:libro);
begin
writeln('INGRESE EL TITULO DEL LIBRO');
readln(l.titulo);
writeln('INGRESE EL NOMBRE DE LA EDITORIAL');
readln(l.nomeditorial);
writeln('INGRESE LA CANTIDAD DE PAGINAS');
readln(l.cantpaginas);
writeln('INGRESE EL ANIO DE EDICION');
readln(l.anioedicion);
writeln('INGRESE LA CANTIDAD DE VENTAS');
readln(l.cantventas);
writeln('INGRESE EL CODIGO DEL AREA');
readln(l.codarea);
end;


procedure cargarLista(var libros:lista; l:libro; vt:vtabla);
var
	aux:lista;
begin
	new(aux);
	aux^.dato.titulo:= l.titulo;
	aux^.dato.area:=vt[l.codarea];
	aux^.dato.cantpaginas:=l.cantpaginas;
	aux^.sig:=libros;
	libros:=aux;
end;
procedure cargarlibros(var e:estructura; vt:vtabla);
var
	l:libro;
begin
	e.aniomin:=9999;
	e.libros:=nil;
	repeat
	leerlibro(l);
	if(l.nomeditorial = 'planeta libros') then begin
		if(l.anioedicion < e.aniomin) then e.aniomin:=l.anioedicion;
		e.cantidadedicion := e.cantidadedicion +1;
		e.cantventas := e.cantventas+1;
		if(l.cantventas > 250) then cargarLista(e.libros,l,vt);
	end;
	until(l.titulo = RDUN);
	end;
procedure informar(e:estructura);
begin
	while(e.libros <> nil) do begin
			writeln('El libro',e.libros^.dato.titulo,'de la editorial',e.nomeditorial,'tiene mas de 250 ventas');
	e.libros:=e.libros^.sig
	end;
end;

var
	e:estructura;
	vt:vtabla;
begin
	cargartabla(vt);
	cargarlibros(e,vt);
	informar(e);
end.

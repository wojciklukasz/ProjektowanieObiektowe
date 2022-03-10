program BubbleSort;

type
  l = array[1..49] of integer;

procedure gen(var list: l);
var i: integer;
begin
  for i:= 0 to 49 do
  begin
    list[i] := random(100);
  end
end;

procedure sort(var list: l);
var i: integer;
    j: integer;
    temp: integer;
begin
  for i:= 0 to 49 do
  begin
    for j:= 0 to 49 do
    begin
    if( list[i] < list[j] ) then
	begin
	  temp:= list[j];
          list[j]:= list[i];
	  list[i]:= temp;
	end
    end;
  end;
end;

var i: integer;
  list: l;

begin
  Randomize;
  gen(list);
  sort(list);
  for i:= 0 to 49 do
  begin
    writeln(list[i]);
  end;
end.

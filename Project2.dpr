program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var
 i,j,k:longint;
 f,f1:text;
 s,s1:string;
Begin
 assignfile(f,paramstr(1));
 reset(f);
 assignfile(f1,paramstr(2));
 rewrite(f1);
 i:=0;
 while Not EOF(F) Do
 Begin
  i:=i+1;
  Readln(F, s);
  k:=3;
  if (length(s)>4) and (s[1]=' ') and (s[2]=' ') then
  begin
   while (s[k]<>' ') do k:=k+1;
   if ((s[k+1]=' ') or (s[k+1]='(')) and (s[3]<>'"') and (k<>3) then
    begin
     s1:=copy(s,2,k-2);
     writeln(f1,s1);
    end;
  end;
  if (i mod 10000)=0 then writeln(i);
 End;
 writeln(i);
 close(f);
 close(f1)
end.

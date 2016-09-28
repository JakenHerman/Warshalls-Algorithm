with gwar;
with Ada.Text_Io;
procedure gwarshall is

    package iio is new Ada.Text_IO.Integer_IO(Integer);
    use iio;

  package MyFloatIO is new Ada.Text_IO.Float_IO(Float);
  use MyFloatIO;

 procedure FloatPut(X: Float) is
  begin    MyFloatIO.Put(X, 0, 0, 0);  end;

procedure StrPut(X: String) is 
  begin    Ada.Text_IO.Put(X); end;

  procedure IntPut(X: Integer) is
  begin    iio.Put(X); end;

    package ch_gwar is new gwar(Integer, IntPut);	use ch_gwar;
begin
    null;
end gwarshall;

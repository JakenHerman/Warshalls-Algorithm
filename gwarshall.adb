with gwar;
with Ada.Text_Io;
procedure gwarshall is

    subtype s3 is string (1..3);
    subtype Character is string (1 .. 1);
    package iio is new Ada.Text_IO.Integer_IO(Integer);
    use iio;
 
procedure ChrPut(X : Character) is begin Ada.Text_Io.Put(x); end;
procedure StrPut(X: s3) is 
  begin    Ada.Text_IO.Put(X); end;

  procedure IntPut(X: Integer) is
  begin    iio.Put(X); end;

    package d_option_data is new gwar(Character, "d_Option.txt",  ChrPut);	use d_option_data;
    package c_option_data is new gwar(Character, "c_Option.txt", ChrPut); use c_option_data;
    package b_option_data is new gwar(s3, "b_Option.txt", StrPut); use b_option_data;
    package a_option_data is new gwar(Integer, "a_Option.txt", IntPut); use a_option_data;
begin
    declare
end gwarshall;

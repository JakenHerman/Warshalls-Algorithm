with Gwar;
with Ada.Text_Io;
procedure Gwarshall is

   subtype S3 is String (1..3);
   subtype Character is String (1 .. 1);
   package Iio is new Ada.Text_Io.Integer_Io(Integer);
   use Iio;

   procedure Chrput (
         X : Character) is
   begin
      Ada.Text_Io.Put(X);
   end;
   procedure Strput (
         X : S3) is
   begin
      Ada.Text_Io.Put(X);
   end;

   procedure Intput (
         X : Integer) is
   begin
      Iio.Put(X);
   end;

   package D_Option_Data is new Gwar(Character, "d_Option.txt",  Chrput);
   use D_Option_Data;
   package C_Option_Data is new Gwar(Character, "c_Option.txt", Chrput);
   use C_Option_Data;
   package B_Option_Data is new Gwar(S3, "b_Option.txt", Strput);
   use B_Option_Data;
   package A_Option_Data is new Gwar(Integer, "a_Option.txt", Intput);
   use A_Option_Data;
begin
   null;
end Gwarshall;

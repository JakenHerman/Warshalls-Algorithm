--Written by Jaken Herman
with Ada.Text_Io;
use Ada.Text_Io;
with Ada.Text_Io.Text_Streams;
use Ada.Text_Io.Text_Streams;
with Unchecked_Conversion;
with Ada.Unchecked_Deallocation;

package body Gwar is
   subtype S3 is String (1..3);

   package Iio is new Integer_Io(Integer);
   use Iio;

   function Stringtoitem is
   new Unchecked_Conversion(String, Item);

   --Get_Size allows the txt file to specify how much space to allocate.
   function Get_Size return Integer is
      --Filename : String := "D_Option.txt";
      File       : File_Type;
      Line_Count : Integer   := 0;
      Returnsize : Integer;
   begin
      Open(
         File => File,
         Mode => In_File,
         Name => Filename);

      while Line_Count /= 1 loop
         declare
            Line : String := Get_Line (File);
         begin
            Returnsize := Integer'Value(Line);
            Line_Count := 1;
         end;
      end loop;
      Close (File);
      return Returnsize;
   end Get_Size;

   -- Filename : String := "D_Option.txt";
   File : File_Type;

   X_Or_Y : Integer := 99;

   User_X    : S3                                                := (others => ' ');
   User_Y    : S3                                                := (others => ' ');
   User_Size : Integer                                           := Get_Size;
   T_X,
   T_Y       : Integer;
   Exists    : Boolean                                           := False;
   Knt       : Integer                                           := 1;
   M         : array (1 .. User_Size, 1 .. User_Size) of Integer := (others => (others => 0));
   T_Array   : array (1 .. User_Size) of Item;
   L_Array   : array (1 .. User_Size) of S3                      := (others => "   ");

   -- "First" allows the user to create edges between
   -- vertices.
   procedure First (
         X  : in     Item;
         Y  : in     Item;
         Lx : in     String;
         Ly : in     String) is
   begin
      for I in 1 .. Knt loop
         if Exists = False then
            if I = Knt then
               T_X := Knt;
               T_Array(Knt) := X;
               L_Array(Knt) := Lx;
               Knt := Knt + 1;
            elsif T_Array(I) = X then
               Exists := True;
               T_X := I;
            end if;
         end if;
      end loop;
      Exists := False;

      for I in 1 .. Knt loop
         if Exists = False then
            if I = Knt then
               T_Y := Knt;
               T_Array(Knt) := Y;
               L_Array(Knt) := Ly;
               Knt := Knt + 1;
            elsif T_Array(I) = Y then
               Exists := True;
               T_Y := I;
            end if;
         end if;
      end loop;
      Exists := False;

      if T_X = T_Y then
         M(T_X, T_Y) := 0;
      else
         --This coordinate needs to be "1" because the node exists
         M(T_X, T_Y) := 1;
      end if;
   end;

begin
   Open (
      File => File,
      Mode => In_File,
      Name => Filename);

   while not End_Of_File (File) loop
      declare
         Line : String := Get_Line (File);
      begin
         if X_Or_Y = 99 then
            User_Size := Integer'Value(Line);
            X_Or_Y := 0;
         elsif X_Or_Y = 0 then
            User_X := Line;
            X_Or_Y := 1;
         else
            User_Y := Line;
            First(Stringtoitem(User_X),
               Stringtoitem(User_Y), User_X, User_Y);
            X_Or_Y := 0;
         end if;
      end;
   end loop;
   Close (File);


   --print line before adjacency matrix
   New_Line;

   Put("       "); --set up top label
   --Warshall's algorithm
   for I in 1..User_Size loop
      Put(L_Array(I));
      Put("   ");
      for J in 1..User_Size loop
         if M(J,I) > 0 then
            for K in 1..User_Size loop
               M(J,K) := M(J,K) + M(I,K);
            end loop;
         end if;
      end loop;
   end loop;

   --print the adjacency matrix.
   for I in 1..User_Size loop
      New_Line;
      Put(L_Array(I));
      Put("    ");
      for J in 1..User_Size loop
         if M(I,J) > 0 then
            Put("1     ");
         else
            Put("0     ");
         end if;
      end loop;
   end loop;
   --print line after adjacency matrix
   New_Line;
end Gwar;


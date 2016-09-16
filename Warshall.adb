with Ada.Text_Io;
use Ada.Text_Io;
procedure Warshall is
   package Iio is new Ada.Text_Io.Integer_Io(Integer);
   use Iio;

   --Get_Size allows the txt file to specify how much space to allocate.
   function Get_Size return Integer  is
      Filename : String := "win.txt";
      File : Ada.Text_IO.File_Type;
      Line_Count : Integer := 0;
      ReturnSize : Integer;
   begin
      Ada.Text_IO.Open(File => File,
                       Mode => Ada.Text_IO.In_File,
                       Name => Filename);
      while Line_Count /= 1 loop
         declare
            Line : String := Ada.Text_IO.Get_Line (File);
         begin
            ReturnSize := Integer'Value(Line);
            Line_Count := 1;
         end;
      end loop;
      Ada.Text_IO.Close (File);
      return ReturnSize;
   end Get_Size;

   --Create variables  to set up file i/o
   Filename : String := "win.txt";
   File : Ada.Text_IO.File_Type;

   --Control x/y on file read
   X_Or_Y : Integer := 99;

   --Create variables for X and Y to be set by user.
   User_X : Integer;
   User_Y : Integer;
   User_Size : Integer := Get_Size;

   --Integer Array needs conversion to generic type
   M : array (1 .. User_Size, 1 .. User_Size) of Integer := (others => (others => 0));

   -- "First" allows the user to create edges between
   -- vertices.
   procedure First (
                    X : in     Integer;
                    Y : in     Integer) is
   begin
      --This coordinate needs to be "1" because the node exists
      M(X, Y) := 1;
   end;

--begin "Warshall".
begin
   Ada.Text_IO.Open (File => File,
                     Mode => Ada.Text_IO.In_File,
                     Name => Filename);


   while not Ada.Text_IO.End_Of_File (File) loop
      declare
         Line : String := Ada.Text_IO.Get_Line (File);
      begin
         if X_Or_Y = 99 then
            User_Size := Integer'Value(Line);
            X_Or_Y := 0;
         elsif X_Or_Y = 0 then
            User_X := Integer'Value(Line);
            X_Or_Y := 1;
         else
            User_Y := Integer'Value(Line);
            First(User_X, User_Y);
            X_Or_Y := 0;
         end if;
      end;
   end loop;
   Ada.Text_IO.Close (File);

   Put("  "); --set up top label

   --Warshall's algorithm
   for I in 1..User_Size loop
      Put(Integer'Image(I));
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
      Put(Integer'Image(I)); Put(" ");
      for J in 1..User_Size loop
         if M(I,J) > 0 then
            Put("1 ");
         else
            Put("0 ");
         end if;
      end loop;
   end loop;
end;

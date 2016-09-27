with Ada.Text_Io;
use Ada.Text_Io;
procedure Warshall is

   type data_type is (int, str, chr, flt);
   package dtio is new Enumeration_IO(data_type);
   package Iio is new Integer_Io(Integer);
   use Iio;
   use dtio;
   
--10
   --Get_Size allows the txt file to specify how much space to allocate.
   function get_size return Integer  is
      Filename : String := "winchr.txt";
      File : File_Type;
      Line_Count : Integer := 0;
      ReturnSize : Integer;
   begin
      Open(File => File,
                       Mode => In_File,
                       Name => Filename); --20

      while Line_Count /= 1 loop
         declare
            Line : String := Get_Line(File);
         begin
            ReturnSize := Integer'Value(Line);
            Line_Count := 1;
         end;
      end loop;
      Close (File);
      return ReturnSize; --30
   end get_size;

   --Create variables  to set up file i/o
   Filename : String := "winchr.txt";
   File : File_Type;

   --Control x/y on file read
   X_Or_Y : Integer := 99;

   --40 Create variables for X and Y to be set by user.
   --Create variables for X and Y to be set by user.
   User_X : Character;
   User_Y : Character;
   User_Size : Integer := get_size;
   T_X, T_Y: Integer;
   Exists : Boolean := False;
   Knt : Integer := 1;


   -- 50 Integer Array needs conversion to generic type
   M : array (1 .. User_Size, 1 .. User_Size) of Integer := (others => (others => 0));
   T_array : array (1 .. User_Size) of Character;

   -- "First" allows the user to create edges between
   -- vertices.
   procedure First (
                    X : in     Character;
                    Y : in     Character) is
   begin
      for i in 1 .. knt loop
        if Exists = False then
            if I = knt then
                T_X := knt;
                T_Array(Knt) := X;
                Knt := Knt + 1;
            elsif T_Array(I) = X then
                Exists := True;
                T_X := I;
            end if;
        end if;
      end loop;
      Exists := False;
    
      
      for i in 1 .. knt loop
        if Exists = False then
            if I = knt then
                T_Y := knt;
                T_Array(Knt) := Y;
                Knt := Knt + 1;
            elsif T_Array(I) = Y then
                Exists := True;
                T_Y := I;
            end if;
        end if;
      end loop;
      Exists := False;

      --This coordinate needs to be "1" because the node exists
      M(T_X, T_Y) := 1;
   end;

--begin "Warshall".
begin
   Open (File => File,
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
            User_X := Line(1);
            X_Or_Y := 1;
         else
            User_Y := Line(1);
            First(User_X, User_Y);
            X_Or_Y := 0;
         end if;
      end;
   end loop;
   Close (File);

   Put("  "); --set up top label

   --Warshall's algorithm
   for I in 1..User_Size loop
      Put(T_Array(I)); Put(" ");
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
      Put(T_Array(I)); Put(" ");
      for J in 1..User_Size loop
         if M(I,J) > 0 then
            Put("1 ");
         else
            Put("0 ");
         end if;
      end loop;
   end loop;
end;

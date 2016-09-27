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
      Filename : String := "win25.txt";
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
   T_X : Integer;
   T_Y : Integer;
   Exists : Boolean := False;
   Location_X, Location_Y : Integer;
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
      -- 60 does x exist?
      for I in 1 .. User_Size loop
         if Exists = True and I = User_Size then
            Location_X := Knt; --set next location to value
            T_Array(Knt) := X;
         elsif T_Array(I) = X and Exists = False then
            Exists := True;
            Location_X := I;
         elsif T_Array(I) = X and Exists = True then
            return;
         else
            return;
         end if;
      end loop;

      T_X := Location_X;
      Exists := False;
      
      -- does x exist?
      for I in 1 .. User_Size loop
         if Exists = False  and I = User_Size then
            Location_Y := Knt; --set next location to value
            T_Array(Knt) := Y;
         elsif T_Array(I) = Y and Exists = False then
            Exists := True;
            Location_Y := I;
         elsif T_Array(I) = Y and Exists = True then
            return;
         else
            return;
         end if;
      end loop;

      T_Y := Location_Y;    
      Exists := False;

      --does x exist?
      for i in 1 .. user_size loop
         for j in 1 .. user_size+1 loop
             if T_array(j) = X then
                --if so, get location
                T_X := j;
             end if;
         end loop;
         --if not, add to T_array, set location
         T_array(i) := X;
      end loop;

      --does y exist?    
      for i in 1 .. user_size loop
         for j in 1 .. user_size+1 loop
             if T_array(j) = Y then
                --if so, get location
                T_Y := j;
             end if;
         end loop;
         --if not, add to T_array, set location
         T_array(i) := Y;
      end loop;


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
            User_X := line(1);
            X_Or_Y := 1;
         else
            User_Y := line(1);
            First(User_X, User_Y);
            X_Or_Y := 0;
         end if;
      end;
   end loop;
   Close (File);

   Put("  "); --set up top label

   --Warshall's algorithm
   for I in 1..User_Size loop
      Put(T_Array(I));
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

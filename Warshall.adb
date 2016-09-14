with Ada.Text_Io;
use Ada.Text_Io;
procedure Warshall is
   package Iio is new Ada.Text_Io.Integer_Io(Integer);
   use Iio;

   --Integer Array needs conversion to generic type
   M : array (1 .. 8, 1 .. 8) of Integer := ((0, 0, 0, 0, 0, 0, 0, 0),(0, 0, 0, 0, 0, 0, 0, 0),(0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0));


   -- "First" allows the user to create edges between
   -- vertices.
   procedure First (
         X : in     Integer;
         Y : in     Integer) is
   begin
      --This coordinate needs to be "1" because the node exists
      M(X, Y) := 1;
   end;

   --Create variables for X and Y to be set by user.
   User_X : Integer;
   User_Y : Integer;

   --begin "Warshall".
begin

   --Receive user input values.
   for I in 1..8 loop 
      Get(User_X); Get(User_Y);
      First(User_X, User_Y);
   end loop;    
 
   --Warshall's algorithm
   for I in 1..8 loop
      for J in 1..8 loop
         if M(J,I) > 0 then
            for K in 1..8 loop
               M(J,K) := M(J,K) + M(I,K);
            end loop;
         end if;
      end loop;
   end loop;

   --print the adjacency matrix.
   for I in 1..8 loop
      New_Line;
      for J in 1..8 loop
         if M(I,J) > 0 then
            Put("1 ");
         else
            Put("0 ");
         end if;
      end loop;
   end loop;

end;	    

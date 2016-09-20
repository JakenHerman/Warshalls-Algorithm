--Written by Jaken Herman
with Ada.Text_Io;
use Ada.Text_Io;

package body gwar is
   --Get_Size allows the txt file to specify how much space to allocate.
   function get_size return Integer  is
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
            Line : String := Ada.Text_IO.Get_Line(File);
         begin
            ReturnSize := Integer'Value(Line);
            Line_Count := 1;
         end;
      end loop;
      Ada.Text_IO.Close (File);
      return ReturnSize;
   end get_size;

begin
    null;
end gwar;
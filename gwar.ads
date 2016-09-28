generic
   type Item is private;
   --type of array
   Filename : String;
   with procedure Put (
         X : Item);
package Gwar is
   function Get_Size return Integer;
   procedure First (
         X  : in     Item;
         Y  : in     Item;
         Lx : in     String;
         Ly : in     String);
end Gwar;


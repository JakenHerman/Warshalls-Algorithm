GENERIC
   TYPE Item IS PRIVATE; --type of array 
   Filename : String;
   with procedure Put(X: Item);
   PACKAGE gwar IS
      function get_size return Integer;
      procedure First (X : in Item;
                       Y : in Item;
                       lx : in String;
                       ly : in String);
   END gwar;

GENERIC
   TYPE Item IS PRIVATE; --type of array
   size : integer := gwar.get_size; --size of array
   PACKAGE gwar IS
    function get_size return integer;
   END gwar;

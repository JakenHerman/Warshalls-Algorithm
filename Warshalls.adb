WITH Ada.Text_IO;
USE Ada.Text_IO;
PROCEDURE Warshall IS
   PACKAGE Iio IS NEW Ada.Text_Io.Integer_Io(Integer);
   USE Iio;

   --Integer Array needs conversion to generic type
   M : ARRAY (1 .. 8, 1 .. 8) OF Integer := ((0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0), (0, 0, 0, 0, 0, 0, 0, 0));


   -- "First" allows the user to create edges between
   -- vertices.
   PROCEDURE First (
         X : IN     Integer;
         Y : IN     Integer) IS
   BEGIN
      M(X, Y) := 1;
   END;

   --begin "Warshall".
BEGIN

   --Hardcoded values, need user input
   First(1, 2);
   First(2, 4);
   First(3, 2);
   First(2, 3);
   First(5, 6);
   First(5, 7);
   First(7, 8);
   First(8, 7);

   FOR I IN 1..8 LOOP
      FOR J IN 1..8 LOOP
         IF M(J,I) > 0 THEN
            FOR K IN 1..8 LOOP
               M(J,K) := M(J,K) + M(I,K);
            END LOOP;
         END IF;
      END LOOP;
   END LOOP;

   --print the adjacency matrix.
   FOR I IN 1..8 LOOP
      New_Line;
      FOR J IN 1..8 LOOP
         IF M(I,J) > 0 THEN
            IF I /= J THEN
               Put("1 ");
            ELSE
               Put("0 ");
            END IF;
         ELSE
            Put("0 ");
         END IF;
      END LOOP;
   END LOOP;
END;	    

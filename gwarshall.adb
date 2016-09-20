with Ada.Text_Io; use Ada.Text_Io;
with gwar; 
procedure gwarshall is

package iio is new Ada.Text_Io.Integer_IO(Integer); use iio;
package ngwar is new gwar(integer, 100);
use ngwar;

x : integer;

begin
    printsize(x);
    put(x);
end gwarshall;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

package complex_pkg is
type Complex_Type is record
    Real_Part : integer;
    Imaginary_Part : integer;
end record;
end package complex_pkg;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use work.complex_pkg.all;
entity Complex_Operations is
    Port ( A : in Complex_Type;
           B : in Complex_Type;
           Op : in STD_LOGIC_VECTOR (1 downto 0);
           Result : out Complex_Type;
           r1 : out integer;
           r2 : out integer
           );
end Complex_Operations;

architecture Behavioral of Complex_Operations is
begin
    process (A, B, Op)
        variable Temp : Complex_Type;
    begin
        if Op = "00" then
            Temp.Real_Part := A.Real_Part + B.Real_Part;
            Temp.Imaginary_Part := A.Imaginary_Part + B.Imaginary_Part;
        elsif Op = "01" then
            Temp.Real_Part := A.Real_Part - B.Real_Part;
            Temp.Imaginary_Part := A.Imaginary_Part - B.Imaginary_Part;
        elsif Op = "10" then
            Temp.Real_Part := A.Real_Part * B.Real_Part - A.Imaginary_Part * B.Imaginary_Part;
            Temp.Imaginary_Part := A.Real_Part * B.Imaginary_Part + A.Imaginary_Part * B.Real_Part;
        end if;

        Result <= Temp;
        r1 <= Temp.Real_Part;
        r2 <= Temp.Imaginary_Part;
    end process;
end Behavioral;

library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use work.complex_pkg.all;
entity test5 is
end test5;

architecture testbench of test5 is
    component Complex_Operations is
        port(
            A : in Complex_Type;
           B : in Complex_Type;
           Op : in STD_LOGIC_VECTOR (1 downto 0);
           Result : out Complex_Type;
           r1 : out integer;
           r2 : out integer
        );
    end component;

    signal A: Complex_Type;
    signal B : Complex_Type;
    signal Op : STD_LOGIC_VECTOR(1 downto 0);
    signal Result: Complex_Type;
    signal r1 : integer;
    signal r2 : integer;

begin
    cal : Complex_Operations port map (A => A, B => B,Op => Op, Result => Result, r1 => r1, r2 => r2);
    process is
    begin
        A.Real_Part <= 1;
        A.Imaginary_Part <= 2;
        B.Real_Part <= 1;
        B.Imaginary_Part <= 2;
        Op<="00";

        wait for 10 ps;

        A.Real_Part <= 1;
        A.Imaginary_Part <= 2;
        B.Real_Part <= 1;
        B.Imaginary_Part <= 2;
        Op<="01";

        wait for 10 ps;

        A.Real_Part <= 1;
        A.Imaginary_Part <= 2;
        B.Real_Part <= 1;
        B.Imaginary_Part <= 2;
        Op<="10";

        wait for 10 ps;
        wait;

    end process;

end testbench;
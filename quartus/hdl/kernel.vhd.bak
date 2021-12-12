-----------------------------------------------------------------------------------
-- File:        kernel.vhd
-- Date:        20211129
-- Author:      Rafael N. Trozzo
-- Description: Module for getting kernel coefficients
-----------------------------------------------------------------------------------


-----------------------------------------------------------------------------------
-- Package
-----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-----------------------------------------------------------------------------------
-- Entity
-----------------------------------------------------------------------------------
entity kernel is
	port(
		signal coeff_0	: out std_logic_vector(7 downto 0);
		signal coeff_1	: out std_logic_vector(7 downto 0);
		signal coeff_2	: out std_logic_vector(7 downto 0);
		signal coeff_3	: out std_logic_vector(7 downto 0);
		signal coeff_4	: out std_logic_vector(7 downto 0);
		signal coeff_5	: out std_logic_vector(7 downto 0);
		signal coeff_6	: out std_logic_vector(7 downto 0);
		signal coeff_7	: out std_logic_vector(7 downto 0);
		signal coeff_8	: out std_logic_vector(7 downto 0)
    );
end entity kernel;

-----------------------------------------------------------------------------------
-- Architecture
-----------------------------------------------------------------------------------
architecture kernel_arch of kernel is
    signal c0	: integer := 1;
    signal c1	: integer := 1;
    signal c2	: integer := 1;
    signal c3	: integer := 1;
    signal c4	: integer := -8;
    signal c5	: integer := 1;
    signal c6	: integer := 1;
    signal c7	: integer := 1;
    signal c8	: integer := 1;
begin 

    coeff_0 <= std_logic_vector(to_signed(c0, 8));
    coeff_1 <= std_logic_vector(to_signed(c1, 8));
    coeff_2 <= std_logic_vector(to_signed(c2, 8));
    coeff_3 <= std_logic_vector(to_signed(c3, 8));
    coeff_4 <= std_logic_vector(to_signed(c4, 8));
    coeff_5 <= std_logic_vector(to_signed(c5, 8));
    coeff_6 <= std_logic_vector(to_signed(c6, 8));
    coeff_7 <= std_logic_vector(to_signed(c7, 8));
    coeff_8 <= std_logic_vector(to_signed(c8, 8));

end architecture kernel_arch;
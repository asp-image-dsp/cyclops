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
        signal index    : in std_logic_vector(3 downto 0);
		signal coeff_0	: out std_logic_vector(8 downto 0);
		signal coeff_1	: out std_logic_vector(8 downto 0);
		signal coeff_2	: out std_logic_vector(8 downto 0);
		signal coeff_3	: out std_logic_vector(8 downto 0);
		signal coeff_4	: out std_logic_vector(8 downto 0);
		signal coeff_5	: out std_logic_vector(8 downto 0);
		signal coeff_6	: out std_logic_vector(8 downto 0);
		signal coeff_7	: out std_logic_vector(8 downto 0);
		signal coeff_8	: out std_logic_vector(8 downto 0)
    );
end entity kernel;

-----------------------------------------------------------------------------------
-- Architecture
-----------------------------------------------------------------------------------
architecture kernel_arch of kernel is

    -- Edge Detection Coefficients
    signal c0_0	: integer := 1 * 256 / 8;
    signal c0_1	: integer := 1 * 256 / 8;
    signal c0_2	: integer := 1 * 256 / 8;
    signal c0_3	: integer := 1 * 256 / 8;
    signal c0_4	: integer := -8 * 256 / 8;
    signal c0_5	: integer := 1 * 256 / 8;
    signal c0_6	: integer := 1 * 256 / 8;
    signal c0_7	: integer := 1 * 256 / 8;
    signal c0_8	: integer := 1 * 256 / 8;

    -- Wire coefficients
    signal c1_0	: integer := 0;
    signal c1_1	: integer := 0;
    signal c1_2	: integer := 0;
    signal c1_3	: integer := 0;
    signal c1_4	: integer := 1 * 255;
    signal c1_5	: integer := 0;
    signal c1_6	: integer := 0;
    signal c1_7	: integer := 0;
    signal c1_8	: integer := 0;

    -- High boost coefficients
    signal c2_0	: integer := -1 * 256 / 16;
    signal c2_1	: integer := -1 * 256 / 16;
    signal c2_2	: integer := -1 * 256 / 16;
    signal c2_3	: integer := -1 * 256 / 16;
    signal c2_4	: integer := 10 * 256 / 16;
    signal c2_5	: integer := -1 * 256 / 16;
    signal c2_6	: integer := -1 * 256 / 16;
    signal c2_7	: integer := -1 * 256 / 16;
    signal c2_8	: integer := -1 * 256 / 16;

    -- Low pass coefficients
    signal c3_0	: integer := 1 * 256 / 16;
    signal c3_1	: integer := 1 * 256 / 16;
    signal c3_2	: integer := 1 * 256 / 16;
    signal c3_3	: integer := 1 * 256 / 16;
    signal c3_4	: integer := 1 * 256 / 16;
    signal c3_5	: integer := 1 * 256 / 16;
    signal c3_6	: integer := 1 * 256 / 16;
    signal c3_7	: integer := 1 * 256 / 16;
    signal c3_8	: integer := 1 * 256 / 16;

    -- Sobel coefficients
    signal c4_0	: integer := 2 * 255 / 2;
    signal c4_1	: integer := 2 * 255 / 2;
    signal c4_2	: integer := 0;
    signal c4_3	: integer := 2 * 255 / 16;
    signal c4_4	: integer := 0;
    signal c4_5	: integer := -2 * 256 / 2;
    signal c4_6	: integer := 0;
    signal c4_7	: integer := -2 * 256 / 2;
    signal c4_8	: integer := -2 * 256 / 2;

begin 

	update: process (index)
    begin
        if (index = "0000") then
            coeff_0 <= std_logic_vector(to_signed(c0_0, 9));
            coeff_1 <= std_logic_vector(to_signed(c0_1, 9));
            coeff_2 <= std_logic_vector(to_signed(c0_2, 9));
            coeff_3 <= std_logic_vector(to_signed(c0_3, 9));
            coeff_4 <= std_logic_vector(to_signed(c0_4, 9));
            coeff_5 <= std_logic_vector(to_signed(c0_5, 9));
            coeff_6 <= std_logic_vector(to_signed(c0_6, 9));
            coeff_7 <= std_logic_vector(to_signed(c0_7, 9));
            coeff_8 <= std_logic_vector(to_signed(c0_8, 9));    
        elsif (index = "0001") then
            coeff_0 <= std_logic_vector(to_signed(c1_0, 9));
            coeff_1 <= std_logic_vector(to_signed(c1_1, 9));
            coeff_2 <= std_logic_vector(to_signed(c1_2, 9));
            coeff_3 <= std_logic_vector(to_signed(c1_3, 9));
            coeff_4 <= std_logic_vector(to_signed(c1_4, 9));
            coeff_5 <= std_logic_vector(to_signed(c1_5, 9));
            coeff_6 <= std_logic_vector(to_signed(c1_6, 9));
            coeff_7 <= std_logic_vector(to_signed(c1_7, 9));
            coeff_8 <= std_logic_vector(to_signed(c1_8, 9));
        elsif (index = "0010") then
            coeff_0 <= std_logic_vector(to_signed(c2_0, 9));
            coeff_1 <= std_logic_vector(to_signed(c2_1, 9));
            coeff_2 <= std_logic_vector(to_signed(c2_2, 9));
            coeff_3 <= std_logic_vector(to_signed(c2_3, 9));
            coeff_4 <= std_logic_vector(to_signed(c2_4, 9));
            coeff_5 <= std_logic_vector(to_signed(c2_5, 9));
            coeff_6 <= std_logic_vector(to_signed(c2_6, 9));
            coeff_7 <= std_logic_vector(to_signed(c2_7, 9));
            coeff_8 <= std_logic_vector(to_signed(c2_8, 9));
        elsif (index = "0011") then
            coeff_0 <= std_logic_vector(to_signed(c3_0, 9));
            coeff_1 <= std_logic_vector(to_signed(c3_1, 9));
            coeff_2 <= std_logic_vector(to_signed(c3_2, 9));
            coeff_3 <= std_logic_vector(to_signed(c3_3, 9));
            coeff_4 <= std_logic_vector(to_signed(c3_4, 9));
            coeff_5 <= std_logic_vector(to_signed(c3_5, 9));
            coeff_6 <= std_logic_vector(to_signed(c3_6, 9));
            coeff_7 <= std_logic_vector(to_signed(c3_7, 9));
            coeff_8 <= std_logic_vector(to_signed(c3_8, 9));
        elsif (index = "0100") then
            coeff_0 <= std_logic_vector(to_signed(c4_0, 9));
            coeff_1 <= std_logic_vector(to_signed(c4_1, 9));
            coeff_2 <= std_logic_vector(to_signed(c4_2, 9));
            coeff_3 <= std_logic_vector(to_signed(c4_3, 9));
            coeff_4 <= std_logic_vector(to_signed(c4_4, 9));
            coeff_5 <= std_logic_vector(to_signed(c4_5, 9));
            coeff_6 <= std_logic_vector(to_signed(c4_6, 9));
            coeff_7 <= std_logic_vector(to_signed(c4_7, 9));
            coeff_8 <= std_logic_vector(to_signed(c4_8, 9));
        end if;
    end process update;

end architecture kernel_arch;

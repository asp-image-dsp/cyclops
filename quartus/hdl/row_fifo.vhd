-----------------------------------------------------------------------------------
-- File:        row_fifo.vhd
-- Date:        20211128
-- Author:      Lucas A. Kammann and Rafael N. Trozzo
-- Description: Row FIFO
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
-- Package
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
-- Entity
-----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity row_fifo is
    port (
        -- Input ports
        write_address   : in std_logic_vector (9 downto 0);
        write_clock     : in std_logic;
        write_pixel     : in std_logic_vector (7 downto 0);
        read_address    : in std_logic_vector (9 downto 0);
        read_clock      : in std_logic;
        fifo_roll       : in std_logic;

        -- Output ports
        read_pixel_0    : out std_logic_vector (7 downto 0);
        read_pixel_1    : out std_logic_vector (7 downto 0);
        read_pixel_2    : out std_logic_vector (7 downto 0)
    );
end entity row_fifo;

-----------------------------------------------------------------------------------
-- Architecture
-----------------------------------------------------------------------------------

architecture row_fifo_arch of row_fifo is
begin
end architecture row_fifo_arch;
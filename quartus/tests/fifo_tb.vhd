-----------------------------------------------------------------------------------
-- File:        fifo_tb.vhd
-- Date:        20211128
-- Author:      Lucas A. Kammann
-- Description: Testbench for FIFO controller module
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
-- Entity
-----------------------------------------------------------------------------------
library work;
library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;

entity fifo_tb is
end entity fifo_tb;

-----------------------------------------------------------------------------------
-- Architecture
-----------------------------------------------------------------------------------
architecture fifo_tb_arch of fifo_tb is
    signal roll         : std_logic := '0';
    signal reset        : std_logic := '1';
    signal index_0      : std_logic_vector (1 downto 0);
    signal index_1      : std_logic_vector (1 downto 0);
    signal index_2      : std_logic_vector (1 downto 0);
    signal index_3      : std_logic_vector (1 downto 0);
begin
    -- Create an instance of the fifo controller
    fifocamera: entity work.fifo_controller(fifo_controller_arch)
        port map (
            roll => roll,
            reset => reset,
            index_0 => index_0,
            index_1 => index_1,
            index_2 => index_2,
            index_3 => index_3
        );	 

    -- Simulate
    reset <= '0' after 100 ns;
    roll <= not roll after 50 ns;
end architecture fifo_tb_arch;
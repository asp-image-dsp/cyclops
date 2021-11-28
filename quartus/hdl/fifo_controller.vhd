-----------------------------------------------------------------------------------
-- File:        fifo_controller.vhd
-- Date:        20211128
-- Author:      Lucas A. Kammann and Rafael N. Trozzo
-- Description: FIFO Controller
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

entity fifo_controller is
    port (
        -- Input ports
        roll    : in std_logic;
        reset   : in std_logic;

        -- Output ports
        index_0 : out std_logic_vector (1 downto 0);
        index_1 : out std_logic_vector (1 downto 0);
        index_2 : out std_logic_vector (1 downto 0);
        index_3 : out std_logic_vector (1 downto 0)
    );
end entity fifo_controller;

-----------------------------------------------------------------------------------
-- Architecture
-----------------------------------------------------------------------------------

architecture fifo_controller_arch of fifo_controller is
begin
end architecture fifo_controller_arch;
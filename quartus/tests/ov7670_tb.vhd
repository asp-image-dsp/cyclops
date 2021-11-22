-----------------------------------------------------------------------------------
-- File:        ov7670_tb.vhd
-- Date:        20211121
-- Author:      Rafael N. Trozzo
-- Description: Testbench for OV7670 camera capturing module
-----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;

-----------------------------------------------------------------------------------
-- Types
-----------------------------------------------------------------------------------	   
package my_package is	
	type buff is array (0 to 3) of std_logic_vector(7 downto 0);-- integer range 0 to 255;
end my_package;    	  

library work;
use work.my_package.all; 

library ieee;
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;

-----------------------------------------------------------------------------------
-- Entity
-----------------------------------------------------------------------------------
entity ov7670_tb is
end entity ov7670_tb;

-----------------------------------------------------------------------------------
-- Architecture
-----------------------------------------------------------------------------------
architecture ov7670_tb_arc of ov7670_tb is
    signal vsync        : std_logic := '0';
    signal pclk         : std_logic := '0';
    signal href         : std_logic := '0';
    signal d            : std_logic_vector (7 downto 0) := "00000000";
    signal data         : buff;

	
    procedure set(signal sig : inout std_logic) is
    begin
        sig <= '1';
        wait for 1 ns;
    end procedure;

    procedure clear (signal sig : inout std_logic) is
    begin
        sig <= '0';
        wait for 1 ns;
    end procedure;
        
    -- Make a pulse of the given signal
    procedure pulse (signal sig : inout std_logic) is 
    begin
        set(sig);
        wait for 50 ns;
        clear(sig);
    end procedure;
	
begin
    
    -- Create an instance of the OV7670 capture module
    module: entity work.ov7670_pixel_capture(ov7670_pixel_capture_arch)
        port map (
            vsync => vsync,
            pclk => pclk,
            href => href,
            d => d
        );

    update_data: process is
    begin
        clear(pclk);
        pulse(vsync); -- VSYNC pulse
        clear(href);
        for row in 0 to 2 loop
            set(href);
            for col in 0 to 3 loop -- 8 columns, each col gives 2 pixels
                for byte in 0 to 3 loop
                    d <=  std_logic_vector(to_unsigned(row * 100 + col * 10 + byte + 1, 8)); -- data(byte);
                    wait for 20 ns;      -- PCLK = 25MHz
                    pclk <= '1';        
                    wait for 20 ns;
                    pclk <= '0';      
                end loop;
            end loop;
            clear(href);
            wait for 20 ns;      -- PCLK = 25MHz
            pclk <= '1';        
            wait for 20 ns;
            pclk <= '0';
        end loop;    
    end process update_data;
end architecture ov7670_tb_arc;
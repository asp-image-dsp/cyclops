-----------------------------------------------------------------------------------
-- File:        ov7670_pixel_capture.vhd
-- Date:        20211117
-- Author:      Lucas A. Kammann and Rafael N. Trozzo
-- Description: Module for capturing the pixel data of an OV7670 camera
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

entity ov7670_pixel_capture is
    port (
        signal vsync    : in std_logic; 
        signal href     : in std_logic;
        signal pclk     : in std_logic;
        signal d        : in std_logic_vector (7 downto 0);

        signal y        : out std_logic_vector (7 downto 0);
        signal u        : out std_logic_vector (7 downto 0);
        signal v        : out std_logic_vector (7 downto 0);
        signal pready   : out std_logic
    );
end entity ov7670_pixel_capture;

-----------------------------------------------------------------------------------
-- Architecture
-----------------------------------------------------------------------------------

architecture ov7670_pixel_capture_arch of ov7670_pixel_capture is
    signal byte_selector    : integer range 0 to 3;
    signal prev_u           : std_logic_vector (7 downto 0) := "00000000";
    signal prev_v           : std_logic_vector (7 downto 0) := "00000000";
    signal prev_y0          : std_logic_vector (7 downto 0) := "00000000";
    signal prev_y1          : std_logic_vector (7 downto 0) := "00000000";
    signal curr_u           : std_logic_vector (7 downto 0) := "00000000";
    signal curr_y0          : std_logic_vector (7 downto 0) := "00000000";
begin
    
    capture: process (href, pclk)
    begin

        if rising_edge(href) then
            byte_selector <= 0;
        end if;		   

        -- Data capture to buffer
        if rising_edge(pclk) then
            
            -- Capture data if valid
            if (href = '1') then
                if (byte_selector = 0) then
                    curr_u <= d;
                    byte_selector <= 1;
                elsif (byte_selector = 1) then
                    curr_y0 <= d;
                    byte_selector <= 2;
                elsif (byte_selector = 2) then
                    prev_v <= d;
                    byte_selector <= 3;
                elsif (byte_selector = 3) then
                    prev_y1 <= d;
                    byte_selector <= 0;
                end if;
            end if;
        
        end if;

        -- Update output from buffer
        if falling_edge(pclk) then
            if (href = '1') then
                -- Divide update frequency by 2
                if ( (byte_selector mod 2) = 1) then                
                    if (byte_selector = 1) then
                        u <= prev_u;
                        v <= prev_v;
                        y <= prev_y0;
                    elsif (byte_selector = 3) then
                        y <= prev_y1;	
                        prev_u <= curr_u;
                        prev_y0 <= curr_y0; 
                    end if;
                    -- Notify output is ready
				    pready <= '0';
                else 
                    pready <= '1';
                end if;

            end if;
        end if;

    end process capture;

    
end architecture ov7670_pixel_capture_arch;
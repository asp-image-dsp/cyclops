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
        signal paddress : out std_logic_vector (18 downto 0);
        signal pready   : out std_logic
    );
end entity ov7670_pixel_capture;

-----------------------------------------------------------------------------------
-- Architecture
-----------------------------------------------------------------------------------

architecture ov7670_pixel_capture_arch of ov7670_pixel_capture is
    signal byte_selector	: std_logic_vector (1 downto 0) := "00";
    signal buffer_u			: std_logic_vector (7 downto 0) := "00000000";
    signal buffer_v			: std_logic_vector (7 downto 0) := "00000000";
    signal buffer_y0			: std_logic_vector (7 downto 0) := "00000000";
    signal buffer_y1			: std_logic_vector (7 downto 0) := "00000000";

    signal pixel_address    : std_logic_vector (18 downto 0);
    signal pixel_ready      : std_logic;
    signal pixel_init       : std_logic;
begin
    
	 
    capture: process (pclk)
    begin

        -- When the free running pixel clock has a rising edge
        -- run the decoding process for the next incoming byte
        if rising_edge(pclk) then

            -- In the blanking zone of the vertical signal reset the pixel address
            if (vsync = '1') then
                pixel_address <= std_logic_vector(to_unsigned(0, 19));
                pixel_init <= '0';
            elsif ( (href = '1') and (byte_selector(0) = '0') ) then
                pixel_address <= std_logic_vector(unsigned(pixel_address) + 1);
            end if;
				
				if ((vsync = '0') and (byte_selector(0) = '0')) then
--                pixel_address <= std_logic_vector(unsigned(pixel_address) + 1);				
				end if;

            -- Verify the data is valid (we're in a row)
            if (href = '1') then
                if (byte_selector = "00") then
                    -- Generate buffered output
                    u <= buffer_u;
                    v <= buffer_v;
                    y <= buffer_y0;
                    -- Save U component in buffer
                    buffer_u <= d;
                elsif (byte_selector = "01") then
                    -- Save Y component in buffer
                    buffer_y0 <= d;
                elsif (byte_selector = "10") then
                    -- Generate buffered output (uses same U and V as before)
                    y <= buffer_y1;
                    -- Save V component in buffer
                    buffer_v <= d;
                elsif (byte_selector = "11") then
                    -- Save Y component in buffer
                    buffer_y1 <= d;
                    -- If this is the first loop, set the flag
                    if (pixel_init = '0') then
                        pixel_init <= '1';
                    end if;
                end if;
                byte_selector <= std_logic_vector(unsigned(byte_selector) + 1);
            else
                byte_selector <= "00";
            end if;

        end if;
        
    end process capture;
	 
	 
     -- Map the internal signals to the outputs (to be read)
	  paddress <= pixel_address;
	  pready <= pixel_ready;

	  -- Generate the pixel ready clock
	  pixel_ready <= byte_selector(0) and href and pixel_init;
	  
end architecture ov7670_pixel_capture_arch;
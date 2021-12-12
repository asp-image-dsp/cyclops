-- megafunction wizard: %LPM_MUX%
-- GENERATION: STANDARD
-- VERSION: WM1.0
-- MODULE: LPM_MUX 

-- ============================================================
-- File Name: kernel_mux.vhd
-- Megafunction Name(s):
-- 			LPM_MUX
--
-- Simulation Library Files(s):
-- 			lpm
-- ============================================================
-- ************************************************************
-- THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
--
-- 20.1.1 Build 720 11/11/2020 SJ Lite Edition
-- ************************************************************


--Copyright (C) 2020  Intel Corporation. All rights reserved.
--Your use of Intel Corporation's design tools, logic functions 
--and other software and tools, and any partner logic 
--functions, and any output files from any of the foregoing 
--(including device programming or simulation files), and any 
--associated documentation or information are expressly subject 
--to the terms and conditions of the Intel Program License 
--Subscription Agreement, the Intel Quartus Prime License Agreement,
--the Intel FPGA IP License Agreement, or other applicable license
--agreement, including, without limitation, that your use is for
--the sole purpose of programming logic devices manufactured by
--Intel and sold by Intel or its authorized distributors.  Please
--refer to the applicable agreement for further details, at
--https://fpgasoftware.intel.com/eula.


LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY lpm;
USE lpm.lpm_components.all;

ENTITY kernel_mux IS
	PORT
	(
		data0x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data1x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		sel		: IN STD_LOGIC ;
		result		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
END kernel_mux;


ARCHITECTURE SYN OF kernel_mux IS

--	type STD_LOGIC_2D is array (NATURAL RANGE <>, NATURAL RANGE <>) of STD_LOGIC;

	SIGNAL sub_wire0	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire1	: STD_LOGIC_2D (1 DOWNTO 0, 7 DOWNTO 0);
	SIGNAL sub_wire2	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire3	: STD_LOGIC ;
	SIGNAL sub_wire4	: STD_LOGIC_VECTOR (0 DOWNTO 0);
	SIGNAL sub_wire5	: STD_LOGIC_VECTOR (7 DOWNTO 0);

BEGIN
	sub_wire2    <= data0x(7 DOWNTO 0);
	sub_wire0    <= data1x(7 DOWNTO 0);
	sub_wire1(1, 0)    <= sub_wire0(0);
	sub_wire1(1, 1)    <= sub_wire0(1);
	sub_wire1(1, 2)    <= sub_wire0(2);
	sub_wire1(1, 3)    <= sub_wire0(3);
	sub_wire1(1, 4)    <= sub_wire0(4);
	sub_wire1(1, 5)    <= sub_wire0(5);
	sub_wire1(1, 6)    <= sub_wire0(6);
	sub_wire1(1, 7)    <= sub_wire0(7);
	sub_wire1(0, 0)    <= sub_wire2(0);
	sub_wire1(0, 1)    <= sub_wire2(1);
	sub_wire1(0, 2)    <= sub_wire2(2);
	sub_wire1(0, 3)    <= sub_wire2(3);
	sub_wire1(0, 4)    <= sub_wire2(4);
	sub_wire1(0, 5)    <= sub_wire2(5);
	sub_wire1(0, 6)    <= sub_wire2(6);
	sub_wire1(0, 7)    <= sub_wire2(7);
	sub_wire3    <= sel;
	sub_wire4(0)    <= sub_wire3;
	result    <= sub_wire5(7 DOWNTO 0);

	LPM_MUX_component : LPM_MUX
	GENERIC MAP (
		lpm_size => 2,
		lpm_type => "LPM_MUX",
		lpm_width => 8,
		lpm_widths => 1
	)
	PORT MAP (
		data => sub_wire1,
		sel => sub_wire4,
		result => sub_wire5
	);



END SYN;

-- ============================================================
-- CNX file retrieval info
-- ============================================================
-- Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone IV E"
-- Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
-- Retrieval info: PRIVATE: new_diagram STRING "1"
-- Retrieval info: LIBRARY: lpm lpm.lpm_components.all
-- Retrieval info: CONSTANT: LPM_SIZE NUMERIC "2"
-- Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_MUX"
-- Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "8"
-- Retrieval info: CONSTANT: LPM_WIDTHS NUMERIC "1"
-- Retrieval info: USED_PORT: data0x 0 0 8 0 INPUT NODEFVAL "data0x[7..0]"
-- Retrieval info: USED_PORT: data1x 0 0 8 0 INPUT NODEFVAL "data1x[7..0]"
-- Retrieval info: USED_PORT: result 0 0 8 0 OUTPUT NODEFVAL "result[7..0]"
-- Retrieval info: USED_PORT: sel 0 0 0 0 INPUT NODEFVAL "sel"
-- Retrieval info: CONNECT: @data 1 0 8 0 data0x 0 0 8 0
-- Retrieval info: CONNECT: @data 1 1 8 0 data1x 0 0 8 0
-- Retrieval info: CONNECT: @sel 0 0 1 0 sel 0 0 0 0
-- Retrieval info: CONNECT: result 0 0 8 0 @result 0 0 8 0
-- Retrieval info: GEN_FILE: TYPE_NORMAL kernel_mux.vhd TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL kernel_mux.inc FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL kernel_mux.cmp FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL kernel_mux.bsf TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL kernel_mux_inst.vhd FALSE
-- Retrieval info: LIB_FILE: lpm

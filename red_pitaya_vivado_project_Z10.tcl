################################################################################
# Vivado tcl script for building RedPitaya FPGA in non project mode
#
# Usage:
# vivado -mode batch -source red_pitaya_vivado_project_Z10.tcl
################################################################################

# set prj_name [lindex $argv 0]
# puts "Project name: $prj_name"
# cd prj/$prj_name
# cd prj/$::argv 0

################################################################################
# define paths
################################################################################

set path_brd brd
set path_rtl rtl
set path_ip  ip
set path_bd  project/redpitaya.srcs/sources_1/bd/system/hdl
set path_sdc sdc

################################################################################
# list board files
################################################################################

set_param board.repoPaths [list $path_brd]

################################################################################
# setup an in memory project
################################################################################

set part xc7z010clg400-1

create_project -part $part -force redpitaya ./project

################################################################################
# create PS BD (processing system block design)
################################################################################

# file was created from GUI using "write_bd_tcl -force ip/systemZ10.tcl"
# create PS BD
source                            $path_ip/systemZ10.tcl

# generate SDK files
generate_target all [get_files    system.bd]

################################################################################
# read files:
# 1. RTL design sources
# 2. IP database files
# 3. constraints
################################################################################

add_files                         $path_rtl
add_files                         $path_bd


add_files -fileset constrs_1      $path_sdc/red_pitaya.xdc
add_files -fileset constrs_1      $path_sdc/red_pitaya_clock.xdc

################################################################################
# create user generated BD
################################################################################

source                            ./user_bd.tcl

################################################################################
# start gui
################################################################################

# import_files -force

set_property top red_pitaya_top [current_fileset]

update_compile_order -fileset sources_1

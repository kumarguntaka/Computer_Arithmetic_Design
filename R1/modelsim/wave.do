onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /bwm_tb/x
add wave -noupdate -expand -group tb /bwm_tb/y
add wave -noupdate -expand -group tb /bwm_tb/xval
add wave -noupdate -expand -group tb /bwm_tb/yval
add wave -noupdate -expand -group tb /bwm_tb/p
add wave -noupdate -expand -group tb /bwm_tb/pval
add wave -noupdate -expand -group tb /bwm_tb/check
add wave -noupdate -expand -group tb /bwm_tb/i
add wave -noupdate -expand -group tb /bwm_tb/j
add wave -noupdate -expand -group tb /bwm_tb/num_correct
add wave -noupdate -expand -group tb /bwm_tb/num_wrong
add wave -noupdate -expand -group DUT /bwm_tb/mult_instance/x
add wave -noupdate -expand -group DUT /bwm_tb/mult_instance/y
add wave -noupdate -expand -group DUT /bwm_tb/mult_instance/p
add wave -noupdate -expand -group DUT -group wires /bwm_tb/mult_instance/one
add wave -noupdate -expand -group DUT -group wires /bwm_tb/mult_instance/t1
add wave -noupdate -expand -group DUT -group wires /bwm_tb/mult_instance/t2
add wave -noupdate -expand -group DUT -group wires /bwm_tb/mult_instance/t3
add wave -noupdate -expand -group DUT -group wires /bwm_tb/mult_instance/t4
add wave -noupdate -expand -group DUT -group wires /bwm_tb/mult_instance/t5
add wave -noupdate -expand -group DUT -group wires /bwm_tb/mult_instance/t6
add wave -noupdate -expand -group DUT -group wires /bwm_tb/mult_instance/t7
add wave -noupdate -expand -group DUT -group wires /bwm_tb/mult_instance/t8
add wave -noupdate -expand -group DUT -group wires /bwm_tb/mult_instance/t9
add wave -noupdate -expand -group DUT -group wires /bwm_tb/mult_instance/t10
add wave -noupdate -expand -group DUT -group wires /bwm_tb/mult_instance/t11
add wave -noupdate -expand -group DUT -group wires /bwm_tb/mult_instance/t12
add wave -noupdate -expand -group DUT -group wires /bwm_tb/mult_instance/t13
add wave -noupdate -expand -group DUT -group wires /bwm_tb/mult_instance/t14
add wave -noupdate -expand -group DUT -group wires /bwm_tb/mult_instance/t15
add wave -noupdate -expand -group DUT -group wires /bwm_tb/mult_instance/t16
add wave -noupdate -expand -group DUT -group wires /bwm_tb/mult_instance/t17
add wave -noupdate -expand -group DUT -group wires /bwm_tb/mult_instance/t18
add wave -noupdate -expand -group DUT -group wires /bwm_tb/mult_instance/t19
add wave -noupdate -expand -group DUT -group wires /bwm_tb/mult_instance/t20
add wave -noupdate -expand -group DUT -group wires /bwm_tb/mult_instance/t21
add wave -noupdate -expand -group DUT -group wires /bwm_tb/mult_instance/t22
add wave -noupdate -expand -group DUT -group wires /bwm_tb/mult_instance/t23
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {30 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 226
configure wave -valuecolwidth 65
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {649 ps}

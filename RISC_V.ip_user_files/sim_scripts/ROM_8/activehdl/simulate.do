onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+ROM_8 -L dist_mem_gen_v8_0_13 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.ROM_8 xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {ROM_8.udo}

run -all

endsim

quit -force

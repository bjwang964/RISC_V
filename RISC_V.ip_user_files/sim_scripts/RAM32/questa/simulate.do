onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib RAM32_opt

do {wave.do}

view wave
view structure
view signals

do {RAM32.udo}

run -all

quit -force

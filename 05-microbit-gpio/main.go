package main

import (
	"machine"
	"time"
)

const led = machine.P1

func main() {
	led.Configure(machine.PinConfig{Mode: machine.PinOutput})
	for {
		led.Low()
		time.Sleep(time.Second)

		led.High()
		time.Sleep(time.Second)
	}
}

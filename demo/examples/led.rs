#![no_std]
#![no_main]

use cortex_m_rt::{
    entry,
    exception,
    ExceptionFrame,
};

use panic_halt as _;
use stm32f4xx_hal::{
    pac,
    gpio::GpioExt,
};

#[entry]
unsafe fn main() -> ! {
    // device peripherals
    let dp = pac::Peripherals::take().unwrap();

    // GPIO PBx pins
    let gpiob = dp.GPIOB.split();

    // set LED pins into push-pull output mode
    let mut led1_output = gpiob.pb0.into_push_pull_output();
    let mut led2_output = gpiob.pb7.into_push_pull_output();
    let mut led3_output = gpiob.pb14.into_push_pull_output();

    // toggle LEDs
    led1_output.set_high();
    led2_output.set_high();
    led3_output.set_high();

    // avoid end of execution through an infinite loop
    loop {}
}

#[exception]
unsafe fn HardFault(_ef: &ExceptionFrame) -> ! {
    loop {}
}


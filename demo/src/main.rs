#![no_std]
#![no_main]

use cortex_m_rt::{
    entry,
    exception,
    ExceptionFrame,
};

use panic_halt as _;
use cortex_m::asm;
use stm32f4xx_hal as _;

#[entry]
unsafe fn main() -> ! {
    asm::nop();

    loop {}
}

#[exception]
unsafe fn HardFault(_ef: &ExceptionFrame) -> ! {
    loop {}
}


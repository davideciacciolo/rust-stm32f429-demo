use std::env;
use std::error::Error;
use std::fs::File;
use std::io::Write;
use std::path::PathBuf;

fn main() -> Result<(), Box<dyn Error>> {
    // build directory for this crate
    let out_dir = PathBuf::from(env::var_os("OUT_DIR").unwrap());

    // extend the library search path
    println!("cargo:rustc-link-search={}", out_dir.display());

    // put `memory.x` in the build directory
    File::create(out_dir.join("memory.x"))?
          .write_all(include_bytes!("memory.x"))?;

    // the build script should be re-run if `memory.x` changes
    println!("cargo:rerun-if-changed=memory.x");

    Ok(())
}


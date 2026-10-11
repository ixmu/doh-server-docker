# ![DoH server (and ODoH - Oblivious DoH server)](logo.png)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Rust](https://img.shields.io/badge/rust-%23000000.svg?style=flat&logo=rust&logoColor=white)](https://www.rust-lang.org/)
[![Crates.io](https://img.shields.io/crates/v/doh-proxy.svg)](https://crates.io/crates/doh-proxy)

A fast and secure DoH (DNS-over-HTTPS) and ODoH (Oblivious DoH) server.

`doh-proxy` is written in Rust, and has been battle-tested in production since February 2018. It doesn't do DNS resolution on its own, but can sit in front of any DNS resolver in order to augment it with DoH support.
# Crypto Price Scripts

This repository contains a collection of shell scripts for fetching and displaying cryptocurrency data from various public APIs. The scripts are primarily focused on the South African market, with many fetching prices in South African Rand (ZAR).

## Scripts

Here is a breakdown of the scripts in this repository:

*   **`cryptoprice.sh`**: Fetches a wide range of cryptocurrency prices (BTC, ETH, LTC, etc.) against USD and BTC from the CryptoCompare API. It also fetches the BTC/ZAR price from VALR and the USD/ZAR exchange rate from Open Exchange Rates. The script saves the data to `cryptoprice.data` and creates monthly backups of this file.

*   **`cryptopricehosted.sh`**: A version of `cryptoprice.sh` intended for use in a specific hosted environment. It fetches similar data but does not include the backup functionality.

*   **`btcprice-sat.sh`**: A detailed script that generates tweet-sized updates about the Bitcoin market in South Africa. It fetches the BTC/ZAR price from multiple local exchanges (VALR, Luno, Cape Crypto, etc.), calculates an average price, and determines the value of 1 ZAR in satoshis. It also includes information on Bitcoin network fees and circulating supply.

*   **`btcstats.sh`**: A simple script that displays the current Bitcoin block height and total coin supply.

*   **`adareward.sh`**: A script for tracking Cardano (ADA) staking rewards. It uses the Blockfrost API to get information about the latest epoch and the status of specific staking accounts.

*   **`usdc-usdt-price-zar.sh`**: Fetches the price of the USDC and USDT stablecoins in ZAR from the VALR and Luno exchanges.

## Dependencies

To run these scripts, you will need the following command-line tools installed:

*   `curl`: For making HTTP requests to the various APIs.
*   `jq`: A lightweight and flexible command-line JSON processor.
*   `bc`: An arbitrary precision calculator language, used for floating-point math.

## Usage

The scripts can be run from the command line. For example:

```bash
./cryptoprice.sh
```

Some scripts, like `btcprice-sat.sh`, take arguments. Use the `-h` or `H` flag to see the available options:

```bash
./btcprice-sat.sh H
```

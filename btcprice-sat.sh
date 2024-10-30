#!/bin/bash

# Check if an argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 [B|C|H]"
    exit 1
fi

case $1 in
    B)
        SUPHOST=$1
        ;;
    C)
        SUPHOST=$1
        ;;
    H)
        echo "Usage: $0 [B|C|H]"
        echo ""
        echo "Options:"
        echo "  B     Get supply from bitcoinenplorer.org"
        echo "  C     Get supply from coingecho.com"
        echo "  H     Show this help message."
        exit 1
        ;;
    *)
        echo "Invalid option: $1"
        echo "Use 'H' to see available options."
        exit 1
        ;;
esac

export LC_NUMERIC="en_US.UTF-8"
echo "<=== Tweet 1 ===>"
echo "#bitcoin #btc in #SouthAfrica"
echo ""
# Blocks and Supply 
# BTC RPC Explorer
# CURL_QRY="-s https://bitcoinexplorer.org/api/blocks/tip"
# CURL_OUT=$(curl $CURL_QRY)
# BLOCKS=$(echo $CURL_OUT | jq '.height | tonumber')
# Mempool.space
CURL_QRY="-s https://mempool.space/api/blocks/tip/height"
CURL_OUT=$(curl $CURL_QRY)
BLOCKS=$(echo $CURL_OUT | jq '. | tonumber')
printf -v BLOCKSSTR "Blocks: %d\n" "$BLOCKS"
echo $BLOCKSSTR
if [ "$SUPHOST" = "B" ]; then
    CURL_QRY="-s https://bitcoinexplorer.org/api/blockchain/coins"
    CURL_OUT=$(curl $CURL_QRY)
    SUPPLY=$(echo $CURL_OUT | jq '.supply | tonumber')
fi
if [ "$SUPHOST" = "C" ]; then
    CURL_QRY="-s --request GET --url https://api.coingecko.com/api/v3/coins/bitcoin --header 'accept: application/json' --header 'x-cg-demo-api-key: CG-ct1DQcgxdyp2tqKUC1S4CE16'"
    CURL_OUT=$(curl $CURL_QRY)
    SUPPLY=$(echo $CURL_OUT | jq '.market_data.circulating_supply | tonumber')
fi
printf -v SUPPLYSTR "Supply: %.8f\n" "$SUPPLY"
echo $SUPPLYSTR
echo ""
# VALR
CURL_QRY="-s --location --request GET https://api.valr.com/v1/public/BTCZAR/marketsummary"
CURL_OUT=$(curl $CURL_QRY)
VALR_PRICE=$(echo $CURL_OUT | jq '.lastTradedPrice | tonumber')
# CURL_QRY="-s --location --request GET https://api.valr.com/v1/public/ADABTC/marketsummary"
# CURL_OUT=$(curl $CURL_QRY)
# VALR_ADA_PRICE=$(echo $CURL_OUT | jq '.lastTradedPrice | tonumber')
# echo "<=== VALR - @VALRdotcom ===>"
# echo $VALR_PRICE
# Luno
CURL_QRY="-s https://api.mybitx.com/api/1/ticker?pair=XBTZAR"
CURL_OUT=$(curl $CURL_QRY)
LUNO_PRICE=$(echo $CURL_OUT | jq '.last_trade | tonumber')
CURL_QRY="-s https://api.mybitx.com/api/1/ticker?pair=ADAZAR"
CURL_OUT=$(curl $CURL_QRY)
LUNO_ADA_PRICE=$(echo $CURL_OUT | jq '.last_trade | tonumber')
LUNO_PRICE=${LUNO_PRICE:-0}
# echo "<=== LUNO - @LunoGlobal ===>" 
# echo $LUNO_PRICE
# Cape Crypto
CURL_QRY="-s https://trade.capecrypto.com/api/v2/trade/public/markets/btczar/tickers"
CURL_OUT=$(curl $CURL_QRY)
CAPECRYPTO_PRICE=$(echo $CURL_OUT | jq '.ticker.last | tonumber')
# echo "<=== Cape Crypto - @capecryptoSA ===>"
# echo $CAPECRYPTO_PRICE
# Binance Africa
CURL_QRY="-s https://api.binance.com/api/v3/ticker/price?symbol=BTCZAR"
CURL_OUT=$(curl $CURL_QRY)
BINANCE_PRICE=$(echo $CURL_OUT | jq '.price | tonumber')
# echo "<=== BINANCE - @BinanceAfrica ===>"
# echo $BINANCE_PRICE
# AltCoinTraded
CURL_QRY="-s https://api.altcointrader.co.za/v3/live-stats"
CURL_OUT=$(curl $CURL_QRY)
ALTCOIN_PRICE=$(echo $CURL_OUT | jq '.BTC.Price | tonumber')
# echo "<== AltCoinTrader - @AltCoinTraderSA ==>"
# echo $ALTCOIN_PRICE
# Chainex
CURL_QRY="-s https://api.chainex.io/market/stats/BTC/ZAR"
CURL_OUT=$(curl $CURL_QRY)
CHAIN_PRICE=$(echo $CURL_OUT | jq '.data.last_price | tonumber')
# echo "<=== Chainex - @ChainEXIO ==>"
# echo $CHAIN_PRICE
# OVEX
# CURL_QRY="-s --location --request GET https://www.ovex.io/api/v2/rfq/get_quote?market=btczar&side=buy&to_amount=1"
CURL_QRY="-s --location --request GET https://www.ovex.io/api/v2/rfq/get_quote?market=btczar&from_amount=1000&side=buy&prefunded=1"
CURL_OUT=$(curl $CURL_QRY)
OVEX_PRICE=$(echo $CURL_OUT | jq '.rate | tonumber')
# echo "<=== OVEX - @OVEXio ==>"
# echo $OVEX_PRICE


TOTAL_ZAR=$(echo $VALR_PRICE+$LUNO_PRICE+$BINANCE_PRICE+$CHAIN_PRICE+$ALTCOIN_PRICE+$OVEX_PRICE+$CAPECRYPTO_PRICE | bc)
# TOTAL_ZAR=$(echo $VALR_PRICE+$LUNO_PRICE+$BINANCE_PRICE+$CHAIN_PRICE+$ALTCOIN_PRICE | bc)

AVERAGE_ZAR=$(echo $TOTAL_ZAR/7 | bc)
SATS_ZAR=$(echo 100000000/$AVERAGE_ZAR | bc)
# Exchange formattinf and output
printf -v SATS_ZARSTR "%d sats\\R1\n" "$SATS_ZAR"
echo $SATS_ZARSTR
printf -v VALR_PRICESTR "R%.2f @VALRdotcom\n" "$VALR_PRICE"
echo $VALR_PRICESTR
printf -v LUNO_PRICESTR "R%.2f @LunoGlobal\n" "$LUNO_PRICE"
echo $LUNO_PRICESTR
printf -v CAPECRYPTO_PRICESTR "R%.2f @capecryptoSA\n" "$CAPECRYPTO_PRICE"
echo $CAPECRYPTO_PRICESTR
printf -v BINANCE_PRICESTR "R%.2f @BinanceAfrica\n" "$BINANCE_PRICE"
echo $BINANCE_PRICESTR
printf -v ALTCOIN_PRICESTR "R%.2f @AltCoinTraderSA\n" "$ALTCOIN_PRICE"
echo $ALTCOIN_PRICESTR
printf -v CHAIN_PRICESTR "R%.2f @ChainEXIO\n" "$CHAIN_PRICE"
echo $CHAIN_PRICESTR
echo "1/2"
echo "<=== Tweet 2 ===>"
printf -v OVEX_PRICESTR "R%.2f @OVEXIO\n" "$OVEX_PRICE"
echo $OVEX_PRICESTR

# CURL_QRY="-s https://api.coindesk.com/v1/bpi/currentprice/ZAR.json"
# CURL_OUT=$(curl $CURL_QRY)
# echo "<== Coindesk (USD/ZAR) - @Coindesk ==>"
# CD_USD=$(echo $CURL_OUT | jq '.bpi.USD.rate_float | tonumber')
# echo $CD_USD
# CURL_QRY="-s https://openexchangerates.org/api/latest.json?app_id=3263b0c93523446299d17e2e6abdd748&symbols=ZAR"
# CURL_OUT=$(curl $CURL_QRY)
# USDZAR_RATE=$(echo $CURL_OUT | jq '.rates.ZAR | tonumber')
# CALC_ZAR=$(echo $CD_USD*$USDZAR_RATE | bc)
# echo $USDZAR_RATE
# echo $CALC_ZAR
# CALC_PREM_ZAR=$(echo $AVERAGE_ZAR-$CALC_ZAR | bc)
# CALC_ZAR100=$(echo $CALC_PREM_ZAR*100 | bc)
# CALC_PREM=$(echo $CALC_ZAR100/$CALC_ZAR | bc -l)
# echo $CALC_PREM

CURL_QRY="curl -s https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd"
CURL_OUT=$(curl $CURL_QRY)
# "<== CoinGecho (USD/ZAR) - @CoinGecho ==>"
echo "Ref:"
CG_USD=$(echo $CURL_OUT | jq '.bitcoin.usd | tonumber')
printf -v CG_USDSTR "$%.2f @coingecko\n" "$CG_USD" 
echo $CG_USDSTR
CURL_QRY="-s https://openexchangerates.org/api/latest.json?app_id=3263b0c93523446299d17e2e6abdd748&symbols=ZAR"
CURL_OUT=$(curl $CURL_QRY)
USDZAR_RATE=$(echo $CURL_OUT | jq '.rates.ZAR | tonumber')
CALC_ZAR=$(echo $CG_USD*$USDZAR_RATE | bc)
CALC_PREM_ZAR=$(echo $AVERAGE_ZAR-$CALC_ZAR | bc)
CALC_ZAR100=$(echo $CALC_PREM_ZAR*100 | bc)
CALC_PREM=$(echo $CALC_ZAR100/$CALC_ZAR | bc -l)
printf -v CALC_ZARSTR "R%.2f @coingecko - %.2f%% premium\n" "$CALC_ZAR" "$CALC_PREM"
echo $CALC_ZARSTR

echo "Fees:"
CURL_QRY="curl -s https://mempool.space/api/v1/fees/recommended"
CURL_OUT=$(curl $CURL_QRY)
MP_FASTFEE=$(echo $CURL_OUT | jq '.fastestFee | tonumber')
printf -v MP_FASTFEESTR "%d sats/vbyte @mempool (onchain)" "$MP_FASTFEE"
echo $MP_FASTFEESTR
CURL_QRY="curl -s https://trade.capecrypto.com/api/v2/trade/public/currencies/btc"
CURL_OUT=$(curl $CURL_QRY)
CC_WITHL1FEE=$(echo $CURL_OUT | jq '.withdraw_fee | tonumber')
CC_WITHL1FEEZAR=$(echo $CC_WITHL1FEE*$CAPECRYPTO_PRICE | bc -l)
printf -v CC_WITHL1STR "%.8fBTC (R%.2f) @capecryptoSA (onchain)\n" "$CC_WITHL1FEE" "$CC_WITHL1FEEZAR"
echo $CC_WITHL1STR
CC_WITHL2FEE=$(echo $CURL_OUT | jq '.layer_two_withdraw_fee | tonumber')
CC_WITHL2FEEZAR=$(echo $CC_WITHL2FEE/100000000*$CAPECRYPTO_PRICE | bc -l)
printf -v CC_WITHL2STR "%d sats (R%.2f) @capecryptoSA (layer 2 - LN)\n\n" "$CC_WITHL2FEE" "$CC_WITHL2FEEZAR"
echo $CC_WITHL2STR
echo "Tip over LN to: mariusb@blink.sv"
echo $(date '+%Y-%m-%d %H:%M %Z')
echo "2/2"
#echo "https://tippin.me/@mariusb"
echo "<=== Additional Information ==>"
printf -v USDZARSTR "R%.5f per USD\n" "$USDZAR_RATE"
echo $USDZARSTR
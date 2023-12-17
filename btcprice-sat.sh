#!/bin/bash
echo "#bitcoin #btc in #SouthAfrica"
# VALR
CURL_QRY="-s --location --request GET https://api.valr.com/v1/public/BTCZAR/marketsummary"
CURL_OUT=$(curl $CURL_QRY)
VALR_PRICE=$(echo $CURL_OUT | jq '.lastTradedPrice | tonumber')
CURL_QRY="-s --location --request GET https://api.valr.com/v1/public/ADABTC/marketsummary"
CURL_OUT=$(curl $CURL_QRY)
VALR_ADA_PRICE=$(echo $CURL_OUT | jq '.lastTradedPrice | tonumber')
echo "<=== VALR - @VALRdotcom ===>"
echo $VALR_PRICE
# Luno
CURL_QRY="-s https://api.mybitx.com/api/1/ticker?pair=XBTZAR"
CURL_OUT=$(curl $CURL_QRY)
LUNO_PRICE=$(echo $CURL_OUT | jq '.last_trade | tonumber')
CURL_QRY="-s https://api.mybitx.com/api/1/ticker?pair=ADAZAR"
CURL_OUT=$(curl $CURL_QRY)
LUNO_ADA_PRICE=$(echo $CURL_OUT | jq '.last_trade | tonumber')
LUNO_PRICE=${LUNO_PRICE:-0}
echo "<=== LUNO - @LunoGlobal ===>" 
echo $LUNO_PRICE
# Cape Crypto
CURL_QRY="-s https://trade.capecrypto.com/api/v2/trade/public/markets/btczar/tickers"
CURL_OUT=$(curl $CURL_QRY)
CAPECRYPTO_PRICE=$(echo $CURL_OUT | jq '.ticker.last | tonumber')
echo "<=== Cape Crypto - @capecryptoSA ===>"
echo $CAPECRYPTO_PRICE
# Binance Africa
CURL_QRY="-s https://api.binance.com/api/v3/ticker/price?symbol=BTCZAR"
CURL_OUT=$(curl $CURL_QRY)
BINANCE_PRICE=$(echo $CURL_OUT | jq '.price | tonumber')
echo "<=== BINANCE - @BinanceAfrica ===>"
echo $BINANCE_PRICE
# AltCoinTraded
CURL_QRY="-s https://api.altcointrader.co.za/v3/live-stats"
CURL_OUT=$(curl $CURL_QRY)
ALTCOIN_PRICE=$(echo $CURL_OUT | jq '.BTC.Price | tonumber')
echo "<== AltCoinTrader - @AltCoinTraderSA ==>"
echo $ALTCOIN_PRICE
# Chainex
CURL_QRY="-s https://api.chainex.io/market/stats/BTC/ZAR"
CURL_OUT=$(curl $CURL_QRY)
CHAIN_PRICE=$(echo $CURL_OUT | jq '.data.last_price | tonumber')
echo "<=== Chainex - @ChainEXIO ==>"
echo $CHAIN_PRICE
# OVEX
# CURL_QRY="-s --location --request GET https://www.ovex.io/api/v2/rfq/get_quote?market=btczar&side=buy&to_amount=1"
CURL_QRY="-s --location --request GET https://www.ovex.io/api/v2/rfq/get_quote?market=btczar&from_amount=1000&side=buy&prefunded=1"
CURL_OUT=$(curl $CURL_QRY)
OVEX_PRICE=$(echo $CURL_OUT | jq '.rate | tonumber')
echo "<=== OVEX - @OVEXio ==>"
echo $OVEX_PRICE


TOTAL_ZAR=$(echo $VALR_PRICE+$LUNO_PRICE+$BINANCE_PRICE+$CHAIN_PRICE+$ALTCOIN_PRICE+$OVEX_PRICE+$CAPECRYPTO_PRICE | bc)
# TOTAL_ZAR=$(echo $VALR_PRICE+$LUNO_PRICE+$BINANCE_PRICE+$CHAIN_PRICE+$ALTCOIN_PRICE | bc)

AVERAGE_ZAR=$(echo $TOTAL_ZAR/7 | bc)
SATS_ZAR=$(echo 100000000/$AVERAGE_ZAR | bc)
echo "<=== sats per R1.00 ==>"
echo $TOTAL_ZAR
echo $AVERAGE_ZAR
echo $SATS_ZAR

CURL_QRY="-s https://api.coindesk.com/v1/bpi/currentprice/ZAR.json"
CURL_OUT=$(curl $CURL_QRY)
echo "<== Coindesk (USD/ZAR) - @Coindesk ==>"
CD_USD=$(echo $CURL_OUT | jq '.bpi.USD.rate_float | tonumber')
echo $CD_USD
CURL_QRY="-s https://openexchangerates.org/api/latest.json?app_id=3263b0c93523446299d17e2e6abdd748&symbols=ZAR"
CURL_OUT=$(curl $CURL_QRY)
USDZAR_RATE=$(echo $CURL_OUT | jq '.rates.ZAR | tonumber')
CALC_ZAR=$(echo $CD_USD*$USDZAR_RATE | bc)
echo $USDZAR_RATE
echo $CALC_ZAR
CALC_PREM_ZAR=$(echo $AVERAGE_ZAR-$CALC_ZAR | bc)
CALC_ZAR100=$(echo $CALC_PREM_ZAR*100 | bc)
CALC_PREM=$(echo $CALC_ZAR100/$CALC_ZAR | bc -l)
echo $CALC_PREM

CURL_QRY="curl -s https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd"
CURL_OUT=$(curl $CURL_QRY)
echo "<== CoinGecho (USD/ZAR) - @CoinGecho ==>"
CG_USD=$(echo $CURL_OUT | jq '.bitcoin.usd | tonumber')
echo $CG_USD
CALC_ZAR=$(echo $CG_USD*$USDZAR_RATE | bc)
echo $USDZAR_RATE
echo $CALC_ZAR
CALC_PREM_ZAR=$(echo $AVERAGE_ZAR-$CALC_ZAR | bc)
CALC_ZAR100=$(echo $CALC_PREM_ZAR*100 | bc)
CALC_PREM=$(echo $CALC_ZAR100/$CALC_ZAR | bc -l)
echo $CALC_PREM

echo "<== Fees ==>"
echo "<=== mempool.space - @mempool ===>"
CURL_QRY="curl -s https://mempool.space/api/v1/fees/recommended"
CURL_OUT=$(curl $CURL_QRY)
MP_FASTFEE=$(echo $CURL_OUT | jq '.fastestFee | tonumber')
echo $MP_FASTFEE
echo "<=== Cape Crypto - @capecryptoSA ===>"
CURL_QRY="curl -s https://trade.capecrypto.com/api/v2/trade/public/currencies/btc"
CURL_OUT=$(curl $CURL_QRY)
CC_WITHFEE=$(echo $CURL_OUT | jq '.withdraw_fee | tonumber')
echo $CC_WITHFEE

echo $(date)
#echo "https://tippin.me/@mariusb"
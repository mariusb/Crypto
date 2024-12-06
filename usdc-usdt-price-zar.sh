#!/bin/bash
echo "#USDC in #SouthAfrica"
CURL_QRY="-s --location --request GET https://api.valr.com/v1/public/USDCZAR/marketsummary"
CURL_OUT=$(curl $CURL_QRY)
VALR_PRICE=$(echo $CURL_OUT | jq '.lastTradedPrice | tonumber')
echo "<=== VALR - @VALRdotcom ===>"
echo $VALR_PRICE
CURL_QRY="-s https://api.mybitx.com/api/1/ticker?pair=USDCZAR"
CURL_OUT=$(curl $CURL_QRY)
LUNO_PRICE=$(echo $CURL_OUT | jq '.last_trade | tonumber')
echo "<=== LUNO - @LunoGlobal ===>" 
echo $LUNO_PRICE

echo "======================="
echo "#USDT in #SouthAfrica"
CURL_QRY="-s --location --request GET https://api.valr.com/v1/public/USDTZAR/marketsummary"
CURL_OUT=$(curl $CURL_QRY)
VALR_PRICE=$(echo $CURL_OUT | jq '.lastTradedPrice | tonumber')
echo "<=== VALR - @VALRdotcom ===>"
echo $VALR_PRICE
CURL_QRY="-s https://api.mybitx.com/api/1/ticker?pair=USDTZAR"
CURL_OUT=$(curl $CURL_QRY)
LUNO_PRICE=$(echo $CURL_OUT | jq '.last_trade | tonumber')
echo "<=== LUNO - @LunoGlobal ===>" 
echo $LUNO_PRICE

echo "======================="
CURL_QRY="-s https://openexchangerates.org/api/latest.json?app_id=3263b0c93523446299d17e2e6abdd748&symbols=ZAR"
CURL_OUT=$(curl $CURL_QRY)
USDZAR_RATE=$(echo $CURL_OUT | jq '.rates.ZAR | tonumber')
echo "<=== USD/ZAR Rate ===>" 
echo $USDZAR_RATE

echo $(date)
#echo "https://tippin.me/@mariusb"
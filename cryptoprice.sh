#!/bin/bash

# Backup cryptoprice.data file at the first run in a new month (if not already backed up this session)
BACKUP_DATE=$(date +"%Y%m")
BACKUP_FILE="cryptoprice.data.$BACKUP_DATE"

if [ ! -f "$BACKUP_FILE" ]; then
    if [ -f cryptoprice.data ]; then
        mv cryptoprice.data "$BACKUP_FILE"
        echo "Backup created: $BACKUP_FILE" >> cryptoprice.data 2>&1
    fi
fi

echo "=======================================================================================" >> cryptoprice.data
date >> cryptoprice.data
curl -s 'https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,ETH,LTC,DASH,DOGE,BTG,TRX,SC,BCH,OMG,CVC,DCR,XVG,XMR,ADA,NIGHT,USDT,USDC&tsyms=USD' >> cryptoprice.data 
echo "" >> cryptoprice.data
curl -s 'https://min-api.cryptocompare.com/data/pricemulti?fsyms=ADA,NIGHT,TRX,DOGE,SHIB,XMR,LTC,XLM,BNB,DASH,ETH,USDT,USDC&tsyms=BTC' >> cryptoprice.data 
echo "" >> cryptoprice.data
curl -s 'https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=ZAR&e=VALR' >> cryptoprice.data
echo "" >> cryptoprice.data
curl -s 'https://openexchangerates.org/api/latest.json?app_id=3263b0c93523446299d17e2e6abdd748&symbols=ZAR,THB' >> cryptoprice.data
echo "" >> cryptoprice.data
CURL_QRY="-s --location --request GET https://api.valr.com/v1/public/USDTZAR/marketsummary"
CURL_OUT=$(curl $CURL_QRY)
VALR_PRICE=$(echo $CURL_OUT | jq '.lastTradedPrice | tonumber')
echo "<=== VALR - @VALRdotcom - USDT ===>" >> cryptoprice.data
echo $VALR_PRICE >> cryptoprice.data
exit 0

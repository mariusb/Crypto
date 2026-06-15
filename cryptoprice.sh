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
# curl -s 'https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,ETH,DOGE,TRX,ADA,NIGHT,BDAG,USDT,USDC&tsyms=USD&api_key=e67a1a47e8ce26da50c001a735d12e81b8c6b570094ead5e8b57bccd6a0aeae7' >> cryptoprice.data
# echo "" >> cryptoprice.data
curl -s 'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum,dogecoin,tron,cardano,midnight-3,blockdag,tether,usd-coin&vs_currencies=usd&x_cg_demo_api_key=CG-6ECawTrFcx92rJg7UrgtXUjb' >> cryptoprice.data
echo "" >> cryptoprice.data
# curl -s 'https://min-api.cryptocompare.com/data/pricemulti?fsyms=ADA,NIGHT,BDAG,TRX,DOGE,BNB,ETH,USDT,USDC&tsyms=BTC&api_key=e67a1a47e8ce26da50c001a735d12e81b8c6b570094ead5e8b57bccd6a0aeae7' >> cryptoprice.data
# echo "" >> cryptoprice.data
curl -s 'https://api.coingecko.com/api/v3/simple/price?ids=cardano,midnight-3,blockdag,tron,dogecoin,binancecoin,ethereum,tether,usd-coin&vs_currencies=btc&x_cg_demo_api_key=CG-6ECawTrFcx92rJg7UrgtXUjb' >> cryptoprice.data
echo "" >> cryptoprice.data
# curl -s 'https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=ZAR&e=VALR&api_key=e67a1a47e8ce26da50c001a735d12e81b8c6b570094ead5e8b57bccd6a0aeae7' >> cryptoprice.data
# echo "" >> cryptoprice.data
curl -s 'GET' 'https://api.coingecko.com/api/v3/exchanges/valr/tickers?coin_ids=bitcoin&x_cg_demo_api_key=CG-6ECawTrFcx92rJg7UrgtXUjb' | jq '.tickers[] | select(.target == "ZAR") | {pair: (.base + "/" + .target), price: .last}' >> cryptoprice.data
echo "" >> cryptoprice.data
curl -s 'https://openexchangerates.org/api/latest.json?app_id=3263b0c93523446299d17e2e6abdd748&symbols=ZAR,THB,KZT' >> cryptoprice.data
echo "" >> cryptoprice.data
CURL_QRY="-s --location --request GET https://api.valr.com/v1/public/USDTZAR/marketsummary"
CURL_OUT=$(curl $CURL_QRY)
VALR_PRICE=$(echo $CURL_OUT | jq '.lastTradedPrice | tonumber')
echo "<=== VALR - @VALRdotcom - USDT ===>" >> cryptoprice.data
echo $VALR_PRICE >> cryptoprice.data

exit 0

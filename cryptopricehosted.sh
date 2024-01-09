#!/bin/bash
cd /home/mariusb16/cryptodailyprice
echo "=======================================================================================" >> cryptoprice.data
date >> cryptoprice.data
curl -s 'https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,ETH,LTC,DASH,DOGE,BTG,SC,BCH,OMG,CVC,DCR,XVG,XMR,ADA,USDT,USDC,ROSE&tsyms=USD' >> cryptoprice.data 
echo "" >> cryptoprice.data
curl -s 'https://min-api.cryptocompare.com/data/pricemulti?fsyms=ADA,DOGE,SHIB,XMR,LTC,XLM,BNB,DASH,ETH,USDT,USDC,ROSE,LUNA,LUNC&tsyms=BTC' >> cryptoprice.data 
echo "" >> cryptoprice.data
curl -s 'https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=ZAR&e=VALR' >> cryptoprice.data
echo "" >> cryptoprice.data
curl -s 'https://openexchangerates.org/api/latest.json?app_id=3263b0c93523446299d17e2e6abdd748&symbols=ZAR,THB' >> cryptoprice.data
echo "" >> cryptoprice.data
exit 0

#!/bin/bash
cd /home/mariusb16/cryptodailyprice
echo "=======================================================================================" >> cryptoprice.data
date >> cryptoprice.data
curl -s 'https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,ETH,LTC,DASH,DOGE,BTG,SC,BCH,OMG,CVC,DCR,XVG,XMR,ADA&tsyms=USD' >> cryptoprice.data 
echo "" >> cryptoprice.data
curl -s 'https://min-api.cryptocompare.com/data/pricemulti?fsyms=ADA,DOGE,XMR,LTC,XLM,CVC,BNB,SC&tsyms=BTC' >> cryptoprice.data 
echo "" >> cryptoprice.data
curl -s 'https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=ZAR&e=LUNO' >> cryptoprice.data
echo "" >> cryptoprice.data
curl -s 'https://free.currencyconverterapi.com/api/v6/convert?q=USD_ZAR&compact=ultra&apiKey=9376cdd3b48e683ae920' >> cryptoprice.data
echo "" >> cryptoprice.data
curl -s 'https://free.currencyconverterapi.com/api/v6/convert?q=ZAR_THB&compact=ultra&apiKey=9376cdd3b48e683ae920' >> cryptoprice.data
echo "" >> cryptoprice.data
curl -s 'https://mempool.space:8999/api/v1/fees/recommended' >> cryptoprice.data
echo "" >> cryptoprice.data
exit 0

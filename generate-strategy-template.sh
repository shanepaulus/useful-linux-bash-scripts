#!/bin/bash

# Prompt for the strategy name
read -p "Please enter the name for the strategy: " strategy_name

# Create the file using the entered name
file_name="$PWD/$strategy_name"
echo "Creating strategy template file: $file_name"

cat << EOF > "$file_name"
//+------------------------------------------------------------------+
//|                                                     Template.mq5 |
//|                                Copyright 2023, Shane Anil Paulus |
//|                                           https://shanepaulus.uk |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Shane Anil Paulus"
#property link      "https://shanepaulus.uk"
#property version   "1.00"

#include <Trade/Trade.mqh>

input group "********************** Expert Settings **********************"
input long MAGIC_NUMBER = 2468546513;   // Magic Number

input group "********************** Risk Settings **********************"


CTrade trade;
CPositionInfo positionInfo;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {
   trade.SetExpertMagicNumber(MAGIC_NUMBER);
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {

}


//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick() {
   if (HasAnyOpenPosition()) {
   
   } else {   
   }
}


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool HasAnyOpenPosition() {
   for (int index = PositionsTotal() - 1; index >= 0; index --) {
      if (positionInfo.SelectByIndex(index) && positionInfo.Symbol() == _Symbol && positionInfo.Magic() == MAGIC_NUMBER) {
         return true;
      }
   }
   
   return false;
}

EOF

# Write the content to the file
echo "$content" > "$file_name"

echo "Strategy template file created successfully."
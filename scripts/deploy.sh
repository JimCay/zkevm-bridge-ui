#!/bin/sh
ENV_FILENAME="/app/.env"

# Create .env file
touch $ENV_FILENAME

# ETHEREUM env vars
echo "VITE_ETHEREUM_RPC_URL=$ETHEREUM_RPC_URL" >> $ENV_FILENAME
echo "VITE_ETHEREUM_EXPLORER_URL=$ETHEREUM_EXPLORER_URL" >> $ENV_FILENAME
echo "VITE_ETHEREUM_BRIDGE_CONTRACT_ADDRESS=$ETHEREUM_BRIDGE_CONTRACT_ADDRESS" >> $ENV_FILENAME
echo "VITE_ETHEREUM_FORCE_UPDATE_GLOBAL_EXIT_ROOT=$ETHEREUM_FORCE_UPDATE_GLOBAL_EXIT_ROOT" >> $ENV_FILENAME
echo "VITE_ETHEREUM_PROOF_OF_EFFICIENCY_CONTRACT_ADDRESS=$ETHEREUM_PROOF_OF_EFFICIENCY_CONTRACT_ADDRESS" >> $ENV_FILENAME

# POLYGON ZK EVM env vars
echo "VITE_POLYGON_ZK_EVM_RPC_URL=$POLYGON_ZK_EVM_RPC_URL" >> $ENV_FILENAME
echo "VITE_POLYGON_ZK_EVM_EXPLORER_URL=$POLYGON_ZK_EVM_EXPLORER_URL" >> $ENV_FILENAME
echo "VITE_POLYGON_ZK_EVM_BRIDGE_CONTRACT_ADDRESS=$POLYGON_ZK_EVM_BRIDGE_CONTRACT_ADDRESS" >> $ENV_FILENAME
echo "VITE_POLYGON_ZK_EVM_NETWORK_ID=$POLYGON_ZK_EVM_NETWORK_ID" >> $ENV_FILENAME

# BRIDGE API env vars
echo "VITE_BRIDGE_API_URL=$BRIDGE_API_URL" >> $ENV_FILENAME

# OUTDATED NETWORK MODAL
echo "VITE_ENABLE_OUTDATED_NETWORK_MODAL=$ENABLE_OUTDATED_NETWORK_MODAL" >> $ENV_FILENAME

if [ ! -z "$OUTDATED_NETWORK_MODAL_TITLE" ];
then
  echo "VITE_OUTDATED_NETWORK_MODAL_TITLE=$OUTDATED_NETWORK_MODAL_TITLE" >> $ENV_FILENAME
fi

if [ ! -z "$OUTDATED_NETWORK_MODAL_MESSAGE_PARAGRAPH_1" ];
then
  echo "VITE_OUTDATED_NETWORK_MODAL_MESSAGE_PARAGRAPH_1=$OUTDATED_NETWORK_MODAL_MESSAGE_PARAGRAPH_1" >> $ENV_FILENAME
fi

if [ ! -z "$OUTDATED_NETWORK_MODAL_MESSAGE_PARAGRAPH_2" ];
then
  echo "VITE_OUTDATED_NETWORK_MODAL_MESSAGE_PARAGRAPH_2=$OUTDATED_NETWORK_MODAL_MESSAGE_PARAGRAPH_2" >> $ENV_FILENAME
fi

if [ ! -z "$OUTDATED_NETWORK_MODAL_URL" ];
then
  echo "VITE_OUTDATED_NETWORK_MODAL_URL=$OUTDATED_NETWORK_MODAL_URL" >> $ENV_FILENAME
fi

# DEPOSIT WARNING
echo "VITE_ENABLE_DEPOSIT_WARNING=$ENABLE_DEPOSIT_WARNING" >> $ENV_FILENAME

# REPORT FORM
echo "VITE_ENABLE_REPORT_FORM=$ENABLE_REPORT_FORM" >> $ENV_FILENAME

if [ ! -z "$REPORT_FORM_URL" ];
then
  echo "VITE_REPORT_FORM_URL=$REPORT_FORM_URL" >> $ENV_FILENAME
fi

if [ ! -z "$REPORT_FORM_ERROR_ENTRY" ];
then
  echo "VITE_REPORT_FORM_ERROR_ENTRY=$REPORT_FORM_ERROR_ENTRY" >> $ENV_FILENAME
fi

if [ ! -z "$REPORT_FORM_PLATFORM_ENTRY" ];
then
  echo "VITE_REPORT_FORM_PLATFORM_ENTRY=$REPORT_FORM_PLATFORM_ENTRY" >> $ENV_FILENAME
fi

if [ ! -z "$REPORT_FORM_URL_ENTRY" ];
then
  echo "VITE_REPORT_FORM_URL_ENTRY=$REPORT_FORM_URL_ENTRY" >> $ENV_FILENAME
fi

echo "Generated .env file:"
echo "$(cat /app/.env)"

# Build app
cd /app && npm run build

# Copy nginx config
cp /app/deployment/nginx.conf /etc/nginx/conf.d/default.conf

# Copy app dist
cp -r /app/dist/. /usr/share/nginx/html

# Delete source code
rm -rf /app

# Run nginx
nginx -g 'daemon off;'

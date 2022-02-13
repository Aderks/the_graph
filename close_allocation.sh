#! /bin/sh

ipfs=$1

echo "Closing ${ipfs} allocation..."
echo ""
graph indexer rules set ${ipfs} parallelAllocations 0 decisionBasis never allocationAmount 0
#echo ""

#echo "Deleting allocation rule..."
#echo ""
#graph indexer rules delete ${ipfs}

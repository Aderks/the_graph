#! /bin/sh

ipfs=$1

echo "Closing $1 allocation..."
graph indexer rules set $1 parallelAllocations 0 decisionBasis never allocationAmount 0

#echo "Deleting allocation rule..."
#graph indexer rules delete $1

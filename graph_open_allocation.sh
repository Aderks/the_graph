#! /bin/sh

ipfs=$1
allocation=$2
agora_dir=$HOME/agora
cost_model='default => 0.00002;'

# Allocate GRT to subgraph
echo "Allocating $2GRT to $1...\n"
graph indexer rules set $1 parallelAllocations 1 decisionBasis always allocationAmount $2
echo ""


# Check for cost model agora file
echo "Checking if cost model for $1 exists...\n"

if [ -f $agora_dir/$1.agora ]
then
	echo "$1.agora exists..."
	echo ""
	echo "Removing $1.agora and creating a new cost model file..."
	rm $agora_dir/$1.agora && touch $agora_dir/$1.agora && echo $cost_model >> $agora_dir/$1.agora
	echo ""
else
	echo "Cost model does not exist..."
	echo "Creating $1.agora..."
	touch $agora_dir/$1.agora && echo $cost_model >> $agora_dir/$1.agora
	echo ""
fi


# Set cost model for allocation
echo "Setting cost model for $1...\n"
graph indexer cost set model $1 $agora_dir/$1.agora

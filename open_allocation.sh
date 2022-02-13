#! /bin/sh

agora_dir=$HOME/agora
ipfs=$1
allocation=$2
cost_model=$3

# Allocate GRT to subgraph
echo "Allocating ${allocation}GRT to ${ipfs}...\n"
graph indexer rules set ${ipfs} parallelAllocations 1 decisionBasis always allocationAmount ${allocation}
echo ""


# Check for cost model agora file
echo "Checking if cost model for ${ipfs} exists...\n"

if [ -f ${agora_dir}/${ipfs}.agora ]
then
	echo "${ipfs}.agora exists..."
	echo ""
	echo "Removing ${ipfs}.agora and creating an updated cost model..."
	rm ${agora_dir}/${ipfs}.agora && touch ${agora_dir}/${ipfs}.agora && echo ${cost_model} >> ${agora_dir}/${ipfs}.agora
	echo ""
else
	echo "Cost model does not exist..."
	echo ""
	echo "Creating ${ipfs}.agora..."
	touch ${agora_dir}/${ipfs}.agora && echo ${cost_model} >> ${agora_dir}/${ipfs}.agora
	echo ""
fi


# Set cost model for allocation
echo "Setting cost model '${cost_model}' for ${ipfs}...\n"
graph indexer cost set model ${ipfs} ${agora_dir}/${ipfs}.agora

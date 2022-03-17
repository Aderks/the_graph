#! /bin/sh

echo "Fetching the latest Erigon release..."
git_latest_version=$(curl -s https://api.github.com/repos/ledgerwatch/erigon/releases/latest | jq -r .tag_name)
git_latest_hash=$(git ls-remote --tags https://github.com/ledgerwatch/erigon ${git_latest_version} | head -c8)
echo ""

echo "Latest release is ${git_latest_version}-${git_latest_hash}..."
echo ""
echo -n "Do you want to install Erigon ${git_latest_version}-${git_latest_hash} (y/n)?"
read answer

if [ "$answer" != "${answer#[Yy]}" ]
then

        echo ""
        echo "Updating local repo to match remote repo..."
        cd $HOME/erigon
        git pull
        echo ""

        echo ""
        echo "Switching to latest release ${git_latest_version}-${git_latest_hash}..."
        git checkout ${git_latest_version}
        echo ""

        echo "Stopping Erigon node & rpc services..."
        sudo systemctl stop erigon_node && sudo systemctl stop erigon_rpc
        echo ""

        echo "Removing previous Erigon & installing latest version..."
        rm $HOME/erigon/build/bin/*
        make erigon
        make rpcdaemon
        echo ""

        echo "Restarting Erigon node & rpc services..."
        sudo systemctl start erigon_node
        sleep 30
        sudo systemctl start erigon_rpc
        journalctl -f -o cat -u erigon_node -u erigon_rpc

else
        exit 0
fi


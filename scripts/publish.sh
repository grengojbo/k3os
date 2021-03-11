#!/bin/bash

source $(dirname $0)/version

echo "Release: ${VERSION}"
echo "-----------------------------------------"
for f in $(ls ./dist/artifacts) ; do
  echo "Deploy file: ${f}"
  # hub release edit -m 5.4.0-65.73-k3os -a ./dist/artifacts/${f} 5.4.0-65.73-k3os
done

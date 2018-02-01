#!/bin/bash

set -e

validate_nb() {
    _nb="$1"
    _output="/tmp/tmp.OYN0z4DZco.colomoto-test.ipynb"
    jupyter nbconvert --execute "${_nb}" --to notebook --output $_output \
        --ExecutePreprocessor.timeout=120
    rm -f $_output
}

test_nb=()
test_nb+=("tutorials/Reproducibility - fixpoints.ipynb")
test_nb+=("tutorials/Reproducibility - model checking.ipynb")
test_nb+=("tutorials/MaBoSS/Toy Example.ipynb")
test_nb+=("tutorials/MaBoSS/Tutorial.ipynb")
test_nb+=("tutorials/Pint/quick-tutorial.ipynb")
test_nb+=("tutorials/Pint/demo.ipynb")

for nb in "${test_nb[@]}"; do
    echo "======= Testing $nb"
    validate_nb "${nb}"
done

echo "*** SUCCESS ***"


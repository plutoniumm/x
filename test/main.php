<?php
function calculateEntropy($string) {
    $len = strlen($string);

    $entropy = 0;
    foreach (count_chars($string, 1) as $freq) {
        $p = $freq / $len;
        $entropy -= $p * log($p, 2);
    }

    return $entropy;
}

if (isset($argv[1])) {
    $in = $argv[1];
    $ent = calculateEntropy($in);
    echo $ent;
} else {
    echo "Please provide a string as a command-line argument";
}
?>

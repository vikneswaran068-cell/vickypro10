#!/bin/bash

echo "=============================================="
echo " SAN JOAQUIN VALLEY TOWN HALL"
echo " THIRD COLUMN AUTOGRADER"
echo "=============================================="

MARKS=0
TOTAL=50

# TEST 1 - index.html
if [ -f index.html ]; then
    echo "TEST 1 PASS - index.html found - 5 marks"
    MARKS=$((MARKS + 5))
else
    echo "TEST 1 FAIL - index.html missing - 0 marks"
fi

# TEST 2 - CSS file
if [ -f styles/Ex10_main.css ]; then
    echo "TEST 2 PASS - CSS file found - 5 marks"
    MARKS=$((MARKS + 5))
else
    echo "TEST 2 FAIL - CSS file missing - 0 marks"
fi

# Stop if index.html does not exist
if [ ! -f index.html ]; then
    echo "Cannot continue because index.html is missing."
    exit 1
fi

# TEST 3 - main element
if grep -Eiq '<main[[:space:]>]' index.html; then
    echo "TEST 3 PASS - main element found - 5 marks"
    MARKS=$((MARKS + 5))
else
    echo "TEST 3 FAIL - main element missing - 0 marks"
fi

# TEST 4 - section element
if grep -Eiq '<section[[:space:]>]' index.html; then
    echo "TEST 4 PASS - section element found - 5 marks"
    MARKS=$((MARKS + 5))
else
    echo "TEST 4 FAIL - section element missing - 0 marks"
fi

# TEST 5 - At least two aside elements
ASIDE_COUNT=$(grep -Eio '<aside([[:space:]>])' index.html | wc -l)

if [ "$ASIDE_COUNT" -ge 2 ]; then
    echo "TEST 5 PASS - $ASIDE_COUNT aside elements found - 5 marks"
    MARKS=$((MARKS + 5))
else
    echo "TEST 5 FAIL - Only $ASIDE_COUNT aside element(s) found - 0 marks"
fi

# TEST 6 - Third column content
if grep -Eiq 'Event change for November 16|Event Change for November 16' index.html; then
    echo "TEST 6 PASS - Third column content found - 5 marks"
    MARKS=$((MARKS + 5))
else
    echo "TEST 6 FAIL - Third column content not found - 0 marks"
fi

# TEST 7 - Aside width
if [ -f styles/Ex10_main.css ]; then

    if grep -Eiq 'aside[[:space:]]*\{' styles/Ex10_main.css && \
       grep -Eiq 'width[[:space:]]*:[[:space:]]*[0-9]+px' styles/Ex10_main.css; then

        echo "TEST 7 PASS - Aside width property found - 5 marks"
        MARKS=$((MARKS + 5))
    else
        echo "TEST 7 FAIL - Aside width property missing - 0 marks"
    fi

else
    echo "TEST 7 FAIL - CSS file missing - 0 marks"
fi

# TEST 8 - Aside float
if [ -f styles/Ex10_main.css ]; then

    if grep -Eiq 'aside[[:space:]]*\{' styles/Ex10_main.css && \
       grep -Eiq 'float[[:space:]]*:[[:space:]]*(left|right)' styles/Ex10_main.css; then

        echo "TEST 8 PASS - Aside float property found - 5 marks"
        MARKS=$((MARKS + 5))
    else
        echo "TEST 8 FAIL - Aside float property missing - 0 marks"
    fi

else
    echo "TEST 8 FAIL - CSS file missing - 0 marks"
fi

# TEST 9 - Footer clear
if [ -f styles/Ex10_main.css ]; then

    if grep -Eiq 'footer[[:space:]]*\{' styles/Ex10_main.css && \
       grep -Eiq 'clear[[:space:]]*:[[:space:]]*both' styles/Ex10_main.css; then

        echo "TEST 9 PASS - footer clear: both found - 5 marks"
        MARKS=$((MARKS + 5))
    else
        echo "TEST 9 FAIL - footer clear: both missing - 0 marks"
    fi

else
    echo "TEST 9 FAIL - CSS file missing - 0 marks"
fi

# TEST 10 - Original content
CONTENT_OK=1

grep -Fqi "San Joaquin Valley Town Hall" index.html || CONTENT_OK=0
grep -Fqi "Our Mission" index.html || CONTENT_OK=0
grep -Fqi "Speaker of the Month" index.html || CONTENT_OK=0
grep -Fqi "Our Ticket Packages" index.html || CONTENT_OK=0
grep -Fqi "Guest speakers" index.html || CONTENT_OK=0

if [ "$CONTENT_OK" -eq 1 ]; then
    echo "TEST 10 PASS - Original content retained - 5 marks"
    MARKS=$((MARKS + 5))
else
    echo "TEST 10 FAIL - Original content missing - 0 marks"
fi

# FINAL RESULT
echo ""
echo "=============================================="
echo " FINAL RESULT"
echo "=============================================="

echo "Marks Obtained : $MARKS / $TOTAL"
echo "Percentage     : $((MARKS * 100 / TOTAL))%"

echo "=============================================="

if [ "$MARKS" -ge 25 ]; then
    echo "RESULT: PASS"
    exit 0
else
    echo "RESULT: FAIL"
    exit 1
fi
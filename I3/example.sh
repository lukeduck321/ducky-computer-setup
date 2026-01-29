#!/bin/bash
# Simplified version without jq dependency

get_highlighted_text() {
    xclip -selection primary -o 2>/dev/null || \
    xclip -selection clipboard -o 2>/dev/null
}

clean_word() {
    echo "$1" | xargs | sed 's/^[^a-zA-Z0-9]*//;s/[^a-zA-Z0-9]*$//' | tr '[:upper:]' '[:lower:]'
}

main() {
    local text=$(get_highlighted_text)
    [[ -z "$text" ]] && exit 1
    
    local word=$(clean_word "$text")
    [[ -z "$word" ]] && exit 1
    
    # Try to get definition
    local meaning=$(curl -s "https://api.dictionaryapi.dev/api/v2/entries/en/$word" 2>/dev/null | \
        grep -o '"definition":"[^"]*"' | head -1 | sed 's/"definition":"//;s/"//')
    
    if [[ -n "$meaning" ]]; then
        notify-send "Word Lookup" "<b>\"$word\"</b>\n\n$meaning"
    else
        notify-send "Word Lookup" "No definition found for: $word"
    fi
}

main

# Define the key-value pairs
declare -A sites=(
    ["GitHub User"]="https://github.com/quochuy242"
    ["Youtube"]="https://www.youtube.com/"
    ["Typst Tutorials"]="https://sitandr.github.io/typst-examples-book/book/basics/tutorial/index.html"
    ["Fedora Packages"]="https://src.fedoraproject.org/"
    ["Fedora Status"]="https://status.fedoraproject.org/"
    ["HuggingFace User"]="https://huggingface.co/quochuy242"
    ["ChatGPT"]="https://chatgpt.com"
    ["Gemini"]="https://gemini.google.com/"
    ["Google Translate (VN-EN)"]="https://translate.google.com/?hl=vi&sl=vi&tl=en&op=translate"
    ["Google Translate (EN-VN)"]="https://translate.google.com/?hl=vi&sl=en&tl=vi&op=translate"
)

# Show menu and get selection
choice=$(printf '%s\n' "${!sites[@]}" | rofi -dmenu -p "Open Website:" -theme ~/.config/rofi/default.rasi)

# If user picked something, open it
if [[ -n "$choice" ]]; then
    xdg-open "${sites[$choice]}" >/dev/null 2>&1 &
fi

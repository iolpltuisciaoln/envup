function fzf-my-preview(){
    # '(highlight -O ansi -l {} 2> /dev/null ||
    # bat --style=numbers --color=always --line-range :500 {} ||
    # tree -C {}) 2> /dev/null | head -200'

    ext=$1:t:e
    if [ -d $1 ] && tree $1 && return
    case "$ext" in
        pdf|Pdf|PDF)
            pdftotext -nodiag -nopgbrk $1 - | bat --style=numbers --color=always --line-range :500
            ;;
        rar|Rar|RAR)
            lsar $1
        ;;
        *)
            (bat --style=numbers --color=always --line-range :500 $1|| tree -C $1) 2> /dev/null | head -200
            ;;
        esac
    # bat --style=numbers --color=always --line-range :500 $1
    return
}
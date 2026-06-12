[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
MISE_SHIMS_DIR="$HOME/.local/share/mise/shims"
case ":$PATH:" in
  *":$MISE_SHIMS_DIR:"*) ;;
  *) export PATH="$MISE_SHIMS_DIR:$PATH" ;;
esac

export ALIYUNPAN_CONFIG_DIR="$HOME/.config/adrive"

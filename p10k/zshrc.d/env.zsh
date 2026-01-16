# 环境变量（PATH、LANG、NVM_DIR 等）

# ========= 基础环境 =========
# 自动去重 PATH，防止每次 source 时路径无限叠加导致搜索变慢
typeset -U path PATH

export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export LANG=en_US.UTF-8


# ========= NVM 懒加载配置 =========
# 说明：
# 当首次执行 node / npm / npx / nvm 时，才会加载 NVM，
# 并自动使用你设定的 default 版本（比如 Node 18）
lazy_load_nvm() {
  unset -f nvm node npm npx
  export NVM_DIR="$HOME/.nvm"
  # 加载 nvm 本体
  if [ -s "$NVM_DIR/nvm.sh" ]; then
    . "$NVM_DIR/nvm.sh"
  fi
  # 加载命令补全（可选）
  if [ -s "$NVM_DIR/bash_completion" ]; then
    . "$NVM_DIR/bash_completion"
  fi
  # 自动使用默认版本
  nvm use default >/dev/null 2>&1
}

# 懒加载函数定义
nvm() { lazy_load_nvm; nvm "$@"; }
node() { lazy_load_nvm; node "$@"; }
npm() { lazy_load_nvm; npm "$@"; }
npx() { lazy_load_nvm; npx "$@"; }
# 不要再手动 export 某个版本路径！！！
# NVM 会自动管理 PATH，无需固定版本


export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"

# JAVA_HOME
# export JAVA_HOME="/opt/homebrew/opt/openjdk@21"
# export PATH="$JAVA_HOME/bin:$PATH"
# export DYLD_LIBRARY_PATH=/opt/homebrew/lib:$DYLD_LIBRARY_PATH

# Go 环境
# 优化：直接指定静态路径，避免调用 $(go env) 产生的外部进程耗时
export GOPATH="$HOME/go"
# GOROOT 通常不需要手动 export，除非你安装了多个 Go 版本
# export GOROOT="$(go env GOROOT)" 

# Go bin 加入 PATH
export PATH="$PATH:$GOPATH/bin"

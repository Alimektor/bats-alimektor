# Always first
source "$(dirname "${BASH_SOURCE[0]}")/src/env.bash"

# Always last
source "$(dirname "${BASH_SOURCE[0]}")/src/print.bash"
source "$(dirname "${BASH_SOURCE[0]}")/src/date.bash"
source "$(dirname "${BASH_SOURCE[0]}")/src/app.bash"

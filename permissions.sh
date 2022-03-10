sudo chown -R "$(whoami)" "$(brew --prefix)/*"
CONFIG_SHELL=/bin/bash ./configure CONFIG_SHELL=/bin/bash
chmod -R u+w $(whoami) /usr/local
chmod -R u+w /usr/local
CONFIG_SHELL=/bin/bash ./configure CONFIG_SHELL=/bin/bash
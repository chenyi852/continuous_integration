#!/bin/bash

TARGET_SH=test.sh

cat >>$TARGET_SH <<EOF
#!/bin/bash

ls
EOF
chmod +x $TARGET_SH 

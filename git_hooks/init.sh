#!/bin/bash
for script in $(ls -1 git_hooks/hooks);
do
  ln -vfs ../../git_hooks/${script} .git/hooks/${script}
done

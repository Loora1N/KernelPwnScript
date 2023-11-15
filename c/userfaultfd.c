void ErrExit(char* err_msg)
{
    puts(err_msg);
    exit(-1);
}

void RegisterUserfault(void *fault_page,void *handler)
{
    pthread_t thr;
    struct uffdio_api ua;
    struct uffdio_register ur;
    uint64_t uffd  = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
    ua.api = UFFD_API;
    ua.features = 0;
    if (ioctl(uffd, UFFDIO_API, &ua) == -1)
        ErrExit("[-] ioctl-UFFDIO_API");

    ur.range.start = (unsigned long)fault_page; //我们要监视的区域
    ur.range.len   = PAGE_SIZE;
    ur.mode        = UFFDIO_REGISTER_MODE_MISSING;
    if (ioctl(uffd, UFFDIO_REGISTER, &ur) == -1) //注册缺页错误处理
        //当发生缺页时，程序会阻塞，此时，我们在另一个线程里操作
        ErrExit("[-] ioctl-UFFDIO_REGISTER");
    //开一个线程，接收错误的信号，然后处理
    int s = pthread_create(&thr, NULL,handler, (void*)uffd);
    if (s!=0)
        ErrExit("[-] pthread_create");
}

size_t usr_cs, usr_rflags, usr_rsp, usr_ss;
void save_status(){
    __asm__("mov usr_cs, cs;"
        "pushf;"
        "pop usr_rflags;"
        "mov usr_rsp, rsp;"
        "mov usr_ss, ss;"
    );
}
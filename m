From: Paul Menage <menage-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: ACPI global lock macros
Date: Tue, 09 Dec 2003 01:22:09 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FD59441.2000202@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Andy,

The ACPI_ACQUIRE_GLOBAL_LOCK() macro in include/asm-i386/acpi.h looks a 
little odd:

#define ACPI_ACQUIRE_GLOBAL_LOCK(GLptr, Acq) \
     do { \
         int dummy; \
         asm("1:     movl (%1),%%eax;" \
             "movl   %%eax,%%edx;" \
             "andl   %2,%%edx;" \
             "btsl   $0x1,%%edx;" \
             "adcl   $0x0,%%edx;" \
             "lock;  cmpxchgl %%edx,(%1);" \
             "jnz    1b;" \
             "cmpb   $0x3,%%dl;" \
             "sbbl   %%eax,%%eax" \
             :"=a"(Acq),"=c"(dummy):"c"(GLptr),"i"(~1L):"dx"); \
     } while(0)


When compiled, it results in:

  266:   mov    0x0,%ecx
                         268: R_386_32   acpi_gbl_common_fACS
  26c:   mov    (%ecx),%eax
  26e:   mov    %eax,%edx
  270:   and    %ecx,%edx
  272:   bts    $0x1,%edx
  276:   adc    $0x0,%edx
  279:   lock cmpxchg %edx,(%ecx)
  27d:   jne    26c <acpi_ev_acquire_global_lock+0x2f>
  27f:   cmp    $0x3,%dl
  282:   sbb    %eax,%eax

So at location 270 we mask %edx with %ecx, which is the address of the 
global lock. Unless the global lock is aligned on a 2-byte but not 
4-byte boundary, which seems a little unlikely, then this is going to 
clear both the owned and the pending bits in %edx, so we'll always think 
that the lock is not owned. Shouldn't the andl be masking with %3 (which 
is initialised as ~1) rather than %2 (the address of the lock)?

Given the comments above the definition, I'm guessing that the "dummy" 
parameter was added later for some reason (to tell gcc that ecx would 
get clobbered? - but it doesn't seem to be clobbered), and the parameter 
substitutions in the asm weren't updated. Unless I'm missing something 
fundamental, shouldn't the definition be something more like this:


#define ACPI_ACQUIRE_GLOBAL_LOCK(GLptr, Acq) \
     do { \
         asm volatile("1:movl   (%1),%%eax;" \
             "movl   %%eax,%%edx;" \
             "andl   %2,%%edx;" \
             "btsl   $0x1,%%edx;" \
             "adcl   $0x0,%%edx;" \
             "lock;  cmpxchgl %%edx,(%1);" \
             "jnz    1b;" \
             "cmpb   $0x3,%%dl;" \
             "sbbl   %0,%0" \
             :"=r"(Acq):"r"(GLptr),"i"(~1L):"dx", "ax"); \
     } while(0)

which compiles to:

  2e5:   mov    0x0,%ecx
                         2e7: R_386_32   acpi_gbl_common_fACS
  2eb:   mov    (%ecx),%eax
  2ed:   mov    %eax,%edx
  2ef:   and    $0xfffffffe,%edx
  2f2:   bts    $0x1,%edx
  2f6:   adc    $0x0,%edx
  2f9:   lock cmpxchg %edx,(%ecx)
  2fd:   jne    2eb <acpi_ev_acquire_global_lock+0x37>
  2ff:   cmp    $0x3,%dl
  302:   sbb    %cl,%cl


which is identical to the ACPI spec reference implementation, apart from 
returning the result in %cl rather than %al (since we're cleanly 
separating clobbered registers from input/output params, and letting gcc 
choose the param registers).

Alternatively it could be defined in C (as in ia64) which would reduce 
the likelihood of asm bugs. (Although it wouldn't be safe to use 
__cmpxchg(), as that uses LOCK_PREFIX which is empty on UP, rather than 
an explicit "lock").

ACPI_RELEASE_GLOBAL_LOCK(), and the x86_64 variants of these, seem to 
have similar issues.

Paul



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/

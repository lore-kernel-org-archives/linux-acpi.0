From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Re: S3 suspend and serial console
Date: Tue, 08 Feb 2005 15:02:28 +0100
Message-ID: <4208C674.1000002@gmx.net>
References: <42023083.8030508@gmx.net> <4204CA50.8090906@gmx.net> <20050205155845.GA20131@hell.org.pl> <20050205220619.GA30739@message-id.gmane0305.slipkontur.de> <4206CF63.2090600@gmx.net> <20050207141655.GB8040@elf.ucw.cz> <42077B07.5090606@gmx.net> <20050207143242.GE8040@elf.ucw.cz> <4207A211.3000305@gmx.net> <20050208125453.GA1622@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050208125453.GA1622-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

Pavel Machek schrieb:
> 
>>Regarding the original problem:
>>It seems the following call is sufficient to make the console work
>>again. However, I haven't found a function which would give me
>>the parameters needed to call ->set_termios.
>>
>>serial/8250.c: serial8250_set_termios
>>
>>Do you have any idea how to obtain the termios and tty structures
>>for a given port, e.g. ttyS0?
> 
> Save some termios passed to it in static variable and than use that
> one as a quick hack...

Yes, that will hopefully work. The hack I'm using right now causes
random oopses, but at least the serial console can display them :-|

--- 1.44/drivers/acpi/sleep/main.c      2005-01-15 23:01:53 +01:00
+++ edited/drivers/acpi/sleep/main.c    2005-02-08 13:16:13 +01:00
@@ -18,6 +18,7 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 #include "sleep.h"
+#include <linux/syscalls.h>

 u8 sleep_states[ACPI_S_STATE_COUNT];

@@ -82,6 +83,7 @@
        acpi_status status = AE_OK;
        unsigned long flags = 0;
        u32 acpi_state = acpi_suspend_states[pm_state];
+       struct file* filp;

        ACPI_FLUSH_CPU_CACHE();

@@ -126,6 +128,8 @@
        if (pm_state > PM_SUSPEND_STANDBY)
                acpi_restore_state_mem();

+       filp = filp_open("/dev/ttyS0", O_WRONLY, 0);
+       filp_close(filp, NULL);

        return ACPI_SUCCESS(status) ? 0 : -EFAULT;
 }

Any idea why that darn thing oopses on me at random locations?

First Oops on suspend:

divide error: 0000 [#1]
Modules linked in: nvram parport_pc lp parport edd cpufreq_userspace speedstep_s
CPU:    0
EIP:    0060:[<c011a8ed>]    Not tainted VLI
EFLAGS: 00000286   (2.6.11-rc3-latest-s3test14)
EIP is at release_console_sem+0x1d/0x90
eax: c0303fc0   ebx: 00000286   ecx: ffffffff   edx: 00005536
esi: fffffe89   edi: 0000003e   ebp: dfd8c200   esp: d97b5db4
ds: 0068   es: 007b   ss: 0068
Process s3script (pid: 8845, threadinfo=d97b4000 task=dd45fa20)
Stack: c01b2744 00000001 00000246 c011a86d d97b5de8 c03abe60 dfb71900 d97b5e08
       c011a757 c02d77a4 d97b5de8 c021b6a5 c02d77a4 c013678f c03abe60 db35c9c0
       00000000 dd45fa20 c0117590 00000000 00000000 c03abe60 00000296 00000296
Call Trace:
 [<c01b2744>] vscnprintf+0x14/0x20
 [<c011a86d>] vprintk+0x10d/0x120
 [<c011a757>] printk+0x17/0x20
 [<c021b6a5>] uart_block_til_ready+0x1a5/0x1b0
 [<c013678f>] request_irq+0x7f/0xb0
 [<c0117590>] default_wake_function+0x0/0x10
 [<c0117590>] default_wake_function+0x0/0x10
 [<c0219c2c>] uart_startup+0x8c/0x120
 [<c021b8d8>] uart_open+0x118/0x140
 [<c0204cc6>] tty_open+0x166/0x2a0
 [<c015b609>] chrdev_open+0xa9/0x140
 [<c0154229>] get_empty_filp+0x59/0xe0
 [<c01529c6>] dentry_open+0x176/0x1e0
 [<c0152840>] filp_open+0x40/0x50
 [<c011a86d>] vprintk+0x10d/0x120
 [<c01f3795>] acpi_pm_enter+0x96/0xac
 [<c013153e>] suspend_enter+0x2e/0x50
 [<c01315ef>] enter_state+0x4f/0x90
 [<c01f380f>] acpi_suspend+0x25/0x32
 [<c01b369a>] copy_from_user+0x3a/0x80
 [<c01f3917>] acpi_system_write_sleep+0x69/0x7a
 [<c0153684>] vfs_write+0xd4/0x130
 [<c0153791>] sys_write+0x41/0x70
 [<c0102e0d>] sysenter_past_esp+0x52/0x75
Code: b5 37 c0 c3 8d 76 00 8d bc 27 00 00 00 00 56 31 f6 53 83 ec 04 eb 14 8d b

Reboot, next try to suspend:

Unable to handle kernel paging request at virtual address fffffe20
 printing eip:
c0152c03
*pde = 00002067
*pte = 00000000
Oops: 0000 [#1]
Modules linked in: nvram parport_pc lp parport cpufreq_userspace speedstep_cents
CPU:    0
EIP:    0060:[<c0152c03>]    Not tainted VLI
EFLAGS: 00010282   (2.6.11-rc3-latest-s3test14)
EIP is at filp_close+0x13/0x90
eax: fffffe00   ebx: fffffe00   ecx: dd1d00c0   edx: 00000000
esi: 00000002   edi: 00000000   ebp: 00000000   esp: d800def8
ds: 0068   es: 007b   ss: 0068
Process s3script (pid: 8754, threadinfo=d800c000 task=df0d2520)
Stack: 00000002 00000003 00000002 00000046 c01f379c 00000000 00000282 00000003
       00000002 c013153e 00000000 00000003 d800df54 c01315ef c02bdaed 00000002
       c02b3088 c01f380f 00000000 00000001 00000000 00000003 00000004 40204000
Call Trace:
 [<c01f379c>] acpi_pm_enter+0x9d/0xac
 [<c013153e>] suspend_enter+0x2e/0x50
 [<c01315ef>] enter_state+0x4f/0x90
 [<c01f380f>] acpi_suspend+0x25/0x32
 [<c01b369a>] copy_from_user+0x3a/0x80
 [<c01f3917>] acpi_system_write_sleep+0x69/0x7a
 [<c0153684>] vfs_write+0xd4/0x130
 [<c0153791>] sys_write+0x41/0x70
 [<c0102e0d>] sysenter_past_esp+0x52/0x75
Code: 89 04 24 e8 40 ff ff ff 83 c4 0c c3 8d b6 00 00 00 00 8d bf 00 00 00 00 8

Is it generally unsafe to call anything during resume?


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

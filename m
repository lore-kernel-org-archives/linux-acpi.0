From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RFC 0/4: make ACPI interpret safe for suspend/resume
Date: Wed, 19 Jan 2005 11:17:00 +0800
Message-ID: <1106104620.12957.270.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
I'm sending the patches not for merging but for comments. We currently
encounter a big issue for suspend/resume. I take S3 for an example, but
S4 (or S4BIOS) is the same. The detail is:
1. PCI link device acts as a sysdev, that means its .resume method will
be executed with IRQ disabled. The .resume method will invoke ACPI _SRS
method, and possibly execute any AML code. The log (at the bottom of the
email) is a failure case caused by this issue.
2. Current suspend/resume code will freeze all processes first and then
start doing suspend/resume. SO 'acpi_pm_prepare', 'acpi_pm_enter' and
acpi_pm_finish' will be invoked with other processes are frozen. The 3
(at least the first and the last ones) will enter ACPI interpret. ACPI
interpret actually will do memory allocating, semaphore handling,
sleeping and memory mapping, the actual actions depend on BIOS. Consider
one case: if a user process acquire an ACPI semaphore but sleep after
suspend, and 'acpi_pm_finish' requires the semaphore, we will have
terrible deadlock.

Case 1 actually isn't severe, I basically think we should remove the PCI
link device suspend/resume code if all PCI driver suspend/resume code
call 'pci_enable_device', which will call acpi_pci_irq_enable' and do
the same thing like the link device resume code. So case 1 actually is
similar with case 2.

Changing ACPI interpret is impossible, since it includes too many code.
Fortunately, all OS dependent code of ACPI interpret is in osl.c, below
patches try to change osl.c and make ACPI interpret safe.
patch 1: introduce a new system state to shadow 'might_sleep' complain.
patch 2: solve the memory allocating issue. we suspend only if there is
enough free memory.
patch 3: solve the acpi_os_sleep issue.
patch 4: solve the semaphore issue. We track the semaphore usage of
ACPICA, and suspend wait till all semaphroes are free.
Unresolved issue is 'acpi_os_memory_mapping' and 'acpi_os_read_memory'.
We possibly must introduce new memory APIs, which will be something like
'atomic_vmap'.
The principle here is we can tolerate suspend failure but we can't
tolerate resume failure. I did test the patches but they are not
matured. Comments and suggestions will be welcome!

Thanks,
Shaohua

P.S. Did anybody know why we should freeze all processes for S3 and
S4BIOS? I checked FreeBSD code, it doesn't. I know it's safer, but if
all device drivers can freeze request to them, it's possibly not
required to me.


Debug: sleeping function called from invalid context at mm/slab.c:2091
in_atomic():0, irqs_disabled():1
 [<c011877f>] __might_sleep+0x8a/0x94
 [<c0146108>] kmem_cache_alloc+0x1b/0x6b
 [<c0205e6c>] acpi_pci_link_set+0x4a/0x1a2
 [<c02062d2>] irqrouter_resume+0x1c/0x24
 [<c0244d97>] sysdev_resume+0x3e/0xa5
 [<c0248066>] device_power_up+0x5/0xa
 [<c01379ce>] suspend_enter+0x25/0x2d
 [<c0137a34>] enter_state+0x37/0x53
 [<c0203417>] acpi_suspend+0x28/0x35
 [<c02034e6>] acpi_system_write_sleep+0x5a/0x6b
 [<c015eecd>] vfs_write+0xba/0x115
 [<c015efc6>] sys_write+0x3c/0x62
 [<c010338b>] syscall_call+0x7/0xb
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 7 (level, low) -> IRQ 7
Restarting tasks... done



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt

From: Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: RFC 0/4: make ACPI interpret safe for suspend/resume
Date: Wed, 19 Jan 2005 18:21:30 +1100
Message-ID: <1106119290.3168.7.camel@nigelcunningham>
References: <1106104620.12957.270.camel@sli10-desk.sh.intel.com>
Reply-To: ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1106104620.12957.270.camel-U5EdaLXB8smDugQYiPIPGdh3ngVCH38I@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

On Wed, 2005-01-19 at 14:17, Li Shaohua wrote:
> Hi,
> I'm sending the patches not for merging but for comments. We currently
> encounter a big issue for suspend/resume. I take S3 for an example, but
> S4 (or S4BIOS) is the same. The detail is:
> 1. PCI link device acts as a sysdev, that means its .resume method will
> be executed with IRQ disabled. The .resume method will invoke ACPI _SRS
> method, and possibly execute any AML code. The log (at the bottom of the
> email) is a failure case caused by this issue.
> 2. Current suspend/resume code will freeze all processes first and then
> start doing suspend/resume. SO 'acpi_pm_prepare', 'acpi_pm_enter' and
> acpi_pm_finish' will be invoked with other processes are frozen. The 3
> (at least the first and the last ones) will enter ACPI interpret. ACPI
> interpret actually will do memory allocating, semaphore handling,
> sleeping and memory mapping, the actual actions depend on BIOS. Consider
> one case: if a user process acquire an ACPI semaphore but sleep after
> suspend, and 'acpi_pm_finish' requires the semaphore, we will have
> terrible deadlock.

I'm not sure that there should be any problem here: processes should
drop semaphores before entering the signal handler on the way to the
freezer, shouldn't they? Have any freezes been observed relating to
these calls?

> Case 1 actually isn't severe, I basically think we should remove the PCI
> link device suspend/resume code if all PCI driver suspend/resume code
> call 'pci_enable_device', which will call acpi_pci_irq_enable' and do
> the same thing like the link device resume code. So case 1 actually is
> similar with case 2.
> 
> Changing ACPI interpret is impossible, since it includes too many code.
> Fortunately, all OS dependent code of ACPI interpret is in osl.c, below
> patches try to change osl.c and make ACPI interpret safe.
> patch 1: introduce a new system state to shadow 'might_sleep' complain.

Pavel knows far better than me here, so I will leave it to him to
comment.

> patch 2: solve the memory allocating issue. we suspend only if there is
> enough free memory.

This one shouldn't be a problem either. Pavel, do you still have the
half-of-memory limit? It is certainly redundant in my case - I already
make sure the number of available pages is much higher than 100.

> patch 3: solve the acpi_os_sleep issue.

Does this interact with the recent patches for the pic suspend/resume
code? If so, how?

> patch 4: solve the semaphore issue. We track the semaphore usage of
> ACPICA, and suspend wait till all semaphroes are free.
> Unresolved issue is 'acpi_os_memory_mapping' and 'acpi_os_read_memory'.
> We possibly must introduce new memory APIs, which will be something like
> 'atomic_vmap'.

(See above)

> The principle here is we can tolerate suspend failure but we can't
> tolerate resume failure. I did test the patches but they are not
> matured. Comments and suggestions will be welcome!

Hope mine are helpful.

> Thanks,
> Shaohua
> 
> P.S. Did anybody know why we should freeze all processes for S3 and
> S4BIOS? I checked FreeBSD code, it doesn't. I know it's safer, but if
> all device drivers can freeze request to them, it's possibly not
> required to me.

I'll leave this one for Pavel too.

Nigel
-- 
Nigel Cunningham
Software Engineer
Cyclades Corporation

http://cyclades.com



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt

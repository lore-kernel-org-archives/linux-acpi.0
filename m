From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: RFC 0/4: make ACPI interpret safe for suspend/resume
Date: Wed, 19 Jan 2005 15:55:23 +0800
Message-ID: <1106121323.13181.31.camel@sli10-desk.sh.intel.com>
References: <1106104620.12957.270.camel@sli10-desk.sh.intel.com>
	 <1106119290.3168.7.camel@nigelcunningham>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1106119290.3168.7.camel@nigelcunningham>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Cc: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2005-01-19 at 15:21, Nigel Cunningham wrote:
> Hi.
> 
> On Wed, 2005-01-19 at 14:17, Li Shaohua wrote:
> > Hi,
> > I'm sending the patches not for merging but for comments. We currently
> > encounter a big issue for suspend/resume. I take S3 for an example, but
> > S4 (or S4BIOS) is the same. The detail is:
I would correct, this affects S3 and S4BIOS. But if PCI link device is a
sysdev (so S4 will call its resume method), it also affects S4, but main
effect is for S3.
 
> > 1. PCI link device acts as a sysdev, that means its .resume method will
> > be executed with IRQ disabled. The .resume method will invoke ACPI _SRS
> > method, and possibly execute any AML code. The log (at the bottom of the
> > email) is a failure case caused by this issue.
> > 2. Current suspend/resume code will freeze all processes first and then
> > start doing suspend/resume. SO 'acpi_pm_prepare', 'acpi_pm_enter' and
> > acpi_pm_finish' will be invoked with other processes are frozen. The 3
> > (at least the first and the last ones) will enter ACPI interpret. ACPI
> > interpret actually will do memory allocating, semaphore handling,
> > sleeping and memory mapping, the actual actions depend on BIOS. Consider
> > one case: if a user process acquire an ACPI semaphore but sleep after
> > suspend, and 'acpi_pm_finish' requires the semaphore, we will have
> > terrible deadlock.
> 
> I'm not sure that there should be any problem here: processes should
> drop semaphores before entering the signal handler on the way to the
> freezer, shouldn't they? Have any freezes been observed relating to
> these calls?
The semaphores actually are in kernel (in ACPI interpret). A process can
sleep with semaphore hold (in kernel), how it knows to drop semaphores
before entering the freeze fake signal handler? The case is one
userspace task request some ACPI services and sleep or switched out in
kernel after get ACPI semaphores. Am I completely missing anything? No,
I didn't observe any failure case caused by this one, it's potential.

> > Case 1 actually isn't severe, I basically think we should remove the PCI
> > link device suspend/resume code if all PCI driver suspend/resume code
> > call 'pci_enable_device', which will call acpi_pci_irq_enable' and do
> > the same thing like the link device resume code. So case 1 actually is
> > similar with case 2.
> > 
> > Changing ACPI interpret is impossible, since it includes too many code.
> > Fortunately, all OS dependent code of ACPI interpret is in osl.c, below
> > patches try to change osl.c and make ACPI interpret safe.
> > patch 1: introduce a new system state to shadow 'might_sleep' complain.
> 
> Pavel knows far better than me here, so I will leave it to him to
> comment.
> 
> > patch 2: solve the memory allocating issue. we suspend only if there is
> > enough free memory.
> 
> This one shouldn't be a problem either. Pavel, do you still have the
> half-of-memory limit? It is certainly redundant in my case - I already
> make sure the number of available pages is much higher than 100.
Yep, S4 has freed memory before suspend, but S3 doesn't.

> > patch 3: solve the acpi_os_sleep issue.
> 
> Does this interact with the recent patches for the pic suspend/resume
> code? If so, how?
Which patch does you point to? The one just is related with case 1, but
as I said case 1 can be resolved by other way, so this patch isn't
required in future.
> 
> > patch 4: solve the semaphore issue. We track the semaphore usage of
> > ACPICA, and suspend wait till all semaphroes are free.
> > Unresolved issue is 'acpi_os_memory_mapping' and 'acpi_os_read_memory'.
> > We possibly must introduce new memory APIs, which will be something like
> > 'atomic_vmap'.
> 
> (See above)
Do you mean the memory allocation issue? The acpi_os_memory_mapping uses
ioremap, I'm afraid there is no free VMA space in resume time.
> 
> > The principle here is we can tolerate suspend failure but we can't
> > tolerate resume failure. I did test the patches but they are not
> > matured. Comments and suggestions will be welcome!
> 
> Hope mine are helpful.
I'm very appreciated with your replay, Nigel!

Thanks,
Shaohua



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt

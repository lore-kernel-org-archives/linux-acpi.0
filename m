From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: RFC 0/4: make ACPI interpret safe for suspend/resume
Date: Thu, 20 Jan 2005 09:28:16 +0800
Message-ID: <1106184495.13181.68.camel@sli10-desk.sh.intel.com>
References: <1106104620.12957.270.camel@sli10-desk.sh.intel.com>
	 <20050119101858.GE25623@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050119101858.GE25623-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2005-01-19 at 18:18, Pavel Machek wrote:
> > I'm sending the patches not for merging but for comments. We currently
> > encounter a big issue for suspend/resume. I take S3 for an example, but
> > S4 (or S4BIOS) is the same. The detail is:
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
> Actually, this should not ever happen. Refrigerator only hits at
> specific places, where we *know* no semaphores are held. If you can
> find a counterexample, that's a bug to be fixed.
Ok, I now understand it. I made a big mistake. Thanks correcting me,
Pavel & Nigel.

> > Changing ACPI interpret is impossible, since it includes too many code.
> > Fortunately, all OS dependent code of ACPI interpret is in osl.c, below
> > patches try to change osl.c and make ACPI interpret safe.
> > patch 1: introduce a new system state to shadow 'might_sleep'
> > complain.
> 
> Ask akpm about this one (I once tried to add 4 or so system states to
> solve driver model problem, and it was vetoed. One state actually
> makes more sense, but... ask akpm, cc me). But you should better be
> able to write comment describing how is STATE_SUSPEND different from
> other states.
Ok, I will do it.

> [Or perhaps you want this variable to be acpi-local?]
For the memory allocating issue and semaphore issue, we actually can not
use the new system state, we can just do:
if (in_atomic() || in_interrupt())
	kmalloc(.., GFP_ATOMIC)
But this possibly will mask some real runtime errors, so we want to add
a new system state to make suspend/resume work and not break normal
process. But If new system state is a bad idea, we can make it
acpi-local.

> > patch 4: solve the semaphore issue. We track the semaphore usage of
> > ACPICA, and suspend wait till all semaphroes are free.
> > Unresolved issue is 'acpi_os_memory_mapping' and 'acpi_os_read_memory'.
> > We possibly must introduce new memory APIs, which will be something like
> > 'atomic_vmap'.
> 
> Process holding semaphore should not be able to enter
> refrigerator. Can you track down how that can happen?
> 
> > P.S. Did anybody know why we should freeze all processes for S3 and
> > S4BIOS? I checked FreeBSD code, it doesn't. I know it's safer, but if
> > all device drivers can freeze request to them, it's possibly not
> > required to me.
> 
> Freezing all processes should not be required. 
How about just make suspend/resume task as a highest priority task with
FIFO scheduler policy? just like the stop_machine_run does. Actually we
have some idea that make stop_machine_run work for UP, and use it in
suspend/resume (so no refrigerator is required).
> I added it for i386
> (BenH is not doing it on ppc) because I felt I do not want driver
> authors to have to care about concurent userspace accesses. Like if
> you are suspending and do ifconfig while machine is suspending, you do
> not want to see network interface in the down state.
> We could say "it is the driver problem
Yep, this makes sense to me.
Thanks your comments.

Shaohua



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl

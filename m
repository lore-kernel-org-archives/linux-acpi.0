From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: RFC 0/4: make ACPI interpret safe for suspend/resume
Date: Wed, 19 Jan 2005 11:18:58 +0100
Message-ID: <20050119101858.GE25623@elf.ucw.cz>
References: <1106104620.12957.270.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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
Cc: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

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

Actually, this should not ever happen. Refrigerator only hits at
specific places, where we *know* no semaphores are held. If you can
find a counterexample, that's a bug to be fixed.

> Changing ACPI interpret is impossible, since it includes too many code.
> Fortunately, all OS dependent code of ACPI interpret is in osl.c, below
> patches try to change osl.c and make ACPI interpret safe.
> patch 1: introduce a new system state to shadow 'might_sleep'
> complain.

Ask akpm about this one (I once tried to add 4 or so system states to
solve driver model problem, and it was vetoed. One state actually
makes more sense, but... ask akpm, cc me). But you should better be
able to write comment describing how is STATE_SUSPEND different from
other states.

[Or perhaps you want this variable to be acpi-local?]

> patch 4: solve the semaphore issue. We track the semaphore usage of
> ACPICA, and suspend wait till all semaphroes are free.
> Unresolved issue is 'acpi_os_memory_mapping' and 'acpi_os_read_memory'.
> We possibly must introduce new memory APIs, which will be something like
> 'atomic_vmap'.

Process holding semaphore should not be able to enter
refrigerator. Can you track down how that can happen?

> P.S. Did anybody know why we should freeze all processes for S3 and
> S4BIOS? I checked FreeBSD code, it doesn't. I know it's safer, but if
> all device drivers can freeze request to them, it's possibly not
> required to me.

Freezing all processes should not be required. I added it for i386
(BenH is not doing it on ppc) because I felt I do not want driver
authors to have to care about concurent userspace accesses. Like if
you are suspending and do ifconfig while machine is suspending, you do
not want to see network interface in the down state.

We could say "it is the driver problem".
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt

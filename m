From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 1/6]sep initializing rework
Date: Wed, 13 Apr 2005 09:39:19 +0800
Message-ID: <1113356358.7148.27.camel@sli10-desk.sh.intel.com>
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04AB0@USRV-EXCH4.na.uis.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04AB0-wTIArdAVPtsEm5531iEKmc1LmFYJkIXwVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Protasevich, Natalie" <Natalie.Protasevich-8PZ5lytb3wbQT0dZR+AlfA@public.gmane.org>
Cc: Zwane Mwaikambo <zwane-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Ryan Harper <ryanh-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, hotplug_sig-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, Joel Schopp <jschopp-V7BBcbaFuwjMbYB6QlFGEg@public.gmane.org>, Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2005-04-13 at 01:57, Protasevich, Natalie wrote:
> Hello,
> This is a hotplug CPU patch for i386, done against 2.6.12-rc2-mm3.
> Somewhat alternative to the one posted by Li Shaohua, but not really
> (and I didn't mean that :). If you look closer, our patches are
> different and can complement each other I think. Li did great job on
> sep, after-offline cleanup, __devinit etc., and I have some radical
> changes in the AP bringup mechanism. I left alone __init to __devinit
> part (I was going through it lately, but I think even though I had few
> more than Li did, he covered it sufficiently perhaps). I started
> having
> doubts in free_initmem() vs __devinit because look how many of
> __init's
> left! just a few :). 
Looks quite smart, but people will argue it will keep all __init
sections in this way. I'd like we keep the default behavior of __init. 

> I got rid of do_boot_cpu loop in smpboot.c because
> the loop
> static void __init smp_init(void)
> {
>         unsigned int i;
> 
>         /* FIXME: This should be done in userspace --RR */
>         for_each_present_cpu(i) {
>                 if (num_online_cpus() >= max_cpus)
>                         break;
>                 if (!cpu_online(i))
>                         cpu_up(i);
>         }
> ...
> does it again so why leave it in smpboot.c to boot AP's twice. 
This is what IA64 does. In this way, you must clean up the bogomips
message, TSC synchronization. And CPU_UP could be called in user
context, so fork_idle possibly should be in workqueue. And please make
sure it doesn't break other things like check_nmi_watchdog. I just
select an easy way (add smp_prepare_cpu) and it doesn't break anything. 

> I also
> found that my system fails sooner or later when I try not to synch
> runtime booted processor with others, so I changed tsc synchronization
> to only sync between booting CPU and the one that boots it. 
IA64 also does like this. It synchronizes one AP's ITC against BP's one
time. But in IA32, TSC's upper 32 bits can be written only on prescott
and above. In earlier CPU, upper 32 bits will become 0 after any write.

> The patch
> works for me on Intel 8x generic box, and on ES7000. I was asked to
> separate my patch into smaller ones by the theme, but I'm posting the
> entire patch for now, because I think it is probably not the final
> one.
> I think (I hope) I will sync up with Li later on.
> My idea was that if we find a CPU core in ACPI (enabled or disabled),
> we
> encounter for it in sibling map and create a sysfs node accordingly,
> and
> cpu_possible_map will reflect that. We take processors up/down
> depending
> on physical presence using the existing node. That's the scenario
> implemented on ES7000 that reports all possible cores in ACPI marking
> absent processors as disabled. Runtime enablement/disablement depends
> on
> sysfs only and the driving agent can be anything (ACPI or user) that
> triggers sysfs node for this processor.
You possibly can refer to IA64's implementation. The goal of my patches
are to support suspend/resume, which actually doesn't really hotremove a
CPU, so I just ignored the sysfs/ACPI issues.

Thanks,
Shaohua

> 
> -----Original Message-----
> From: Zwane Mwaikambo [mailto:zwane-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org] 
> Sent: Tuesday, April 12, 2005 6:08 AM
> To: Li Shaohua
> Cc: lkml; ACPI-DEV; Len Brown; Pavel Machek; Andrew Morton;
> Protasevich,
> Natalie; Ryan Harper
> Subject: Re: [PATCH 1/6]sep initializing rework
> 
> Hello Shaohua,
> 
> On Tue, 12 Apr 2005, Li Shaohua wrote:
> 
> > These patches (together with 5 patches followed this one) are
> updated 
> > suspend/resume SMP patches. The patches fixed some bugs and do clean
> > up as suggested. Now they work for both suspend-to-ram and
> suspend-to-disk.
> > Patches are against 2.6.12-rc2-mm3.
> 
> These patches look good and i think we should go ahead with them. I've
> also cross checked with physical hotplug cpu patches for ES7xxx from
> Natalie (added to Cc) and it does indeed look like a lot of the code
> will work for her too, but i'd appreciate it if she also does a double
> check. 
> Obviously this won't work for other upcoming users of hotplug cpu like
> Xen (Ryan added to Cc) but i think we can abstract things later on to
> cover other special users.
> 
> Thanks Shaohua,
>         Zwane
> 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
